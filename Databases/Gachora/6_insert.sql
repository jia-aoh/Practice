INSERT INTO Theme (theme) 
VALUES 
('壽司'), 
('咒術迴戰'), 
('蝸牛'), 
('卡比之星'), 
('三麗鷗'), 
('絨毛昆蟲類'), 
('獵人'), 
('POPMART 泡泡瑪特');

-- catogory扭蛋1

INSERT INTO Material (material) 
VALUES ('樹脂'), ('聚酯纖維'), ('PU'), ('合金+PVC+ABS');

-- 不重複
INSERT INTO SeriesTitle (name_title)
VALUES
    ('極上壽司篇'),
    ('咒術迴戰跳躍公仔'),
    ('關東煮系列蝸牛'),
    ('航海王-偉大航道'),
    ('Kirby - 星之卡比'),
    ('三麗鷗角色'),
    ('絨毛公仔'),
    ('HUNTER×HUNTER獵人坐下隊第三彈'),
    ('HUNTER×HUNTER獵人坐姿隊第四彈'),
    ('HUNTER×HUNTER獵人坐姿隊第二彈'),
    ('埃及神X海賊王'),
    ('悲觀第一蛋'),
    ('海賊王永久指針第一蛋'),
    ('泡泡瑪特-魔力卡丁車第一彈');

INSERT INTO Series (category_id, name_title_id, name, theme_id, price_id, stock, release_time)
VALUES
    (1, 5, '海鮮壽司', 4, 1, 3, unix_timestamp(now())),
    (1, 6, '咒術迴戰', 5, 2, 3, unix_timestamp(now())),
    (1, 7, '可愛蝸牛', 6, 1, 3, unix_timestamp(now())),
    (1, 8, '遙遙不倒翁航海王船隻模型', 1, 5, 10, unix_timestamp(now())),
    (1, 9, '探索遊戲公仔', 7, 2, 1, unix_timestamp(now())),
    (1, 10, '角色貪吃公仔', 8, 3, 1, unix_timestamp(now())),
    (1, 11, '昆蟲類絨毛公仔', 9, 2, 1, unix_timestamp(now())),
    (1, 12, '獵人蟻王篇-嵌合蟻坐姿', 10, 2, 5, unix_timestamp(now())),
    (1, 13, '獵人幻影旅團坐姿', 10, 2, 5, unix_timestamp(now())),
    (1, 14, '獵人主角坐姿', 10, 2, 5, unix_timestamp(now())),
    (1, 15, '開宴會吧', 1, 3, 2, unix_timestamp(now())),
    (1, 16, '海賊王悲觀鬼魂', 1, 3, 10, unix_timestamp(now())),
    (1, 17, '永久指針', 1, 4, 10, unix_timestamp(now())),
    (1, 18, 'MOLLY-魔力卡卡', 11, 6, 10, unix_timestamp(now()));

INSERT INTO Characters (series_id, prize_id, name, material_id, size1, size2, size3, img)
VALUES
    (7, 1, '魚子軍艦壽司', 4, 4, 3, 3, '/gachaItem/a1-1.jpg'),
    (7, 2, '海膽軍艦壽司', 4, 4, 3, 3, '/gachaItem/a1-2.jpg'),
    (7, 3, '鮑魚壽司', 4, 4, 3, 3, '/gachaItem/a1-3.jpg'),
    (7, 4, '鮮蝦壽司', 4, 4, 3, 3, '/gachaItem/a1-4.jpg'),
    (7, 5, '鮪魚壽司', 4, 4, 3, 3, '/gachaItem/a1-5.jpg'),
    (8, 1, '虎杖悠仁', 4, 4, 3, 3, '/gachaItem/a2-1.webp'),
    (8, 2, '伏黑惠', 4, 4, 3, 3, '/gachaItem/a2-2.webp'),
    (8, 3, '七海建人', 4, 4, 3, 3, '/gachaItem/a2-3.webp'),
    (8, 4, '釘崎野薔薇', 4, 4, 3, 3, '/gachaItem/a2-4.webp'),
    (8, 5, '五條悟', 4, 4, 3, 3, '/gachaItem/a2-5.webp'),
    (9, 1, '蘿蔔蝸牛', 6, 4, 3, 3, '/gachaItem/a3-1.webp'),
    (9, 2, '蒟蒻蝸牛', 6, 4, 3, 3, '/gachaItem/a3-2.webp'),
    (9, 3, '章魚蝸牛', 6, 4, 3, 3, '/gachaItem/a3-3.webp'),
    (9, 4, '黑輪蝸牛', 6, 4, 3, 3, '/gachaItem/a3-4.webp'),
    (9, 5, '高麗菜捲蝸牛', 6, 4, 3, 3, '/gachaItem/a3-5.webp'),
    (10, 1, '千陽號', 4, 6, 6, 6, '/gachaItem/a4-1.jpg'),
    (10, 2, '前進梅利號', 4, 6, 6, 6, '/gachaItem/a4-1.jpg'),
    (10, 3, '紅色勢力號', 4, 6, 6, 6, '/gachaItem/a4-2.jpg'),
    (10, 4, '白鯨號', 4, 6, 6, 6, '/gachaItem/a4-3.jpg'),
    (10, 5, '芭拉蒂海上餐廳', 4, 6, 6, 6, '/gachaItem/a4-4.jpg'),
    (11, 1, '服務員卡比', 6, 7, 6, 6, '/gachaItem/a5-1.jpg'),
    (11, 2, '服務員瓦豆魯迪', 6, 7, 6, 6, '/gachaItem/a5-2.jpg'),
    (11, 3, '瓦豆魯迪', 6, 7, 6, 6, '/gachaItem/a5-3.jpg'),
    (11, 4, '凱丹胡巴里', 6, 7, 6, 6, '/gachaItem/a5-4.jpg'),
    (12, 1, '酷洛米', 4, 4, 3, 3, '/gachaItem/a6-1.jpg'),
    (12, 2, '人魚漢頓', 4, 4, 3, 3, '/gachaItem/a6-2.jpg'),
    (12, 3, '大耳狗', 4, 4, 3, 3, '/gachaItem/a6-3.jpg'),
    (12, 4, '布丁狗', 4, 4, 3, 3, '/gachaItem/a6-4.jpg'),
    (12, 5, '山姆企鵝', 4, 4, 3, 3, '/gachaItem/a6-5.jpg'),
    (13, 1, '蝴蝶', 7, 4, 3, 3, '/gachaItem/a7-1.jpg'),
    (13, 2, '毛毛蟲', 7, 4, 3, 3, '/gachaItem/a7-2.jpg'),
    (13, 3, '獨角仙', 7, 4, 3, 3, '/gachaItem/a7-3.jpg'),
    (13, 4, '瓢蟲', 7, 4, 3, 3, '/gachaItem/a7-4.jpg'),
    (13, 5, '邱形蟲', 7, 4, 3, 3, '/gachaItem/a7-5.jpg'),
    (14, 1, '尼飛彼多', 4, 4, 4, 4, '/gachaItem/a8-1.jpg'),
    (14, 2, '蟻王-梅路艾姆', 4, 4, 4, 4, '/gachaItem/a8-2.jpg'),
    (14, 3, '凱特', 4, 4, 4, 4, '/gachaItem/a8-3.jpg'),
    (14, 4, '小麥', 4, 4, 4, 4, '/gachaItem/a8-4.jpg'),
    (15, 1, '庫洛洛·魯西魯', 4, 5, 5, 5, '/gachaItem/a9-1.jpg'),
    (15, 2, '西索·莫羅', 4, 5, 5, 5, '/gachaItem/a9-2.jpg'),
    (15, 3, '俠客', 4, 5, 5, 5, '/gachaItem/a9-3.jpg'),
    (15, 4, '飛坦', 4, 5, 5, 5, '/gachaItem/a9-4.jpg'),
    (16, 1, '奇犽·揍敵客', 4, 4, 4, 4, '/gachaItem/a10-1.jpg'),
    (16, 2, '小傑·富力士', 4, 4, 4, 4, '/gachaItem/a10-2.jpg'),
    (16, 3, '酷拉皮卡', 4, 4, 4, 4, '/gachaItem/a10-3.jpg'),
    (16, 4, '雷歐力·帕拉丁奈特', 4, 4, 4, 4, '/gachaItem/a10-4.jpg'),
    (17, 1, '艾斯', 4, 4, 3, 3, '/gachaItem/a11-1.png'),
    (17, 2, '路飛', 4, 4, 3, 3, '/gachaItem/a11-2.png'),
    (17, 3, '索隆', 4, 4, 3, 3, '/gachaItem/a11-3.png'),
    (17, 4, '艾涅爾', 4, 4, 3, 3, '/gachaItem/a11-4.png'),
    (18, 1, '路飛', 8, 4, 4, 4, '/gachaItem/a12-1.png'),
    (18, 2, '索隆', 8, 4, 4, 4, '/gachaItem/a12-2.png'),
    (18, 3, '布魯克', 8, 4, 4, 4, '/gachaItem/a12-3.png'),
    (18, 4, '娜美', 8, 4, 4, 4, '/gachaItem/a12-4.png'),
    (18, 5, '喬巴', 8, 4, 4, 4, '/gachaItem/a12-5.png'),
    (18, 6, '隱藏角色', 8, 4, 4, 4, '/gachaItem/a12-6.png'),
    (19, 1, '歐哈拉', 4, 9, 6, 6, '/gachaItem/a13-1.png'),
    (19, 2, '俄尼斯大廳', 4, 9, 6, 6, '/gachaItem/a13-2.png'),
    (19, 3, '蛋糕島', 4, 9, 6, 6, '/gachaItem/a13-3.png'),
    (19, 4, '沙巴歐迪', 4, 9, 6, 6, '/gachaItem/a13-4.png'),
    (19, 5, '印呸', 4, 9, 6, 6, '/gachaItem/a13-5.png'),
    (19, 6, '雅馬遜利利', 4, 9, 6, 6, '/gachaItem/a13-6.png'),
    (20, 1, '寶寶車車', 9, 9, 8, 7, '/gachaItem/a14-1.jpg'),
    (20, 2, '勞斯茉莉', 9, 9, 8, 7, '/gachaItem/a14-2.jpg'),
    (20, 3, '香蕉7號', 9, 9, 8, 7, '/gachaItem/a14-3.jpg'),
    (20, 4, '櫻桃車車', 9, 9, 8, 7, '/gachaItem/a14-4.jpg'),
    (20, 5, '白日夢', 9, 9, 8, 7, '/gachaItem/a14-5.jpg'),
    (20, 6, '閃電2021', 9, 9, 8, 7, '/gachaItem/a14-6.jpg'),
    (20, 7, '人魚嘟嘟', 9, 9, 8, 7, '/gachaItem/a14-7.jpg'),
    (20, 8, '茉莉汽水車', 9, 9, 8, 7, '/gachaItem/a14-8.jpg'),
    (20, 9, '鴿子7號', 9, 9, 8, 7, '/gachaItem/a14-9.jpg'),
    (20, 10, '隱藏版超級7號', 9, 9, 8, 7, '/gachaItem/a14-10.jpg'),
    (20, 11, '隱藏版超級7號特別款', 9, 9, 8, 7, '/gachaItem/a14-11.jpg');

INSERT INTO Machine (character_id, remain, amount)
VALUES
    (16, 5, 5),
    (17, 5, 5),
    (18, 5, 5),
    (19, 5, 5),
    (20, 5, 5),
    (21, 2, 2),
    (22, 3, 3),
    (23, 4, 4),
    (24, 5, 5),
    (25, 6, 6),
    (26, 3, 2),
    (27, 2, 3),
    (28, 3, 4),
    (29, 4, 5),
    (30, 5, 6),
    (31, 5, 5),
    (32, 5, 5),
    (33, 5, 5),
    (34, 5, 5),
    (35, 5, 5),
    (36, 1, 1),
    (37, 2, 2),
    (38, 3, 3),
    (39, 4, 4),
    (40, 1, 1),
    (41, 2, 2),
    (42, 3, 3),
    (43, 5, 5),
    (44, 10, 10),
    (45, 1, 1),
    (46, 2, 2),
    (47, 3, 3),
    (48, 5, 5),
    (49, 10, 10),
    (50, 5, 5),
    (51, 5, 5),
    (52, 5, 5),
    (53, 5, 5),
    (54, 5, 5),
    (55, 8, 8),
    (56, 10, 10),
    (57, 10, 10),
    (58, 8, 8),
    (59, 8, 8),
    (60, 8, 8),
    (61, 8, 8),
    (62, 3, 3),
    (63, 3, 3),
    (64, 3, 3),
    (65, 3, 3),
    (66, 2, 2),
    (67, 2, 2),
    (68, 2, 2),
    (69, 2, 2),
    (70, 2, 2),
    (71, 2, 2),
    (72, 2, 2),
    (73, 2, 2),
    (74, 2, 2),
    (75, 2, 2),
    (76, 2, 2),
    (77, 2, 2),
    (78, 3, 3),
    (79, 3, 3),
    (80, 3, 3),
    (81, 3, 3),
    (82, 3, 3),
    (83, 3, 3),
    (84, 3, 3),
    (85, 3, 3),
    (86, 3, 3),
    (87, 2, 2),
    (88, 1, 1);

-- 7-20
INSERT INTO SeriesImg (series_id, img)
VALUES
    (7, '/gachaItem/a1.jpg'),
    (8, '/gachaItem/a2.webp'),
    (9, '/gachaItem/a3.webp'),
    (10, '/gachaItem/a4.jpg'),
    (10, '/gachaItem/b4.jpg'),
    (10, '/gachaItem/c4.jpg'),
    (10, '/gachaItem/d4.jpg'),
    (10, '/gachaItem/e4.jpg'),
    (11, '/gachaItem/a5.jpg'),
    (12, '/gachaItem/a6.jpg'),
    (13, '/gachaItem/a7.jpg'),
    (14, '/gachaItem/a8.jpg'),
    (15, '/gachaItem/a9.jpg'),
    (14, '/gachaItem/a8.jpg'),
    (15, '/gachaItem/a9.jpg'),
    (14, '/gachaItem/a8.jpg'),
    (15, '/gachaItem/a9.jpg'),
    (16, '/gachaItem/a10.jpg'),
    (17, '/gachaItem/a11.png'),
    (18, '/gachaItem/a12.png'),
    (19, '/gachaItem/a13.png'),
    (20, '/gachaItem/a14.jpg'),
    (20, '/gachaItem/b14.jpg'),
    (20, '/gachaItem/c14.jpg'),
    (20, '/gachaItem/d14.jpg'),
    (20, '/gachaItem/e14.jpg'),
    (20, '/gachaItem/f14.jpg'),
    (20, '/gachaItem/g14.jpg'),
    (20, '/gachaItem/h14.jpg'),
    (20, '/gachaItem/i14.jpg');

-- 'http://localhost/gachoraProject/public/images' . 