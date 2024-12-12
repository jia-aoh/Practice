-- procedure
drop procedure if exists GetAmountById;
delimiter $$
create procedure GetAmountById(in p_series_id int)
begin 
select sum(remain) remain, sum(amount) total 
from vw_RemainTotal 
where series_id = p_series_id
group by series_id;
end $$ 
delimiter;

drop procedure if exists GetLabelById;
delimiter ;;
create procedure GetLabelById(in p_series_id int)
begin
select label from (select id, series_id from Characters c where series_id = p_series_id) as tmp
left join Records r on tmp.id = r.character_id where time > (SELECT end_time FROM Series WHERE id = p_series_id);
end ;;
delimiter;

drop procedure if exists GetGiftExpireDateById;
delimiter ;;
create procedure GetGiftExpireDateById(in p_user_id int)
begin
select amount gift, expire_at from gift 
where user_id = p_user_id and expire_at > UNIX_TIMESTAMP(NOW())
order by expire_at;
end ;; 
delimiter;

drop procedure if exists GetRecordsByIdAndCategory;
delimiter ;;
create procedure GetRecordsByIdAndCategory(in p_user_id int, in p_category_id int)
begin
select r.user_id user_id, c.img img, s.category_id category_id
from Records r
left join Characters c on r.character_id = c.id
left join Series s on c.series_id = s.id
where user_id = p_user_id and category_id = p_category_id
group by c.img;
end ;;
delimiter;

drop procedure if exists GetUserNameById;
delimiter ;;
create procedure GetUserNameById(in p_user_id int)
begin
select name from Users where id = p_user_id;
end ;; 
delimiter;

drop procedure if exists GetGashNowById;
delimiter ;;
create procedure GetGashNowById(in p_user_id int)
begin
select sum(gash) gash from 
(select sum(g.gash) gash from bill b 
left join Gash g on b.gash_id = g.id
where b.update_at > b.create_at
and b.user_id = p_user_id
group by b.user_id
union all
select sum(p.price) * -1 gash from Records r
left join Characters c on r.character_id = c.id
left join Series s on s.id = c.series_id
left join Price p on s.price_id = p.id
where r.user_id = p_user_id
group by r.user_id
union all
select floor(sum(p.price) / 10) gash from Records r
left join Characters c on r.character_id = c.id
left join Series s on s.id = c.series_id
left join Price p on s.price_id = p.id
where r.user_id = p_user_id and r.status_id = 3
group by r.user_id
union all
select sum(amount) gash from gift p_user_id
where user_id = p_user_id and update_at < expire_at
group by user_id
union all
select sum(amount) * -1 gash from gift
where user_id = p_user_id and update_at > expire_at
group by user_id) as tmp;
end ;;
delimiter;

drop procedure if exists GetPastAYearGashById;
delimiter ;;
create procedure GetPastAYearGashById(in p_user_id int)
begin
select sum(g.gash) gash 
from Bill b left join Gash g on b.gash_id = g.id  
where user_id = p_user_id and b.update_at > UNIX_TIMESTAMP(DATE_SUB(NOW(), INTERVAL 1 YEAR))
group by user_id;
end ;;
delimiter;

drop procedure if exists GetCollectionNoByIdAndCategory;
delimiter ;;
create procedure GetCollectionNoByIdAndCategory(in p_user_id int, in p_category_id int)
begin
select user_id, series_id, notification_status, name_title, name, price
from(select tmp.user_id, tmp.series_id, tmp.notification_status , tmp.category_id, st.name_title, tmp.name, tmp.price, sum(m.remain) remain
from (select c.user_id, c.series_id, c.notification_status, s.category_id, s.name_title_id, s.name, p.price 
      from (select co.user_id user_id, co.series_id series_id, co.notification_status notification_status from collection co 
where user_id = p_user_id) as c 
left join Series s on c.series_id = s.id
left join Price p on s.price_id = p.id
where category_id = p_category_id
) as tmp
left join Characters c on tmp.series_id = c.series_id
left join Machine m on c.id = m.character_id 
left join SeriesTitle st on tmp.name_title_id = st.id
group by series_id) as tmp
where remain = 0;
end ;; 
delimiter;

drop procedure if exists GetCollectionHasByIdAndCategory;
delimiter ;;
create procedure GetCollectionHasByIdAndCategory(in p_user_id int, in p_category_id int)
begin
select user_id, series_id, notification_status, name_title, name, price
from(select tmp.user_id, tmp.series_id, tmp.notification_status , tmp.category_id, st.name_title, tmp.name, tmp.price, sum(m.remain) remain
from (select c.user_id, c.series_id, c.notification_status, s.category_id, s.name_title_id, s.name, p.price 
      from (select co.user_id user_id, co.series_id series_id, co.notification_status notification_status from collection co 
where user_id = p_user_id) as c 
left join Series s on c.series_id = s.id
left join Price p on s.price_id = p.id
where category_id = p_category_id
) as tmp
left join Characters c on tmp.series_id = c.series_id
left join Machine m on c.id = m.character_id 
left join SeriesTitle st on tmp.name_title_id = st.id
group by series_id) as tmp
where remain > 0;
end ;; 
delimiter;

drop procedure if exists GetSeriesImgById;
delimiter ;;
create procedure GetSeriesImgById(in p_series_id int)
begin
select si.img from Series s
left join SeriesImg si on s.id = si.series_id
where s.id = p_series_id;
end ;;
delimiter;

drop view if exists vw_AllMyRecords;
create view vw_AllMyRecords as select r.user_id user_id, r.id record_id, ca.category, st.name_title series_title, s.name series_name, character_id ,c.name character_name, c.img character_img, p.price price, floor(p.price / 10) gift, pz.prize prize, sta.id status_id, sta.status, r.time
from (select id, user_id, label, character_id, status_id, time from Records) as r
left join Characters c on r.character_id = c.id
left join Series s on c.series_id = s.id
left join Price p on s.price_id = p.id
left join Prize pz on c.prize_id = pz.id
left join SeriesTitle st on s.name_title_id = st.id
left join Status sta on r.status_id = sta.id
left join Category ca on s.category_id = ca.id
order by time desc;

drop view if exists vw_AllMyGiftRecords;
create view vw_AllMyGiftRecords as select r.user_id user_id, r.record_id, category, series_title, series_name, character_name, character_img, 0 price, t.gash gift, prize, status, t.time
from 
(select record_id, gash, time from ToG) as t
left join vw_AllMyRecords r on t.record_id = r.record_id

drop procedure if EXISTS GetUserWalletRecordById;
delimiter ;;
create procedure GetUserWalletRecordById(in p_user_id int)
begin
select category, series_name, (price * -1) price, time, count(character_name) amount from vw_AllMyRecords where user_id = p_user_id group by character_name
union all 
select '兌換G幣' category, series_name, gift price, time, count(character_name) amount from vw_AllMyGiftRecords where user_id = p_user_id group by character_name
union all
select '禮金回收' category, '過期禮金回收' series_name, (amount * -1) price, update_at time, 1 amount from gift 
where user_id = p_user_id and expire_at < UNIX_TIMESTAMP(NOW())
union all
select '儲值' category, '儲值G幣' series_name, g.gash price, update_at time, 1 amount from bill b
left join Gash g on b.gash_id = g.id
where update_at is not null and  user_id = p_user_id;
end ;;
delimiter;

drop procedure if exists GetBagCartByIdAndStatus;
delimiter ;;
create procedure GetBagCartByIdAndStatus(in p_user_id int, in p_status_id int)
begin
SELECT record_id, character_img img, series_title title, series_name series, character_name as name, count(character_id) amount, gift, prize FROM `vw_AllMyRecords` 
where user_id = p_user_id and status_id = p_status_id
group by character_id;
end ;;
delimiter;

drop procedure if exists GetAllLogisticsById;
delimiter ;;
create procedure GetAllLogisticsById(in p_user_id int)
begin
select l.id, concat('GC', time, l.user_id, 'R') as no , time, s.status, lm.method
from(select id, user_id, time, status_id, method_id from Logistics
where user_id = p_user_id) as l
left join Status s on l.status_id = s.id
left join LogisticsMethod lm on l.method_id = lm.id;
end ;;
delimiter;

drop procedure if exists GetUserinfoById;
delimiter ;;
create procedure GetUserinfoById(in p_user_id int)
begin 
select u.id, name, email, phone, birth, concat(co.zipcode, ci.city, co.county, u.road) address, credit, recommend
from 
(SELECT id, name, email, phone, birth, county_id, road, right(credit, 4) credit, concat('GCR', id, FLOOR(RAND() * 900) + 100) recommend FROM `Users` WHERE id = p_user_id) as u
left join County co on u.county_id = co.id
left join City ci on co.city_id = ci.id;
end ;;
delimiter;


全
select record_id, category, series_title, series_name, character_name, character_img, price, 0 gift, prize, status, time from vw_AllMyRecords where user_id = 1
union all 
select record_id, '兌換G幣' category, series_title, series_name, character_name, character_img, price, gift, prize, status, time from vw_AllMyGiftRecords where user_id = 1

SELECT recored_id, character_img img, series_title title, series_name series, character_name as name FROM `vw_AllMyRecords` 
where user_id = 1 and status_id = 4
group by 


drop procedure if exists GetLogisticsDetailById;
delimiter ;;
create procedure GetLogisticsDetailById(in p_logistics_id int)
begin
select no, time, status, l.name as user, method, deliver_time, concat(co.zipcode, ci.city, co.county, a.road) address
from(
    select concat('GC', l.time, l.user_id, 'R') as no, l.time, status, u.name, concat(method, '(貨到付款)') method, deliver_time, address_id
	from(
        select * from Logistics where id = p_logistics_id)as l
		left join Status s on l.status_id = s.id
		left join LogisticsMethod lm on l.method_id = lm.id
		left join Users u on l.user_id = u.id
    ) as l
left join Address a on l.address_id = a.id
left join County co on a.county_id = co.id
left join City ci on co.city_id = ci.id;
end ;;
delimiter;

drop procedure if exists GetLogisticsItemById;
delimiter ;;
create procedure GetLogisticsItemById(in p_logistics_id int)
begin
select c.name as character_name, count(r.character_id) amount
from(
    select id from Logistics where id = p_logistics_id
    ) as l
left join LogisticsItem li on l.id = li.logistics_id
left join Records r on li.records_id = r.id
left join Characters c on r.character_id = c.id
group by character_id;
end ;;
delimiter;

drop procedure if exists GetAllCardByCategoryId;
delimiter ;;
create procedure GetAllCardByCategoryId(in p_category_id int)
begin
select o.id series_id, Theme.theme theme, SeriesTitle.name_title series_title, o.name name, Price.price price, count(o.id) amount, rank, rare, o.release_time
from(
    select s.series_id id, Series.name name, Series.theme_id, Series.name_title_id, Series.price_id, sum(rank) rank, sum(rare) rare, Series.release_time
	from(
    	select series_id, count(series_id) rank, 0 rare
		  from Records r 
		  left join Characters c on r.character_id = c.id
          where time >= now() - interval 3 DAY
		  group by c.series_id
      union all 
      select id series_id, 0 rank, stock rare
      from Series
    ) as s 
	left join Series on s.series_id = Series.id
	where Series.category_id = p_category_id
  group by s.series_id) as o
left join Theme on o.theme_id = Theme.id
left join SeriesTitle on o.name_title_id = SeriesTitle.id
left join Price on o.price_id = Price.id
left join Characters on o.id = Characters.series_id
group by o.id;
end ;;
delimiter;