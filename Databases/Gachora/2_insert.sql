INSERT INTO HeadPhoto (headphoto)
VALUES ('g1000'), ('g5000'), ('egg10'), ('ichiban10');

INSERT INTO Gash (gash, dollar) 
VALUES (300, 300), (500, 500),  (1000, 1000), (3030, 3000), (5100, 5000), (10250, 10000), (20600, 20000), (31000, 30000), (52000, 50000);

INSERT INTO Theme (theme) 
VALUES ('海賊王'), ('企鵝家族'), ('鬼滅之刃');

INSERT INTO Category (category) 
VALUES ('扭蛋'),('一番賞'),('儲值'),('生日禮'),('推薦禮');

INSERT INTO Material (material) 
VALUES ('PU+樹脂'),('PU+進口樹脂'), ('進口樹脂+PU樹脂+PU透明樹脂'), ('PVC'), ('進口樹脂+進口PU') ;

INSERT INTO Price (price) 
VALUES (100), (200), (300), (400), (500), (600), (700), (800), (900), (1000), (1100), (1200), (1300), (1400), (1500), (1600), (1700), (1800), (1900), (2000);

INSERT INTO Prize (prize) 
VALUES ('A'),('B'),('C'),('D'),('E'),('F'),('G'),('H'),('I');

INSERT INTO Status (status) 
VALUES ('未到帳'),('已到帳'),('已兑換紅利'),('存於儲藏庫'),('存於購物車'),('出貨準備中'),('商品已出貨'),('商品已送達'),('完成退換貨'), ('到貨不通知'), ('到貨需通知'), ('常用'), ('不常用');

INSERT INTO City (city) 
VALUES ('台北市'),('新北市'),('基隆市'),('桃園市'),('新竹縣'),('新竹市'),('苗栗縣'),('台中市'),('南投縣'),('彰化縣'),('雲林縣'),('嘉義縣'),('嘉義市'),('台南市'),('高雄市'),('屏東縣'),('宜蘭縣'),('花蓮縣'),('台東縣'),('澎湖縣'),('金門縣'),('連江縣');

INSERT INTO LogisticsMethod (method)
VALUES ('超商'),('宅配'),('自取');

INSERT INTO County (zipcode, city_id, county) 
VALUES 
    (100, (SELECT id FROM City WHERE city = '台北市'), '中正區'),
    (103, (SELECT id FROM City WHERE city = '台北市'), '大同區'),
    (104, (SELECT id FROM City WHERE city = '台北市'), '中山區'),
    (105, (SELECT id FROM City WHERE city = '台北市'), '松山區'),
    (106, (SELECT id FROM City WHERE city = '台北市'), '大安區'),
    (108, (SELECT id FROM City WHERE city = '台北市'), '萬華區'),
    (110, (SELECT id FROM City WHERE city = '台北市'), '信義區'),
    (111, (SELECT id FROM City WHERE city = '台北市'), '士林區'),
    (112, (SELECT id FROM City WHERE city = '台北市'), '北投區'),
    (114, (SELECT id FROM City WHERE city = '台北市'), '內湖區'),
    (115, (SELECT id FROM City WHERE city = '台北市'), '南港區'),
    (116, (SELECT id FROM City WHERE city = '台北市'), '文山區'),
    (220, (SELECT id FROM City WHERE city = '新北市'), '板橋區'),
    (242, (SELECT id FROM City WHERE city = '新北市'), '新莊區'),
    (243, (SELECT id FROM City WHERE city = '新北市'), '泰山區'),
    (244, (SELECT id FROM City WHERE city = '新北市'), '林口區'),
    (251, (SELECT id FROM City WHERE city = '新北市'), '淡水區'),
    (208, (SELECT id FROM City WHERE city = '新北市'), '金山區'),
    (249, (SELECT id FROM City WHERE city = '新北市'), '八里區'),
    (207, (SELECT id FROM City WHERE city = '新北市'), '萬里區'),
    (253, (SELECT id FROM City WHERE city = '新北市'), '石門區'),
    (252, (SELECT id FROM City WHERE city = '新北市'), '三芝區'),
    (224, (SELECT id FROM City WHERE city = '新北市'), '瑞芳區'),
    (221, (SELECT id FROM City WHERE city = '新北市'), '汐止區'),
    (226, (SELECT id FROM City WHERE city = '新北市'), '平溪區'),
    (228, (SELECT id FROM City WHERE city = '新北市'), '貢寮區'),
    (227, (SELECT id FROM City WHERE city = '新北市'), '雙溪區'),
    (222, (SELECT id FROM City WHERE city = '新北市'), '深坑區'),
    (223, (SELECT id FROM City WHERE city = '新北市'), '石碇區'),
    (231, (SELECT id FROM City WHERE city = '新北市'), '新店區'),
    (232, (SELECT id FROM City WHERE city = '新北市'), '坪林區'),
    (233, (SELECT id FROM City WHERE city = '新北市'), '烏來區'),
    (235, (SELECT id FROM City WHERE city = '新北市'), '中和區'),
    (234, (SELECT id FROM City WHERE city = '新北市'), '永和區'),
    (236, (SELECT id FROM City WHERE city = '新北市'), '土城區'),
    (237, (SELECT id FROM City WHERE city = '新北市'), '三峽區'),
    (238, (SELECT id FROM City WHERE city = '新北市'), '樹林區'),
    (239, (SELECT id FROM City WHERE city = '新北市'), '鶯歌區'),
    (241, (SELECT id FROM City WHERE city = '新北市'), '三重區'),
    (247, (SELECT id FROM City WHERE city = '新北市'), '蘆洲區'),
    (248, (SELECT id FROM City WHERE city = '新北市'), '五股區'),
    (200, (SELECT id FROM City WHERE city = '基隆市'), '仁愛區'),
    (202, (SELECT id FROM City WHERE city = '基隆市'), '中正區'),
    (201, (SELECT id FROM City WHERE city = '基隆市'), '信義區'),
    (203, (SELECT id FROM City WHERE city = '基隆市'), '中山區'),
    (204, (SELECT id FROM City WHERE city = '基隆市'), '安樂區'),
    (205, (SELECT id FROM City WHERE city = '基隆市'), '暖暖區'),
    (206, (SELECT id FROM City WHERE city = '基隆市'), '七堵區'),
    (330, (SELECT id FROM City WHERE city = '桃園市'), '桃園區'),
    (320, (SELECT id FROM City WHERE city = '桃園市'), '中壢區'),
    (324, (SELECT id FROM City WHERE city = '桃園市'), '平鎮區'),
    (334, (SELECT id FROM City WHERE city = '桃園市'), '八德區'),
    (326, (SELECT id FROM City WHERE city = '桃園市'), '楊梅區'),
    (338, (SELECT id FROM City WHERE city = '桃園市'), '蘆竹區'),
    (333, (SELECT id FROM City WHERE city = '桃園市'), '龜山區'),
    (325, (SELECT id FROM City WHERE city = '桃園市'), '龍潭區'),
    (335, (SELECT id FROM City WHERE city = '桃園市'), '大溪區'),
    (337, (SELECT id FROM City WHERE city = '桃園市'), '大園區'),
    (328, (SELECT id FROM City WHERE city = '桃園市'), '觀音區'),
    (327, (SELECT id FROM City WHERE city = '桃園市'), '新屋區'),
    (336, (SELECT id FROM City WHERE city = '桃園市'), '復興區'),
    (302, (SELECT id FROM City WHERE city = '新竹縣'), '竹北市'),
    (310, (SELECT id FROM City WHERE city = '新竹縣'), '竹東鎮'),
    (305, (SELECT id FROM City WHERE city = '新竹縣'), '新埔鎮'),
    (306, (SELECT id FROM City WHERE city = '新竹縣'), '關西鎮'),
    (315, (SELECT id FROM City WHERE city = '新竹縣'), '峨眉鎮'),
    (308, (SELECT id FROM City WHERE city = '新竹縣'), '寶山鄉'),
    (314, (SELECT id FROM City WHERE city = '新竹縣'), '北埔鄉'),
    (312, (SELECT id FROM City WHERE city = '新竹縣'), '橫山鄉'),
    (307, (SELECT id FROM City WHERE city = '新竹縣'), '芎林鄉'),
    (303, (SELECT id FROM City WHERE city = '新竹縣'), '湖口鄉'),
    (304, (SELECT id FROM City WHERE city = '新竹縣'), '新豐鄉'),
    (313, (SELECT id FROM City WHERE city = '新竹縣'), '尖石鄉'),
    (311, (SELECT id FROM City WHERE city = '新竹縣'), '五峰鄉'),
    (300, (SELECT id FROM City WHERE city = '新竹市'), '東區'),
    (300, (SELECT id FROM City WHERE city = '新竹市'), '北區'),
    (300, (SELECT id FROM City WHERE city = '新竹市'), '香山區'),
    (360, (SELECT id FROM City WHERE city = '苗栗縣'), '苗栗市'),
    (357, (SELECT id FROM City WHERE city = '苗栗縣'), '通霄鎮'),
    (358, (SELECT id FROM City WHERE city = '苗栗縣'), '苑裡鎮'),
    (350, (SELECT id FROM City WHERE city = '苗栗縣'), '竹南鎮'),
    (351, (SELECT id FROM City WHERE city = '苗栗縣'), '頭份鎮'),
    (356, (SELECT id FROM City WHERE city = '苗栗縣'), '後龍鎮'),
    (369, (SELECT id FROM City WHERE city = '苗栗縣'), '卓蘭鎮'),
    (368, (SELECT id FROM City WHERE city = '苗栗縣'), '西湖鄉'),
    (362, (SELECT id FROM City WHERE city = '苗栗縣'), '頭屋鄉'),
    (363, (SELECT id FROM City WHERE city = '苗栗縣'), '公館鄉'),
    (366, (SELECT id FROM City WHERE city = '苗栗縣'), '銅鑼鄉'),
    (367, (SELECT id FROM City WHERE city = '苗栗縣'), '三義鄉'),
    (361, (SELECT id FROM City WHERE city = '苗栗縣'), '造橋鄉'),
    (352, (SELECT id FROM City WHERE city = '苗栗縣'), '三灣鄉'),
    (353, (SELECT id FROM City WHERE city = '苗栗縣'), '南庄鄉'),
    (364, (SELECT id FROM City WHERE city = '苗栗縣'), '大湖鄉'),
    (354, (SELECT id FROM City WHERE city = '苗栗縣'), '獅潭鄉'),
    (365, (SELECT id FROM City WHERE city = '苗栗縣'), '泰安鄉'),
    (400, (SELECT id FROM City WHERE city = '台中市'), '中區'),
    (401, (SELECT id FROM City WHERE city = '台中市'), '東區'),
    (402, (SELECT id FROM City WHERE city = '台中市'), '南區'),
    (403, (SELECT id FROM City WHERE city = '台中市'), '西區'),
    (404, (SELECT id FROM City WHERE city = '台中市'), '北區'),
    (406, (SELECT id FROM City WHERE city = '台中市'), '北屯區'),
    (407, (SELECT id FROM City WHERE city = '台中市'), '西屯區'),
    (508, (SELECT id FROM City WHERE city = '台中市'), '南屯區'),
    (411, (SELECT id FROM City WHERE city = '台中市'), '太平區'),
    (412, (SELECT id FROM City WHERE city = '台中市'), '大里區'),
    (413, (SELECT id FROM City WHERE city = '台中市'), '霧峰區'),
    (414, (SELECT id FROM City WHERE city = '台中市'), '烏日區'),
    (420, (SELECT id FROM City WHERE city = '台中市'), '豐原區'),
    (421, (SELECT id FROM City WHERE city = '台中市'), '后里區'),
    (423, (SELECT id FROM City WHERE city = '台中市'), '東勢區'),
    (422, (SELECT id FROM City WHERE city = '台中市'), '石崗區'),
    (426, (SELECT id FROM City WHERE city = '台中市'), '新社區'),
    (424, (SELECT id FROM City WHERE city = '台中市'), '和平區'),
    (429, (SELECT id FROM City WHERE city = '台中市'), '神岡區'),
    (427, (SELECT id FROM City WHERE city = '台中市'), '潭子區'),
    (428, (SELECT id FROM City WHERE city = '台中市'), '大雅區'),
    (432, (SELECT id FROM City WHERE city = '台中市'), '大肚區'),
    (434, (SELECT id FROM City WHERE city = '台中市'), '龍井區'),
    (433, (SELECT id FROM City WHERE city = '台中市'), '沙鹿區'),
    (435, (SELECT id FROM City WHERE city = '台中市'), '梧棲區'),
    (436, (SELECT id FROM City WHERE city = '台中市'), '清水區'),
    (437, (SELECT id FROM City WHERE city = '台中市'), '大甲區'),
    (438, (SELECT id FROM City WHERE city = '台中市'), '外埔區'),
    (439, (SELECT id FROM City WHERE city = '台中市'), '大安區'),
    (540, (SELECT id FROM City WHERE city = '南投縣'), '南投市'),
    (545, (SELECT id FROM City WHERE city = '南投縣'), '埔里鎮'),
    (542, (SELECT id FROM City WHERE city = '南投縣'), '草屯鎮'),
    (557, (SELECT id FROM City WHERE city = '南投縣'), '竹山鎮'),
    (552, (SELECT id FROM City WHERE city = '南投縣'), '集集鎮'),
    (551, (SELECT id FROM City WHERE city = '南投縣'), '名間鄉'),
    (558, (SELECT id FROM City WHERE city = '南投縣'), '鹿谷鄉'),
    (541, (SELECT id FROM City WHERE city = '南投縣'), '中寮鄉'),
    (555, (SELECT id FROM City WHERE city = '南投縣'), '魚池鄉'),
    (544, (SELECT id FROM City WHERE city = '南投縣'), '國姓鄉'),
    (553, (SELECT id FROM City WHERE city = '南投縣'), '水里鄉'),
    (556, (SELECT id FROM City WHERE city = '南投縣'), '信義鄉'),
    (546, (SELECT id FROM City WHERE city = '南投縣'), '仁愛鄉'),
    (500, (SELECT id FROM City WHERE city = '彰化縣'), '彰化市'),
    (510, (SELECT id FROM City WHERE city = '彰化縣'), '員林市'),
    (508, (SELECT id FROM City WHERE city = '彰化縣'), '和美鎮'),
    (505, (SELECT id FROM City WHERE city = '彰化縣'), '鹿港鎮'),
    (514, (SELECT id FROM City WHERE city = '彰化縣'), '溪湖鎮'),
    (526, (SELECT id FROM City WHERE city = '彰化縣'), '二林鎮'),
    (520, (SELECT id FROM City WHERE city = '彰化縣'), '田中鎮'),
    (521, (SELECT id FROM City WHERE city = '彰化縣'), '北斗鎮'),
    (503, (SELECT id FROM City WHERE city = '彰化縣'), '花壇鄉'),
    (502, (SELECT id FROM City WHERE city = '彰化縣'), '芬園鄉'),
    (515, (SELECT id FROM City WHERE city = '彰化縣'), '大村鄉'),
    (512, (SELECT id FROM City WHERE city = '彰化縣'), '永靖鄉'),
    (509, (SELECT id FROM City WHERE city = '彰化縣'), '伸港鄉'),
    (507, (SELECT id FROM City WHERE city = '彰化縣'), '線西鄉'),
    (506, (SELECT id FROM City WHERE city = '彰化縣'), '福興鄉'),
    (504, (SELECT id FROM City WHERE city = '彰化縣'), '秀水鄉'),
    (513, (SELECT id FROM City WHERE city = '彰化縣'), '埔心鄉'),
    (516, (SELECT id FROM City WHERE city = '彰化縣'), '埔鹽鄉'),
    (527, (SELECT id FROM City WHERE city = '彰化縣'), '大城鄉'),
    (528, (SELECT id FROM City WHERE city = '彰化縣'), '芳苑鄉'),
    (525, (SELECT id FROM City WHERE city = '彰化縣'), '竹塘鄉'),
    (511, (SELECT id FROM City WHERE city = '彰化縣'), '社頭鄉'),
    (530, (SELECT id FROM City WHERE city = '彰化縣'), '二水鄉'),
    (522, (SELECT id FROM City WHERE city = '彰化縣'), '田尾鄉'),
    (523, (SELECT id FROM City WHERE city = '彰化縣'), '埤頭鄉'),
    (524, (SELECT id FROM City WHERE city = '彰化縣'), '溪洲鄉'),
    (640, (SELECT id FROM City WHERE city = '雲林縣'), '斗六市'),
    (630, (SELECT id FROM City WHERE city = '雲林縣'), '斗南鎮'),
    (632, (SELECT id FROM City WHERE city = '雲林縣'), '虎尾鎮'),
    (648, (SELECT id FROM City WHERE city = '雲林縣'), '西螺鎮'),
    (633, (SELECT id FROM City WHERE city = '雲林縣'), '土庫鎮'),
    (651, (SELECT id FROM City WHERE city = '雲林縣'), '北港鎮'),
    (647, (SELECT id FROM City WHERE city = '雲林縣'), '莿桐鄉'),
    (643, (SELECT id FROM City WHERE city = '雲林縣'), '林內鄉'),
    (646, (SELECT id FROM City WHERE city = '雲林縣'), '古坑鄉'),
    (631, (SELECT id FROM City WHERE city = '雲林縣'), '大埤鄉'),
    (637, (SELECT id FROM City WHERE city = '雲林縣'), '崙背鄉'),
    (649, (SELECT id FROM City WHERE city = '雲林縣'), '二崙鄉'),
    (638, (SELECT id FROM City WHERE city = '雲林縣'), '麥寮鄉'),
    (636, (SELECT id FROM City WHERE city = '雲林縣'), '臺西鄉'),
    (635, (SELECT id FROM City WHERE city = '雲林縣'), '東勢鄉'),
    (634, (SELECT id FROM City WHERE city = '雲林縣'), '褒忠鄉'),
    (654, (SELECT id FROM City WHERE city = '雲林縣'), '四湖鄉'),
    (653, (SELECT id FROM City WHERE city = '雲林縣'), '口湖鄉'),
    (652, (SELECT id FROM City WHERE city = '雲林縣'), '水林鄉'),
    (655, (SELECT id FROM City WHERE city = '雲林縣'), '元長鄉'),
    (612, (SELECT id FROM City WHERE city = '嘉義縣'), '太保市'),
    (613, (SELECT id FROM City WHERE city = '嘉義縣'), '朴子市'),
    (625, (SELECT id FROM City WHERE city = '嘉義縣'), '布袋鎮'),
    (622, (SELECT id FROM City WHERE city = '嘉義縣'), '大林鎮'),
    (621, (SELECT id FROM City WHERE city = '嘉義縣'), '民雄鄉'),
    (623, (SELECT id FROM City WHERE city = '嘉義縣'), '溪口鄉'),
    (616, (SELECT id FROM City WHERE city = '嘉義縣'), '新港鄉'),
    (615, (SELECT id FROM City WHERE city = '嘉義縣'), '六腳鄉'),
    (614, (SELECT id FROM City WHERE city = '嘉義縣'), '東石鄉'),
    (624, (SELECT id FROM City WHERE city = '嘉義縣'), '義竹鄉'),
    (611, (SELECT id FROM City WHERE city = '嘉義縣'), '鹿草鄉'),
    (608, (SELECT id FROM City WHERE city = '嘉義縣'), '水上鄉'),
    (606, (SELECT id FROM City WHERE city = '嘉義縣'), '中埔鄉'),
    (604, (SELECT id FROM City WHERE city = '嘉義縣'), '竹崎鄉'),
    (603, (SELECT id FROM City WHERE city = '嘉義縣'), '梅山鄉'),
    (602, (SELECT id FROM City WHERE city = '嘉義縣'), '番路鄉'),
    (607, (SELECT id FROM City WHERE city = '嘉義縣'), '大埔鄉'),
    (605, (SELECT id FROM City WHERE city = '嘉義縣'), '阿里山鄉'),
    (600, (SELECT id FROM City WHERE city = '嘉義市'), '東區'),
    (600, (SELECT id FROM City WHERE city = '嘉義市'), '西區'),
    (700, (SELECT id FROM City WHERE city = '台南市'), '中西區'),
    (701, (SELECT id FROM City WHERE city = '台南市'), '東區'),
    (702, (SELECT id FROM City WHERE city = '台南市'), '南區'),
    (704, (SELECT id FROM City WHERE city = '台南市'), '北區'),
    (708, (SELECT id FROM City WHERE city = '台南市'), '安平區'),
    (709, (SELECT id FROM City WHERE city = '台南市'), '安南區'),
    (710, (SELECT id FROM City WHERE city = '台南市'), '永康區'),
    (711, (SELECT id FROM City WHERE city = '台南市'), '歸仁區'),
    (712, (SELECT id FROM City WHERE city = '台南市'), '新化區'),
    (713, (SELECT id FROM City WHERE city = '台南市'), '左鎮區'),
    (714, (SELECT id FROM City WHERE city = '台南市'), '玉井區'),
    (715, (SELECT id FROM City WHERE city = '台南市'), '楠西區'),
    (716, (SELECT id FROM City WHERE city = '台南市'), '南化區'),
    (717, (SELECT id FROM City WHERE city = '台南市'), '仁德區'),
    (718, (SELECT id FROM City WHERE city = '台南市'), '關廟區'),
    (719, (SELECT id FROM City WHERE city = '台南市'), '龍崎區'),
    (720, (SELECT id FROM City WHERE city = '台南市'), '官田區'),
    (721, (SELECT id FROM City WHERE city = '台南市'), '麻豆區'),
    (722, (SELECT id FROM City WHERE city = '台南市'), '佳里區'),
    (723, (SELECT id FROM City WHERE city = '台南市'), '西港區'),
    (724, (SELECT id FROM City WHERE city = '台南市'), '七股區'),
    (725, (SELECT id FROM City WHERE city = '台南市'), '將軍區'),
    (726, (SELECT id FROM City WHERE city = '台南市'), '學甲區'),
    (727, (SELECT id FROM City WHERE city = '台南市'), '北門區'),
    (730, (SELECT id FROM City WHERE city = '台南市'), '新營區'),
    (731, (SELECT id FROM City WHERE city = '台南市'), '後壁區'),
    (732, (SELECT id FROM City WHERE city = '台南市'), '白河區'),
    (733, (SELECT id FROM City WHERE city = '台南市'), '東山區'),
    (734, (SELECT id FROM City WHERE city = '台南市'), '六甲區'),
    (735, (SELECT id FROM City WHERE city = '台南市'), '下營區'),
    (736, (SELECT id FROM City WHERE city = '台南市'), '柳營區'),
    (737, (SELECT id FROM City WHERE city = '台南市'), '鹽水區'),
    (741, (SELECT id FROM City WHERE city = '台南市'), '善化區'),
    (742, (SELECT id FROM City WHERE city = '台南市'), '大內區'),
    (743, (SELECT id FROM City WHERE city = '台南市'), '山上區'),
    (744, (SELECT id FROM City WHERE city = '台南市'), '新市區'),
    (745, (SELECT id FROM City WHERE city = '台南市'), '安定區'),
    (811, (SELECT id FROM City WHERE city = '高雄市'), '楠梓區'),
    (813, (SELECT id FROM City WHERE city = '高雄市'), '左營區'),
    (804, (SELECT id FROM City WHERE city = '高雄市'), '鼓山區'),
    (807, (SELECT id FROM City WHERE city = '高雄市'), '三民區'),
    (803, (SELECT id FROM City WHERE city = '高雄市'), '鹽埕區'),
    (801, (SELECT id FROM City WHERE city = '高雄市'), '前金區'),
    (800, (SELECT id FROM City WHERE city = '高雄市'), '新興區'),
    (802, (SELECT id FROM City WHERE city = '高雄市'), '苓雅區'),
    (806, (SELECT id FROM City WHERE city = '高雄市'), '前鎮區'),
    (812, (SELECT id FROM City WHERE city = '高雄市'), '小港區'),
    (805, (SELECT id FROM City WHERE city = '高雄市'), '旗津區'),
    (830, (SELECT id FROM City WHERE city = '高雄市'), '鳳山區'),
    (831, (SELECT id FROM City WHERE city = '高雄市'), '大寮區'),
    (833, (SELECT id FROM City WHERE city = '高雄市'), '鳥松區'),
    (832, (SELECT id FROM City WHERE city = '高雄市'), '林園區'),
    (814, (SELECT id FROM City WHERE city = '高雄市'), '仁武區'),
    (840, (SELECT id FROM City WHERE city = '高雄市'), '大樹區'),
    (815, (SELECT id FROM City WHERE city = '高雄市'), '大社區'),
    (820, (SELECT id FROM City WHERE city = '高雄市'), '岡山區'),
    (821, (SELECT id FROM City WHERE city = '高雄市'), '路竹區'),
    (825, (SELECT id FROM City WHERE city = '高雄市'), '橋頭區'),
    (826, (SELECT id FROM City WHERE city = '高雄市'), '梓官區'),
    (827, (SELECT id FROM City WHERE city = '高雄市'), '彌陀區'),
    (828, (SELECT id FROM City WHERE city = '高雄市'), '永安區'),
    (824, (SELECT id FROM City WHERE city = '高雄市'), '燕巢區'),
    (823, (SELECT id FROM City WHERE city = '高雄市'), '田寮區'),
    (822, (SELECT id FROM City WHERE city = '高雄市'), '阿蓮區'),
    (852, (SELECT id FROM City WHERE city = '高雄市'), '茄萣區'),
    (829, (SELECT id FROM City WHERE city = '高雄市'), '湖內區'),
    (842, (SELECT id FROM City WHERE city = '高雄市'), '旗山區'),
    (843, (SELECT id FROM City WHERE city = '高雄市'), '美濃區'),
    (845, (SELECT id FROM City WHERE city = '高雄市'), '內門區'),
    (846, (SELECT id FROM City WHERE city = '高雄市'), '杉林區'),
    (847, (SELECT id FROM City WHERE city = '高雄市'), '甲仙區'),
    (844, (SELECT id FROM City WHERE city = '高雄市'), '六龜區'),
    (851, (SELECT id FROM City WHERE city = '高雄市'), '茂林區'),
    (848, (SELECT id FROM City WHERE city = '高雄市'), '桃源區'),
    (849, (SELECT id FROM City WHERE city = '高雄市'), '那瑪夏區'),
    (900, (SELECT id FROM City WHERE city = '屏東縣'), '屏東市'),
    (920, (SELECT id FROM City WHERE city = '屏東縣'), '潮州鎮'),
    (928, (SELECT id FROM City WHERE city = '屏東縣'), '東港鎮'),
    (946, (SELECT id FROM City WHERE city = '屏東縣'), '恆春鎮'),
    (913, (SELECT id FROM City WHERE city = '屏東縣'), '萬丹鄉'),
    (908, (SELECT id FROM City WHERE city = '屏東縣'), '長治鄉'),
    (909, (SELECT id FROM City WHERE city = '屏東縣'), '麟洛鄉'),
    (904, (SELECT id FROM City WHERE city = '屏東縣'), '九如鄉'),
    (905, (SELECT id FROM City WHERE city = '屏東縣'), '里港鄉'),
    (907, (SELECT id FROM City WHERE city = '屏東縣'), '鹽埔鄉'),
    (906, (SELECT id FROM City WHERE city = '屏東縣'), '高樹鄉'),
    (923, (SELECT id FROM City WHERE city = '屏東縣'), '萬巒鄉'),
    (912, (SELECT id FROM City WHERE city = '屏東縣'), '內埔鄉'),
    (911, (SELECT id FROM City WHERE city = '屏東縣'), '竹田鄉'),
    (925, (SELECT id FROM City WHERE city = '屏東縣'), '新埤鄉'),
    (940, (SELECT id FROM City WHERE city = '屏東縣'), '枋寮鄉'),
    (932, (SELECT id FROM City WHERE city = '屏東縣'), '新園鄉'),
    (924, (SELECT id FROM City WHERE city = '屏東縣'), '崁頂鄉'),
    (927, (SELECT id FROM City WHERE city = '屏東縣'), '林邊鄉'),
    (926, (SELECT id FROM City WHERE city = '屏東縣'), '南州鄉'),
    (931, (SELECT id FROM City WHERE city = '屏東縣'), '佳冬鄉'),
    (929, (SELECT id FROM City WHERE city = '屏東縣'), '琉球鄉'),
    (944, (SELECT id FROM City WHERE city = '屏東縣'), '車城鄉'),
    (947, (SELECT id FROM City WHERE city = '屏東縣'), '滿州鄉'),
    (941, (SELECT id FROM City WHERE city = '屏東縣'), '枋山鄉'),
    (902, (SELECT id FROM City WHERE city = '屏東縣'), '霧台鄉'),
    (903, (SELECT id FROM City WHERE city = '屏東縣'), '瑪家鄉'),
    (921, (SELECT id FROM City WHERE city = '屏東縣'), '泰武鄉'),
    (922, (SELECT id FROM City WHERE city = '屏東縣'), '來義鄉'),
    (942, (SELECT id FROM City WHERE city = '屏東縣'), '春日鄉'),
    (943, (SELECT id FROM City WHERE city = '屏東縣'), '獅子鄉'),
    (945, (SELECT id FROM City WHERE city = '屏東縣'), '牡丹鄉'),
    (901, (SELECT id FROM City WHERE city = '屏東縣'), '三地門鄉'),
    (260, (SELECT id FROM City WHERE city = '宜蘭縣'), '宜蘭市'),
    (265, (SELECT id FROM City WHERE city = '宜蘭縣'), '羅東鎮'),
    (270, (SELECT id FROM City WHERE city = '宜蘭縣'), '蘇澳鎮'),
    (261, (SELECT id FROM City WHERE city = '宜蘭縣'), '頭城鎮'),
    (262, (SELECT id FROM City WHERE city = '宜蘭縣'), '礁溪鄉'),
    (263, (SELECT id FROM City WHERE city = '宜蘭縣'), '壯圍鄉'),
    (264, (SELECT id FROM City WHERE city = '宜蘭縣'), '員山鄉'),
    (269, (SELECT id FROM City WHERE city = '宜蘭縣'), '冬山鄉'),
    (268, (SELECT id FROM City WHERE city = '宜蘭縣'), '五結鄉'),
    (266, (SELECT id FROM City WHERE city = '宜蘭縣'), '三星鄉'),
    (267, (SELECT id FROM City WHERE city = '宜蘭縣'), '大同鄉'),
    (272, (SELECT id FROM City WHERE city = '宜蘭縣'), '南澳鄉'),
    (970, (SELECT id FROM City WHERE city = '花蓮縣'), '花蓮市'),
    (975, (SELECT id FROM City WHERE city = '花蓮縣'), '鳳林鎮'),
    (981, (SELECT id FROM City WHERE city = '花蓮縣'), '玉里鎮'),
    (971, (SELECT id FROM City WHERE city = '花蓮縣'), '新城鄉'),
    (973, (SELECT id FROM City WHERE city = '花蓮縣'), '吉安鄉'),
    (974, (SELECT id FROM City WHERE city = '花蓮縣'), '壽豐鄉'),
    (972, (SELECT id FROM City WHERE city = '花蓮縣'), '秀林鄉'),
    (978, (SELECT id FROM City WHERE city = '花蓮縣'), '瑞穗鄉'),
    (976, (SELECT id FROM City WHERE city = '花蓮縣'), '光復鄉'),
    (977, (SELECT id FROM City WHERE city = '花蓮縣'), '豐濱鄉'),
    (979, (SELECT id FROM City WHERE city = '花蓮縣'), '萬榮鄉'),
    (983, (SELECT id FROM City WHERE city = '花蓮縣'), '富里鄉'),
    (982, (SELECT id FROM City WHERE city = '花蓮縣'), '卓溪鄉'),
    (950, (SELECT id FROM City WHERE city = '台東縣'), '台東市'),
    (961, (SELECT id FROM City WHERE city = '台東縣'), '成功鎮'),
    (956, (SELECT id FROM City WHERE city = '台東縣'), '關山鎮'),
    (962, (SELECT id FROM City WHERE city = '台東縣'), '長濱鄉'),
    (957, (SELECT id FROM City WHERE city = '台東縣'), '海端鄉'),
    (958, (SELECT id FROM City WHERE city = '台東縣'), '池上鄉'),
    (959, (SELECT id FROM City WHERE city = '台東縣'), '東河鄉'),
    (955, (SELECT id FROM City WHERE city = '台東縣'), '鹿野鄉'),
    (953, (SELECT id FROM City WHERE city = '台東縣'), '延平鄉'),
    (954, (SELECT id FROM City WHERE city = '台東縣'), '卑南鄉'),
    (964, (SELECT id FROM City WHERE city = '台東縣'), '金峰鄉'),
    (965, (SELECT id FROM City WHERE city = '台東縣'), '大武鄉'),
    (966, (SELECT id FROM City WHERE city = '台東縣'), '達仁鄉'),
    (951, (SELECT id FROM City WHERE city = '台東縣'), '綠島鄉'),
    (952, (SELECT id FROM City WHERE city = '台東縣'), '蘭嶼鄉'),
    (963, (SELECT id FROM City WHERE city = '台東縣'), '太麻里鄉'),
    (880, (SELECT id FROM City WHERE city = '澎湖縣'), '馬公市'),
    (885, (SELECT id FROM City WHERE city = '澎湖縣'), '湖西鄉'),
    (884, (SELECT id FROM City WHERE city = '澎湖縣'), '白沙鄉'),
    (881, (SELECT id FROM City WHERE city = '澎湖縣'), '西嶼鄉'),
    (882, (SELECT id FROM City WHERE city = '澎湖縣'), '望安鄉'),
    (883, (SELECT id FROM City WHERE city = '澎湖縣'), '七美鄉'),
    (893, (SELECT id FROM City WHERE city = '金門縣'), '金城鎮'),
    (891, (SELECT id FROM City WHERE city = '金門縣'), '金湖鎮'),
    (890, (SELECT id FROM City WHERE city = '金門縣'), '金沙鎮'),
    (892, (SELECT id FROM City WHERE city = '金門縣'), '金寧鄉'),
    (894, (SELECT id FROM City WHERE city = '金門縣'), '烈嶼鄉'),
    (896, (SELECT id FROM City WHERE city = '金門縣'), '烏坵鄉'),
    (209, (SELECT id FROM City WHERE city = '連江縣'), '南竿鄉'),
    (210, (SELECT id FROM City WHERE city = '連江縣'), '北竿鄉'),
    (211, (SELECT id FROM City WHERE city = '連江縣'), '莒光鄉'),
    (212, (SELECT id FROM City WHERE city = '連江縣'), '東引鄉');

INSERT INTO SeriesTitle (name_title)
VALUES
    ('海賊王系列第一蛋'),
    ('企鵝家族系列第一蛋'),
    ('海賊王系列第二彈'),
    ('海賊王系列第三彈');

INSERT INTO Users (name, email, password, phone, birth, county_id, road, credit, created_at, updated_at)
VALUES 
('嘎丘拉', 'gachora@qq.com', 1111, '0912345678', '2000-1-1', 1, '鄉間小路1段1號', 1234567887654321, FROM_UNIXTIME(1697054564), FROM_UNIXTIME(1698110564)),
('嘎丘羅', 'gachoro@qq.com', 2222, '0912345678', '2000-2-2', 2, '鄉間小路2段2號', 1234567887654322, FROM_UNIXTIME(1697754564), FROM_UNIXTIME(1698109564));

INSERT INTO Series (category_id, name_title_id, name, theme_id, price_id, stock, release_time, end_time)
VALUES
    (1, 1, '海賊王系列第一蛋商品', 1, 4, 1, 1698154564, 1698154564),
    (1, 2, '企鵝家族系第一蛋商品', 2, 3, 3, 1698157304, 1698157304),
    (2, 3, '海賊王系列第二彈商品', 1, 5, 2, 1698153454, 1698153454),
    (1, 4, '海賊王系列第三蛋商品', 1, 6, 4, 1698012344, 1698092344);

INSERT INTO Characters (series_id, prize_id, name, material_id, size1, size2, size3, img)
VALUES
    (1, 1, '魯夫', 2, 5, 5, 5, 'https://dummyimage.com/500x500/e8b603/000000&text=海賊王第一蛋:魯夫'),
    (1, 2, '喬巴', 1, 5, 5, 5, 'https://dummyimage.com/500x500/e8b603/000000&text=海賊王第一蛋:喬巴'),
    (1, 3, '娜美', 3, 5, 5, 5, 'https://dummyimage.com/500x500/e8b603/000000&text=海賊王第一蛋:娜美'),
    (2, 1, '大企鵝', 4, 8, 8, 8, 'https://dummyimage.com/500x500/e8b603/000000&text=企鵝第一蛋:大企鵝'),
    (2, 2, '小企鵝', 5, 8, 8, 8, 'https://dummyimage.com/500x500/e8b603/000000&text=企鵝第一蛋:小企鵝'),
    (2, 3, '海豹', 4, 8, 8, 8, 'https://dummyimage.com/500x500/e8b603/000000&text=企鵝第一蛋:海豹'),
    (3, 1, '黑鬍子', 3, 45, 45, 45, 'https://dummyimage.com/500x500/e8b603/000000&text=海賊王系列第二番:黑鬍子'),
    (3, 2, '沒鬍子', 1, 53, 40, 30, 'https://dummyimage.com/500x500/e8b603/000000&text=海賊王系列第二番:沒鬍子'),
    (3, 3, '白鬍子', 2, 60, 50, 50, 'https://dummyimage.com/500x500/e8b603/000000&text=海賊王系列第二番:白鬍子'),
    (3, 4, '紅鬍子', 2, 60, 50, 50, 'https://dummyimage.com/500x500/e8b603/000000&text=海賊王系列第二番:紅鬍子'),
    (4, 1, '沙皇', 4, 7, 7, 7, 'https://dummyimage.com/500x500/e8b603/000000&text=海賊王第三蛋:沙皇'),
    (4, 2, '草帽', 2, 7, 7, 7, 'https://dummyimage.com/500x500/e8b603/000000&text=海賊王第三蛋:草帽'),
    (4, 3, '七武海', 3, 7, 7, 7, 'https://dummyimage.com/500x500/e8b603/000000&text=海賊王第三蛋:七武海');

INSERT INTO Machine (character_id, remain, amount)
VALUES
    (1, 0, 6),
    (2, 0, 6),
    (3, 0, 6),
    (4, 6, 6),
    (5, 6, 6),
    (6, 5, 6),
    (7, 5, 6),
    (8, 5, 6),
    (9, 6, 6),
    (10, 5, 5),
    (11, 4, 5),
    (12, 5, 5),
    (13, 5, 5);

INSERT INTO SeriesImg (series_id, img)
VALUES
    (1, 'https://dummyimage.com/500x500/e8b603/000000&text=海賊王系列第一蛋系列1'),
    (1, 'https://dummyimage.com/500x500/e8b603/000000&text=海賊王系列第一蛋系列2'),
    (2, 'https://dummyimage.com/500x500/e8b603/000000&text=企鵝家族系第一蛋系列1'),
    (2, 'https://dummyimage.com/500x500/e8b603/000000&text=企鵝家族系第一蛋系列2'),
    (2, 'https://dummyimage.com/500x500/e8b603/000000&text=企鵝家族系第一蛋系列3'),
    (3, 'https://dummyimage.com/500x500/e8b603/000000&text=海賊王系列第二賞系列1'),
    (3, 'https://dummyimage.com/500x500/e8b603/000000&text=海賊王系列第二賞系列2'),
    (3, 'https://dummyimage.com/500x500/e8b603/000000&text=海賊王系列第二賞系列3'),
    (4, 'https://dummyimage.com/500x500/e8b603/000000&text=海賊王系列第三蛋系列1');


INSERT INTO Records (time, user_id, character_id, label, status_id)
VALUES
    (1698234865, 1, 1, null, 6),
    (1698245865, 1, 1, null, 7),
    (1698256865, 1, 6, null, 4),
    (1698267865, 2, 7, 5, 4),
    (1698267865, 1, 8, 3, 4),
    (1698231865, 1, 11, null, 5);

INSERT INTO Bill (user_id, create_at, gash_id, update_at)
VALUES
    (1, 1697888888, 1, 1736888999),
    (1, 1697888888, 3, 1697888999),
    (1, 1697888888, 5, 1735888999),
    (1, 1697888888, 6, null);

INSERT INTO Collection (user_id, series_id, notification_status)
VALUES
    (1, 1, 11),
    (1, 2, 10),
    (1, 3, 10),
    (1, 4, 11);


INSERT INTO LogisticsPeople (user_id, name, phone, email, status_id)
VALUES
(1, '大大1', 0910234567, 'big1@qq.com', 13),
(1, '大大2', 0910234456, 'big2@qq.com', 12);

INSERT INTO Address (user_id, title, county_id, road, status_id)
VALUES
(1, '家', 20, '鄉間小路1號', 13),
(1, '公司', 1, '康莊大道0號', 12);

INSERT INTO Logistics (user_id, logistics_people_id, address_id, method_id, status_id, time, deliver_time)
VALUES
(1, 1, 2, 1, 7, 1697735674, 2),
(1, 2, 1, 2, 8, 1697620375, 1);

INSERT INTO LogisticsItem (logistics_id, records_id)
VALUES
    (1, 1),
    (1, 2),
    (2, 5),
    (2, 4),
    (1, 3);

INSERT INTO Gift (user_id, category_id, amount, update_at, expire_at)
VALUES
    (1, 4, 200, 1697888888, 1697899999),
    (1, 5, 200, 1697666666, 1697888888);

INSERT INTO Waitinglist (series_id, user_id, number, time)
VALUES
(3, 1, 1, 1697888888),
(3, 2, 2, null);

insert into Price (price) values(-200);

insert into Series(category_id, name, price_id, stock)
values
(4, '生日禮', 21, 1),
(5, '推薦禮', 21, 1);

insert into Characters (series_id, name) values(5,'生日禮'), (6,'推薦禮');

INSERT INTO Records (time, user_id, character_id, label, status_id)
VALUES
    (1698234865, 1, 14, null, 2),
    (1698234865, 1, 15, null, 2);
