drop view if exists vw_EggCard;
create view vw_EggCard as 
select s.id series_id, t.theme theme, st.name_title series_title, s.name name, p.price price, count(s.id) amount from Series s
left join Theme t on s.theme_id = t.id
left join Price p on s.price_id = p.id
left join Characters c on s.id = c.series_id
left join SeriesTitle st on s.name_title_id = st.id
where category_id = 1
group by s.id;

drop view if exists vw_EggCardImg;
create view vw_EggCardImg as 
select s.id series_id, si.img series_img from Series s 
left join SeriesImg si on s.id = si.series_id
where category_id = 1
order by s.id;

-- id,主題, 名, 價格, 系列主題
drop view if exists vw_Ichiban;
create view vw_Ichiban as select s.id series_id, s.theme_id theme_id, t.theme theme, st.name_title series_title, s.name name, p.price price, s.release_time, s.stock from Series s
left join Theme t on s.theme_id = t.id
left join Price p on s.price_id = p.id
left join Characters c on s.id = c.series_id
left join SeriesTitle st on s.name_title_id = st.id
where category_id = 2
group by s.id;

-- id, 系列圖
drop view if exists vw_IchibanImg;
create view vw_IchibanImg as 
select s.id series_id, s.theme_id theme_id, si.img series_img from Series s 
left join SeriesImg si on s.id = si.series_id
where category_id = 2
order by s.id;

-- id, 全剩, 全
drop view if exists vw_IchibanRemainTotal;
create view vw_IchibanRemainTotal as 
select s.id series_id, s.theme_id theme_id, sum(remain) all_remain, sum(amount) all_amount from Series s
left join Characters c on s.id = c.series_id
left join Machine m on c.id = m.character_id
where category_id = 2
group by s.id;
-- 系列id, 角色ABC, 賞, 名, 剩, 全
drop view if exists vw_RemainTotal;
create view vw_RemainTotal as
select s.id series_id, pz.prize, c.name,  remain, amount from Series s
left join Characters c on s.id = c.series_id
left join Machine m on c.id = m.character_id
left join Prize pz on c.prize_id = pz.id;

-- 系列id, 角色img, size, material
drop view if exists vw_detail;
create view vw_detail as
select s.id series_id, pz.prize, c.name character_name, c.img character_img, concat(c.size1, "x", c.size2, "x", c.size3) size, m.material, ms.remain remain, ms.amount total from Series s
left join Characters c on s.id = c.series_id
left join Material m on c.material_id = m.id
left join Prize pz on c.prize_id = pz.id 
left join Machine ms on c.id = ms.character_id;

-- 精選(最新相反)
drop view if exists vw_blingEgg;
create view vw_blingEgg as select s.id series_id, t.theme theme, st.name_title series_title, s.name name, p.price price, count(s.id) amount from Series s
left join Theme t on s.theme_id = t.id
left join Price p on s.price_id = p.id
left join Characters c on s.id = c.series_id
left join SeriesTitle st on s.name_title_id = st.id
where category_id = 1
group by s.id
order by s.release_time
limit 10;
-- 最新
drop view if exists vw_newEgg;
create view vw_newEgg as select s.id series_id, t.theme theme, st.name_title series_title, s.name name, p.price price, count(s.id) amount from Series s
left join Theme t on s.theme_id = t.id
left join Price p on s.price_id = p.id
left join Characters c on s.id = c.series_id
left join SeriesTitle st on s.name_title_id = st.id
where category_id = 1
group by s.id
order by s.release_time desc;
-- 熱門（php3天）
drop view if exists vw_hotEgg;
create view vw_hotEgg as select c.series_id series_id, t.theme theme, st.name_title series_title, s.name name, p.price price, amount from Records r
left join Characters c on r.character_id = c.id
left join Series s on s.id = c.series_id
left join SeriesTitle st on s.name_title_id = st.id
left join Theme t on s.theme_id = t.id
left join Price p on s.price_id = p.id
left join (select s.id series_id, count(s.id) amount from Series s
left join Characters c on s.id = c.series_id
where category_id = 1
group by s.id) a on c.series_id = a.series_id
where category_id = 1
group by c.series_id
order by count(c.series_id) DESC;
-- 限量
drop view if exists vw_rareEgg;
create view vw_rareEgg as select s.id series_id, t.theme theme, st.name_title series_title, s.name name, p.price price, count(s.id) amount from Series s
left join Theme t on s.theme_id = t.id
left join Price p on s.price_id = p.id
left join Characters c on s.id = c.series_id
left join SeriesTitle st on s.name_title_id = st.id
where category_id = 1
group by s.id
order by s.stock;
-- 全部
drop view if exists vw_allEgg;
create view vw_allEgg as select s.id series_id, t.theme theme, st.name_title series_title, s.name name, p.price price, count(s.id) amount from Series s
left join Theme t on s.theme_id = t.id
left join Price p on s.price_id = p.id
left join Characters c on s.id = c.series_id
left join SeriesTitle st on s.name_title_id = st.id
where category_id = 1
group by s.id
order by s.stock desc;
-- 分類頁照
drop view if exists vw_series_img;
create view vw_series_img as 
select s.series_id series_id, s.img series_img
from SeriesImg s;
-- 種類
drop view if EXISTS vw_theme;
create view vw_theme as select series_id, s.theme_id, s.category_id from Machine m 
left join Characters c on c.id = m.character_id
left join Series s on s.id = c.series_id
where remain > 0
group by series_id;
-- 系列id, 角色ABC, 賞, 名, 剩, 全
drop view if EXISTS vw_RemainTotal;
create view vw_RemainTotal as
select s.id series_id, pz.prize, c.name,  remain, amount from Series s
left join Characters c on s.id = c.series_id
left join Machine m on c.id = m.character_id
left join Prize pz on c.prize_id = pz.id;

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

-- 系列id, 角色img, size, material
drop view if EXISTS vw_detail;
create view vw_detail as
select s.id series_id, pz.prize, c.name character_name, c.img character_img, concat(c.size1, "x", c.size2, "x", c.size3) size, m.material, ms.remain remain, ms.amount total from Series s
left join Characters c on s.id = c.series_id
left join Material m on c.material_id = m.id
left join Prize pz on c.prize_id = pz.id 
left join Machine ms on c.id = ms.character_id;

drop view if exists vw_Ichiban;
create view vw_Ichiban as select s.id series_id, s.theme_id theme_id, t.theme theme, st.name_title series_title, s.name name, p.price price, s.release_time, s.stock from Series s
left join Theme t on s.theme_id = t.id
left join Price p on s.price_id = p.id
left join Characters c on s.id = c.series_id
left join SeriesTitle st on s.name_title_id = st.id
where category_id = 2
group by s.id;

-- id, 系列圖
drop view if exists vw_IchibanImg;
create view vw_IchibanImg as 
select s.id series_id, s.theme_id theme_id, si.img series_img from Series s 
left join SeriesImg si on s.id = si.series_id
where category_id = 2
order by s.id;
-- id, 全剩, 全
drop view if exists vw_IchibanRemainTotal;
create view vw_IchibanRemainTotal as 
select s.id series_id, s.theme_id theme_id, sum(remain) all_remain, sum(amount) all_amount from Series s
left join Characters c on s.id = c.series_id
left join Machine m on c.id = m.character_id
where category_id = 2
group by s.id;



-- 總G幣total_gash procedure（gash_in - record + gift - expire_gift + gash_back）

select sum(g.gash) gash_in from bill b 
left join Gash g on b.gash_id = g.id
where b.update_at > b.create_at
and b.user_id = 1
GROUP by b.user_id;

select sum(p.price) pay_record from Records r
left join Characters c on r.character_id = c.id
left join Series s on s.id = c.series_id
left join Price p on s.price_id = p.id
where r.user_id = 1
group by r.user_id;

select floor(sum(p.price) / 10) gash_back from Records r
left join Characters c on r.character_id = c.id
left join Series s on s.id = c.series_id
left join Price p on s.price_id = p.id
where r.user_id = 1 and r.status_id = 3
group by r.user_id;

select sum(amount) gash_gift from gift
where user_id = 1 and update_at < expire_at
group by user_id;

select sum(amount) gift_expired from gift
where user_id = 1 and update_at > expire_at
group by user_id;
