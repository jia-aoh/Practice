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
    select 'You had deleted collection successfully.';
  else
    insert into `Collection` (user_id, series_id)
    values (p_user_id, p_series_id);
    select 'You had add into collection successfully.';
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
  -- 查詢餘額
  call GetPricePerProductBySeriesId(p_series_id, PricePerProduct);
  call GetGashNowByIdOutRemain(p_user_id, RemainGash);
  if RemainGash < (p_purchase_id * PricePerProduct) then 
    select 'Insufficient Gachora Point. Please top up your account.' as error;
    leave flag;
  end if;
  -- 獲取機台剩餘數量
  call GetMachineRemain(p_series_id, RemainProduct);
  -- 若購買數>剩餘，回彈"機台剩餘不足，修改選購數量"
  if p_purchase_id > RemainProduct then 
    select 'Insufficient products in machine. Please adjust your purchase quantity.' as error;
    leave flag;
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
  call PrintResult(p_time);
  -- 有剩離開
  call GetMachineRemain(p_series_id, RemainProductEnd);
  if RemainProductEnd > 0 then 
    select 'done, remain' as error;
    leave flag;
  end if;
  -- 沒剩如果庫存 > 0補機台
  select stock into StockRemain from Series where id = p_series_id;
  if StockRemain > 0 then
    call Refill(p_series_id);
    update Series 
    set stock = stock - 1 
    where id = p_series_id;
    select 'refill done' as error;
    leave flag;
  end if;
end ;;
delimiter;
