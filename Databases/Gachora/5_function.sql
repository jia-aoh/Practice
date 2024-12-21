drop procedure if exists UpdateCollectionByUserSeries;
delimiter ;;
create procedure UpdateCollectionByUserSeries(in p_user_id int, in p_series_id int)
begin
  DECLARE record_exists int;
  
  select count(*) into record_exists
  from `Collection` 
  where user_id = p_user_id and series_id = p_series_id;
  if record_exists > 0 then
    delete from `Collection` 
    where user_id = p_user_id and series_id = p_series_id;
    select false;
  else
    insert into `Collection` (user_id, series_id)
    values (p_user_id, p_series_id);
    select true;
  end if;
end ;;
delimiter;

drop procedure if exists AlterCollectionStatusByUserSeriesStatus;
delimiter ;;
create procedure AlterCollectionStatusByUserSeriesStatus(in p_user_id int, in p_series_id int, in p_status_id int)
begin
  declare record_exists int;

  select count(*) into record_exists
  from Collection
  where user_id = p_user_id and series_id = p_series_id;
  if record_exists > 0 then
    update Collection
    set notification_status = p_status_id
    where user_id = p_user_id AND series_id = p_series_id;
    select 'You had add add the reminder successfully.';
  else
    insert into Collection (user_id, series_id, notification_status)
    values (p_user_id, p_series_id, p_status_id);
    select 'You had add add the reminder successfully.';
  end if;
end ;;
delimiter;

-- 查machine剩餘
drop procedure if exists GetMachineRemain;
delimiter ;;
create procedure GetMachineRemain(in p_series_id int, out remain int)
begin
  select sum(m.remain) into remain
  from(
      select id
  	  from Series 
  	  where id = p_series_id
  )as s 
  left join Characters c on s.id = c.series_id
  left join Machine m on c.id = m.character_id
  group by series_id;
end ;;
delimiter;

-- 系列單價
drop procedure if exists GetPricePerProductBySeriesId;
delimiter ;;
create procedure GetPricePerProductBySeriesId(in p_series_id int, out p_price int)
begin
  select price into p_price
  from Series s
  left join Price p on s.price_id = p.id
  where s.id = p_series_id;
end ;;
delimiter;

-- 隨機函數
drop procedure if exists rand;
delimiter ;;
create procedure rand(in p_series_id int, out p_character_id int)
begin
SET @total_weight = (
select sum(m.remain) 
from(
	select id
	from Characters
    where series_id = p_series_id
  ) as c
  left join Machine m on c.id = m.character_id
WHERE m.remain > 0);

SET @random_weight = FLOOR(1 + RAND() * @total_weight);
select c.id into p_character_id
from(
  	select id
	  from Characters
	  where series_id = p_series_id
  ) as c
left join Machine m on c.id = m.character_id
where remain > 0 and (@random_weight := @random_weight - remain) <= 0
limit 1;
end ;;
delimiter;

-- 扣機台
drop procedure if exists MinusOneFromMachine;
delimiter ;;
create procedure MinusOneFromMachine(in p_character_id int)
begin
  update machine 
  set remain = remain - 1 
  where character_id = p_character_id;
end ;;
delimiter;
-- 加入購買紀錄
drop procedure if exists AddRecord;
delimiter ;;
create procedure AddRecord(in p_user_id int, in p_character_id int, in p_time int, in p_label int)
begin 
  insert into Records (user_id, character_id, time, label, status_id)
  values (p_user_id, p_character_id, p_time, p_label, 4);
end ;;
delimiter;
-- 填充
drop procedure if exists Refill;
delimiter ;;
create procedure Refill(in p_series_id int)
begin
update Machine
set remain = amount
where character_id in (
  select id
  from Characters
	where series_id = p_series_id);
end ;;
delimiter;
-- 回傳結果
drop procedure if exists PrintResult;
delimiter ;;
create procedure PrintResult(in p_time int)
begin
  select c.name, c.img, count(c.id) amount
  from(
    select character_id 
    from Records 
    where time = p_time
  )as r
  left join Characters c on r.character_id = c.id 
  group by c.id;
end ;;
delimiter;

-- ----------
-- 總扭蛋
drop procedure if exists PlayEgg;
delimiter ;;
create procedure PlayEgg(
  in p_user_id int, 
  in p_series_id int, 
  in p_purchase_id int, 
  in p_time int
)
flag: begin 
  declare i int default 0;
  declare RemainGash int;
  declare RemainProduct int;
  declare RemainProductEnd int;
  declare PricePerProduct int;
  declare RandomCharacterId int;
  declare StockRemain int;
  -- 查詢餘額 00 前php要給purchase(number, series, time)
  call GetPricePerProductBySeriesId(p_series_id, PricePerProduct);
  call GetGashNowByIdOutRemain(p_user_id, RemainGash);
  if RemainGash < (p_purchase_id * PricePerProduct) then 
    select 'G Point not enough. Please buy points.' as error;
    leave flag;
  end if;
  -- 獲取機台剩餘數量
  start transaction; 
  -- call GetMachineRemain(p_series_id, RemainProduct) for update;
    select sum(m.remain) into RemainProduct
  from(
      select id
  	  from Series 
  	  where id = p_series_id
  )as s 
  left join Characters c on s.id = c.series_id
  left join Machine m on c.id = m.character_id
  group by series_id 
  for update;
  -- 若購買數>剩餘，回彈"機台剩餘不足，修改選購數量"
  if p_purchase_id > RemainProduct then 
    select 'Products not enough. Please adjust quantity.' as error;
    rollback;
    leave flag;
  end if;
  -- 看有無禮金
  call SeeGift(p_user_id, p_time, RemainGift);
  if RemainGift > 0 then 
    -- 扣禮金
    call AdjustGift(p_user_id, p_time, RemainGift);
  end if;
  -- 足->隨機生成
  while i < p_purchase_id do 
    call rand(p_series_id, RandomCharacterId);
    -- 扣機台
    call MinusOneFromMachine(RandomCharacterId);
    -- 加入record
    call AddRecord(p_user_id, RandomCharacterId, p_time, 0);
    set i = i + 1;
  end while;
  commit;
  call PrintResult(p_time);
  -- 有剩離開
   start transaction; 
  -- call GetMachineRemain(p_series_id, RemainProductEnd) for update;
    select sum(m.remain) into RemainProductEnd
  from(
      select id
  	  from Series 
  	  where id = p_series_id
  )as s 
  left join Characters c on s.id = c.series_id
  left join Machine m on c.id = m.character_id
  group by series_id 
  for update;
  if RemainProductEnd > 0 then 
    select 'done, still remain' as error;
    rollback;
    leave flag;
  end if;
  -- 沒剩如果庫存 > 0補機台
  select stock into StockRemain from Series where id = p_series_id;
  if StockRemain > 0 then
    call Refill(p_series_id);
    update Series 
    set stock = stock - 1, end_time = p_time
    where id = p_series_id;
    select 'refill done' as error;
    commit;
    leave flag;
  end if;
end ;;
delimiter;
-- 排隊
drop procedure if exists GetInLine;
delimiter ;;
create procedure GetInLine(in p_series_id int, in p_user_id int, in p_number int, in p_time int)
begin 
  insert into Waitinglist (series_id, user_id, number, wait)
  values (p_series_id, p_user_id, p_number, p_time);
end ;; 
delimiter;

-- 查看最長等待時間(秒)
drop procedure if exists SeeWaitTime;
delimiter ;;
create procedure SeeWaitTime(in p_series_id int, in p_number_id int)
begin 
  declare RemainTime int;
  -- 剩多少時間
  select wait + 190 * (count(series_id) -1) - unix_timestamp(now()) into RemainTime
  from Waitinglist 
  where series_id = p_series_id and number < p_number_id + 1
  order by wait desc;
    -- 還要等
    if RemainTime > 0 then 
      select p_number_id as yournumber, RemainTime as waiting;
    -- 開始抽，刪除過號
    elseif RemainTime <= 0 then 
      call DeleteWaiting(p_series_id, p_number_id - 1);
      select p_number_id as yournumber, RemainTime as waiting;
    -- 超時
    elseif RemainTime < -190 then
      call DeleteWaiting(p_series_id, p_number_id);
      select 'times up' as error;
  end if;
end ;;
delimiter;

-- 取消排隊
drop procedure if exists DeleteWaiting;
delimiter ;;
create procedure DeleteWaiting( in p_series_id int, in p_number_id int)
begin 
  declare WhosFirst int;
  declare HasTime int;

  delete from Waitinglist 
  where series_id = p_series_id and number <= p_number_id;
  -- 如果等待者抽完，改下一位起始時間
  select number into WhosFirst
  from Waitinglist 
  where series_id = p_series_id
  order by number 
  limit 1;

  select wait into HasTime
  from Waitinglist
  where number = WhosFirst;

  if HasTime = 0 and p_number_id < WhosFirst then
    update Waitinglist 
    set wait = unix_timestamp(now())
    where number = WhosFirst;
  end if;
  -- 中離不改第一位時間
end ;;
delimiter;

-- 一番賞排隊
drop procedure if exists LineUp;
delimiter ;;
create procedure LineUp(in p_series_id int, in p_user_id int)
flag:begin 
  declare ListNumbers int;
  declare UserExists int;
  declare LastNumber int;
  declare p_number_id int;

-- 會員點排隊
-- 查有沒有排隊紀錄
  select count(series_id) into ListNumbers
  from Waitinglist 
  where series_id = p_series_id;

  if ListNumbers > 0 then 
    select count(series_id) into UserExists
    from Waitinglist
    where series_id = p_series_id and user_id = p_user_id;
    -- 排隊
    if UserExists = 0 then 
      select number into LastNumber 
      from Waitinglist 
      where series_id = p_series_id
      order by number desc
      limit 1;
      call GetInLine(p_series_id, p_user_id, LastNumber + 1, 0);
    -- 重排不理
    else 
      select number into p_number_id
      from Waitinglist
      where series_id = p_series_id and user_id = p_user_id;
      call SeeWaitTime(p_series_id, p_number_id);
      leave flag;
    end if;
  else
    -- 第一位
    call GetInLine(p_series_id, p_user_id, 1, unix_timestamp(now()));
  end if;
  -- 印出編號、最晚時間
  select ifnull(LastNumber, 0) + 1 yournumber, ifnull(wait + 190 * (count(series_id) -1) - unix_timestamp(now()), 0) waiting
  from Waitinglist 
  where series_id = p_series_id and number < ifnull(LastNumber, 0) + 2
  order by wait desc;
end ;;
delimiter;

-- 到帳
drop procedure if exists GashHasIn;
delimiter ;;
create procedure GashHasIn(in p_user_id int, in p_time int, in p_gash_id int)
begin 
  update Bill
  set update_at = p_time
  where id = (
    select id 
    from Bill
    where user_id = p_user_id
    and gash_id = p_gash_id
    and update_at is null
    order by create_at
    limit 1
    );
end ;;
delimiter;

-- 儲值
drop procedure if exists TopUpGash;
delimiter ;;
create procedure TopUpGash(in p_user_id int, in p_time int, in p_gash_id int)
begin 
  insert into Bill(user_id, create_at, gash_id)
  values (p_user_id, p_time, p_gash_id);
  call GashHasIn(p_user_id, p_time, p_gash_id);
  select 'done' as error;
end ;;
delimiter;

-- 查看有無禮金
drop procedure if exists SeeGift;
delimiter ;;
create procedure SeeGift(in p_user_id int, in p_time int, out RemainGift int)
begin 
  select sum(amount) into RemainGift
  from Gift 
  where user_id = p_user_id and p_time < expire_at;
end ;;
delimiter;

-- 先扣禮金
drop procedure if exists AdjustGift;
delimiter ;;
create procedure AdjustGift(
  in p_user_id int, 
  in p_time int, 
  in p_price int
)
begin 
  declare done int default false;
  declare amounts int;
  declare cur cursor for select amount from Gift 
  where user_id = p_user_id and expire_at > p_time
  order by expire_at;
  declare continue handler for not found set done = true;

  open cur;
  flag: loop
    fetch cur into amounts;
    if done then 
      leave flag;
    end if;
    if amounts <= p_price then 
      set p_price = p_price - amounts;
      update Gift 
      set amount = 0 
      where user_id = p_user_id 
      and amount = amounts
      and expire_at > p_time
      limit 1;
    else 
      update Gift 
      set amount = amount - p_price
      where user_id = p_user_id 
      and expire_at > p_time
      and amount = amounts
      limit 1;
      leave flag;
    end if;
  end loop;
  close cur;
end ;;
delimiter;

-- 一番賞
drop procedure if exists PlayIchiban;
delimiter ;;
create procedure PlayIchiban (
  in p_series_id int, 
  in p_number int, 
  in p_purchase int, 
  in p_label text, 
  in p_time int
)
flag:begin 
  declare i int default 0;
  declare PricePerProduct int;
  declare RemainGash int;
  declare RandomCharacterId int;
  declare p_user_id int;
  declare RemainProductEnd int;
  declare StockRemain int;
  declare LabelValue text;
  declare RemainGift int;
  -- 查詢餘額
  start transaction;
  

  call GetPricePerProductBySeriesId(p_series_id, PricePerProduct);
  -- 生成對應p_user_id from number
  select user_id into p_user_id
  from Waitinglist
  where number = p_number and series_id = p_series_id;
  call GetGashNowByIdOutRemain(p_user_id, RemainGash);
  if RemainGash < (p_purchase * PricePerProduct) then 
    select 'G Point not enough. Please buy points.' as error;
    rollback;
    leave flag;
  end if;
  -- 看有無禮金
  call SeeGift(p_user_id, p_time, RemainGift);
  if RemainGift > 0 then 
  -- 扣禮金
    call AdjustGift(p_user_id, p_time, RemainGift);
  end if;

  -- 要確認為最小號碼?
  -- text變array
  -- set @labels_array = split(p_label, ',');
  -- 隨機生成
  while i < p_purchase do 
    set LabelValue = cast(json_unquote(json_extract(p_label, concat('$[', i ,']'))) as unsigned);
    call rand(p_series_id, RandomCharacterId);
    -- 扣機台
    call MinusOneFromMachine(RandomCharacterId);
    -- 加入record
    call AddRecord(p_user_id, RandomCharacterId, p_time, LabelValue);
    set i = i + 1;
  end while;
  call PrintResult(p_time);
  -- 有剩離開
  -- call GetMachineRemain(p_series_id, RemainProductEnd) for update;
  select sum(m.remain) into RemainProductEnd
  from(
      select id
  	  from Series 
  	  where id = p_series_id
  )as s 
  left join Characters c on s.id = c.series_id
  left join Machine m on c.id = m.character_id
  group by series_id 
  for update;
  if RemainProductEnd > 0 then 
    -- select 'done, still remain' as error;
    commit;
    leave flag;
  end if;
  -- 沒剩如果庫存 > 0補機台
  select stock into StockRemain from Series where id = p_series_id;
  if StockRemain > 0 then
    call Refill(p_series_id);
    update Series 
    set stock = stock - 1,  end_time = p_time
    where id = p_series_id;
    -- select 'refill done' as error;
    commit;
    leave flag;
  end if;
end ;;
delimiter;

drop procedure if exists GetWaitTimeById;
delimiter ;;
create procedure GetWaitTimeById(in p_user_id int)
begin 
  create temporary table if not exists MyWaitList(
    series_id int, 
    number int
  );
  insert into MyWaitList(series_id, number)
  select series_id, number
  from Waitinglist 
  where user_id = p_user_id;

  select m.series_id, s.name series_name, m.number, (wait + 190 * (COUNT(w.series_id) - 1) - UNIX_TIMESTAMP(NOW())) waiting
  from Waitinglist w
  left join MyWaitList m on w.series_id = m.series_id
  left join Series s on w.series_id = s.id
  where w.number < m.number + 1
  group by m.series_id
  order by waiting;
end ;;
delimiter;

-- 換status
drop procedure if exists ChangeStatusByIdAndStatus;
delimiter ;;
create procedure ChangeStatusByIdAndStatus (in p_record_id int, in p_status_id int)
begin 
  update Records 
  set status_id = p_status_id
  where id = p_record_id;
end ;;
delimiter;

-- 禮過期處理 if gift now > expiredate, update_at < expire
drop procedure if exists ExpireGiftToG;
delimiter ;;
create procedure ExpireGiftToG (in p_user_id int, in p_time int)
begin 
  declare p_gash int;
  declare probable_time int;


  update Gift 
  set update_at = p_time
  where expire_at > update_at;
  -- 把剩餘填到toG
  create temporary table if not exists MyExpireList(
    character_id int, 
    amount int
  );
  insert into MyExpireList(amount, character_id)
  select amount, category_id + 10
  from Gift 
  where update_at = p_time;

  start transaction;

  select sum(amount) into p_gash
  from MyExpireList;

  if p_gash = 0 then
    rollback;
  end if;
 
  select expire_at - 2678400 into probable_time
  from Gift 
  where update_at = p_time
  order by expire_at
  limit 1;

  insert into ToG(gash, record_id, time)
  select amount, r.record_id, p_time
  from MyExpireList m
  join
    (
    select id record_id, character_id
    from Records
    where user_id = p_user_id 
    and character_id in (14, 15) 
    and time > probable_time
    ) as r
  on m.character_id = r.character_id;
  commit;
end ;;
delimiter;
