-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- 主機： localhost
-- 產生時間： 2024 年 12 月 13 日 10:52
-- 伺服器版本： 10.4.28-MariaDB
-- PHP 版本： 8.2.4
DROP DATABASE IF EXISTS Gachora;
CREATE DATABASE Gachora;
USE Gachora;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫： `Gachora`
--

-- --------------------------------------------------------

--
-- 資料表結構 `Address`
--

CREATE TABLE `Address` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '會員id',
  `title` varchar(5) DEFAULT NULL COMMENT '收件地識別標題or門市',
  `county_id` smallint(5) UNSIGNED NOT NULL COMMENT '城id',
  `road` varchar(25) NOT NULL COMMENT '路',
  `status_id` tinyint(3) UNSIGNED DEFAULT 13 COMMENT '常用id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `Address`
--

INSERT INTO `Address` (`id`, `user_id`, `title`, `county_id`, `road`, `status_id`) VALUES
(1, 1, '家', 20, '鄉間小路1號', 13),
(2, 1, '公司', 1, '康莊大道0號', 12);

-- --------------------------------------------------------

--
-- 資料表結構 `Bill`
--

CREATE TABLE `Bill` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL COMMENT '會員id',
  `create_at` bigint(20) NOT NULL COMMENT '儲值時間',
  `gash_id` tinyint(3) UNSIGNED NOT NULL COMMENT '儲值金id',
  `update_at` bigint(20) DEFAULT NULL COMMENT '入帳時間'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `Bill`
--

INSERT INTO `Bill` (`id`, `user_id`, `create_at`, `gash_id`, `update_at`) VALUES
(1, 1, 1697888888, 1, 1736888999),
(2, 1, 1697888888, 3, 1697888999),
(3, 1, 1697888888, 5, 1735888999),
(4, 1, 1697888888, 6, NULL);

-- --------------------------------------------------------

--
-- 資料表結構 `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('alex12345@gmail.com|::1', 'i:1;', 1733644855),
('alex12345@gmail.com|::1:timer', 'i:1733644855;', 1733644855);

-- --------------------------------------------------------

--
-- 資料表結構 `Category`
--

CREATE TABLE `Category` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `category` varchar(3) DEFAULT NULL COMMENT '商品類'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `Category`
--

INSERT INTO `Category` (`id`, `category`) VALUES
(2, '一番賞'),
(3, '儲值'),
(1, '扭蛋'),
(5, '推薦禮'),
(4, '生日禮');

-- --------------------------------------------------------

--
-- 資料表結構 `Characters`
--

CREATE TABLE `Characters` (
  `id` int(10) UNSIGNED NOT NULL,
  `series_id` int(10) UNSIGNED NOT NULL COMMENT '系列id',
  `prize_id` tinyint(3) UNSIGNED DEFAULT NULL COMMENT '賞別id',
  `name` varchar(20) NOT NULL COMMENT '角色名',
  `img` varchar(100) DEFAULT NULL COMMENT '角色圖',
  `material_id` tinyint(3) UNSIGNED DEFAULT NULL COMMENT '材質id',
  `size1` tinyint(3) UNSIGNED DEFAULT NULL COMMENT '長',
  `size2` tinyint(3) UNSIGNED DEFAULT NULL COMMENT '中',
  `size3` tinyint(3) UNSIGNED DEFAULT NULL COMMENT '短'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `Characters`
--

INSERT INTO `Characters` (`id`, `series_id`, `prize_id`, `name`, `img`, `material_id`, `size1`, `size2`, `size3`) VALUES
(1, 1, 1, '魯夫', 'https://dummyimage.com/500x500/e8b603/000000&text=海賊王第一蛋:魯夫', 2, 5, 5, 5),
(2, 1, 2, '喬巴', 'https://dummyimage.com/500x500/e8b603/000000&text=海賊王第一蛋:喬巴', 1, 5, 5, 5),
(3, 1, 3, '娜美', 'https://dummyimage.com/500x500/e8b603/000000&text=海賊王第一蛋:娜美', 3, 5, 5, 5),
(4, 2, 1, '大企鵝', 'https://dummyimage.com/500x500/e8b603/000000&text=企鵝第一蛋:大企鵝', 4, 8, 8, 8),
(5, 2, 2, '小企鵝', 'https://dummyimage.com/500x500/e8b603/000000&text=企鵝第一蛋:小企鵝', 5, 8, 8, 8),
(6, 2, 3, '海豹', 'https://dummyimage.com/500x500/e8b603/000000&text=企鵝第一蛋:海豹', 4, 8, 8, 8),
(7, 3, 1, '黑鬍子', 'https://dummyimage.com/500x500/e8b603/000000&text=海賊王系列第二番:黑鬍子', 3, 45, 45, 45),
(8, 3, 2, '沒鬍子', 'https://dummyimage.com/500x500/e8b603/000000&text=海賊王系列第二番:沒鬍子', 1, 53, 40, 30),
(9, 3, 3, '白鬍子', 'https://dummyimage.com/500x500/e8b603/000000&text=海賊王系列第二番:白鬍子', 2, 60, 50, 50),
(10, 3, 4, '紅鬍子', 'https://dummyimage.com/500x500/e8b603/000000&text=海賊王系列第二番:紅鬍子', 2, 60, 50, 50),
(11, 4, 1, '沙皇', 'https://dummyimage.com/500x500/e8b603/000000&text=海賊王第三蛋:沙皇', 4, 7, 7, 7),
(12, 4, 2, '草帽', 'https://dummyimage.com/500x500/e8b603/000000&text=海賊王第三蛋:草帽', 2, 7, 7, 7),
(13, 4, 3, '七武海', 'https://dummyimage.com/500x500/e8b603/000000&text=海賊王第三蛋:七武海', 3, 7, 7, 7),
(14, 5, NULL, '生日禮', NULL, NULL, NULL, NULL, NULL),
(15, 6, NULL, '推薦禮', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- 資料表結構 `City`
--

CREATE TABLE `City` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `city` varchar(3) NOT NULL COMMENT '縣'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `City`
--

INSERT INTO `City` (`id`, `city`) VALUES
(1, '台北市'),
(2, '新北市'),
(3, '基隆市'),
(4, '桃園市'),
(5, '新竹縣'),
(6, '新竹市'),
(7, '苗栗縣'),
(8, '台中市'),
(9, '南投縣'),
(10, '彰化縣'),
(11, '雲林縣'),
(12, '嘉義縣'),
(13, '嘉義市'),
(14, '台南市'),
(15, '高雄市'),
(16, '屏東縣'),
(17, '宜蘭縣'),
(18, '花蓮縣'),
(19, '台東縣'),
(20, '澎湖縣'),
(21, '金門縣'),
(22, '連江縣');

-- --------------------------------------------------------

--
-- 資料表結構 `Collection`
--

CREATE TABLE `Collection` (
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '會員id',
  `series_id` int(10) UNSIGNED NOT NULL COMMENT '系列id',
  `notification_status` tinyint(3) UNSIGNED DEFAULT 10 COMMENT '是否補貨'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `Collection`
--

INSERT INTO `Collection` (`user_id`, `series_id`, `notification_status`) VALUES
(1, 1, 11),
(1, 2, 10),
(1, 3, 10),
(1, 4, 11);

-- --------------------------------------------------------

--
-- 資料表結構 `County`
--

CREATE TABLE `County` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `zipcode` smallint(5) UNSIGNED DEFAULT NULL COMMENT '郵遞區號',
  `city_id` tinyint(3) UNSIGNED DEFAULT NULL COMMENT '縣id',
  `county` varchar(4) NOT NULL COMMENT '城'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `County`
--

INSERT INTO `County` (`id`, `zipcode`, `city_id`, `county`) VALUES
(1, 100, 1, '中正區'),
(2, 103, 1, '大同區'),
(3, 104, 1, '中山區'),
(4, 105, 1, '松山區'),
(5, 106, 1, '大安區'),
(6, 108, 1, '萬華區'),
(7, 110, 1, '信義區'),
(8, 111, 1, '士林區'),
(9, 112, 1, '北投區'),
(10, 114, 1, '內湖區'),
(11, 115, 1, '南港區'),
(12, 116, 1, '文山區'),
(13, 220, 2, '板橋區'),
(14, 242, 2, '新莊區'),
(15, 243, 2, '泰山區'),
(16, 244, 2, '林口區'),
(17, 251, 2, '淡水區'),
(18, 208, 2, '金山區'),
(19, 249, 2, '八里區'),
(20, 207, 2, '萬里區'),
(21, 253, 2, '石門區'),
(22, 252, 2, '三芝區'),
(23, 224, 2, '瑞芳區'),
(24, 221, 2, '汐止區'),
(25, 226, 2, '平溪區'),
(26, 228, 2, '貢寮區'),
(27, 227, 2, '雙溪區'),
(28, 222, 2, '深坑區'),
(29, 223, 2, '石碇區'),
(30, 231, 2, '新店區'),
(31, 232, 2, '坪林區'),
(32, 233, 2, '烏來區'),
(33, 235, 2, '中和區'),
(34, 234, 2, '永和區'),
(35, 236, 2, '土城區'),
(36, 237, 2, '三峽區'),
(37, 238, 2, '樹林區'),
(38, 239, 2, '鶯歌區'),
(39, 241, 2, '三重區'),
(40, 247, 2, '蘆洲區'),
(41, 248, 2, '五股區'),
(42, 200, 3, '仁愛區'),
(43, 202, 3, '中正區'),
(44, 201, 3, '信義區'),
(45, 203, 3, '中山區'),
(46, 204, 3, '安樂區'),
(47, 205, 3, '暖暖區'),
(48, 206, 3, '七堵區'),
(49, 330, 4, '桃園區'),
(50, 320, 4, '中壢區'),
(51, 324, 4, '平鎮區'),
(52, 334, 4, '八德區'),
(53, 326, 4, '楊梅區'),
(54, 338, 4, '蘆竹區'),
(55, 333, 4, '龜山區'),
(56, 325, 4, '龍潭區'),
(57, 335, 4, '大溪區'),
(58, 337, 4, '大園區'),
(59, 328, 4, '觀音區'),
(60, 327, 4, '新屋區'),
(61, 336, 4, '復興區'),
(62, 302, 5, '竹北市'),
(63, 310, 5, '竹東鎮'),
(64, 305, 5, '新埔鎮'),
(65, 306, 5, '關西鎮'),
(66, 315, 5, '峨眉鎮'),
(67, 308, 5, '寶山鄉'),
(68, 314, 5, '北埔鄉'),
(69, 312, 5, '橫山鄉'),
(70, 307, 5, '芎林鄉'),
(71, 303, 5, '湖口鄉'),
(72, 304, 5, '新豐鄉'),
(73, 313, 5, '尖石鄉'),
(74, 311, 5, '五峰鄉'),
(75, 300, 6, '東區'),
(76, 300, 6, '北區'),
(77, 300, 6, '香山區'),
(78, 360, 7, '苗栗市'),
(79, 357, 7, '通霄鎮'),
(80, 358, 7, '苑裡鎮'),
(81, 350, 7, '竹南鎮'),
(82, 351, 7, '頭份鎮'),
(83, 356, 7, '後龍鎮'),
(84, 369, 7, '卓蘭鎮'),
(85, 368, 7, '西湖鄉'),
(86, 362, 7, '頭屋鄉'),
(87, 363, 7, '公館鄉'),
(88, 366, 7, '銅鑼鄉'),
(89, 367, 7, '三義鄉'),
(90, 361, 7, '造橋鄉'),
(91, 352, 7, '三灣鄉'),
(92, 353, 7, '南庄鄉'),
(93, 364, 7, '大湖鄉'),
(94, 354, 7, '獅潭鄉'),
(95, 365, 7, '泰安鄉'),
(96, 400, 8, '中區'),
(97, 401, 8, '東區'),
(98, 402, 8, '南區'),
(99, 403, 8, '西區'),
(100, 404, 8, '北區'),
(101, 406, 8, '北屯區'),
(102, 407, 8, '西屯區'),
(103, 508, 8, '南屯區'),
(104, 411, 8, '太平區'),
(105, 412, 8, '大里區'),
(106, 413, 8, '霧峰區'),
(107, 414, 8, '烏日區'),
(108, 420, 8, '豐原區'),
(109, 421, 8, '后里區'),
(110, 423, 8, '東勢區'),
(111, 422, 8, '石崗區'),
(112, 426, 8, '新社區'),
(113, 424, 8, '和平區'),
(114, 429, 8, '神岡區'),
(115, 427, 8, '潭子區'),
(116, 428, 8, '大雅區'),
(117, 432, 8, '大肚區'),
(118, 434, 8, '龍井區'),
(119, 433, 8, '沙鹿區'),
(120, 435, 8, '梧棲區'),
(121, 436, 8, '清水區'),
(122, 437, 8, '大甲區'),
(123, 438, 8, '外埔區'),
(124, 439, 8, '大安區'),
(125, 540, 9, '南投市'),
(126, 545, 9, '埔里鎮'),
(127, 542, 9, '草屯鎮'),
(128, 557, 9, '竹山鎮'),
(129, 552, 9, '集集鎮'),
(130, 551, 9, '名間鄉'),
(131, 558, 9, '鹿谷鄉'),
(132, 541, 9, '中寮鄉'),
(133, 555, 9, '魚池鄉'),
(134, 544, 9, '國姓鄉'),
(135, 553, 9, '水里鄉'),
(136, 556, 9, '信義鄉'),
(137, 546, 9, '仁愛鄉'),
(138, 500, 10, '彰化市'),
(139, 510, 10, '員林市'),
(140, 508, 10, '和美鎮'),
(141, 505, 10, '鹿港鎮'),
(142, 514, 10, '溪湖鎮'),
(143, 526, 10, '二林鎮'),
(144, 520, 10, '田中鎮'),
(145, 521, 10, '北斗鎮'),
(146, 503, 10, '花壇鄉'),
(147, 502, 10, '芬園鄉'),
(148, 515, 10, '大村鄉'),
(149, 512, 10, '永靖鄉'),
(150, 509, 10, '伸港鄉'),
(151, 507, 10, '線西鄉'),
(152, 506, 10, '福興鄉'),
(153, 504, 10, '秀水鄉'),
(154, 513, 10, '埔心鄉'),
(155, 516, 10, '埔鹽鄉'),
(156, 527, 10, '大城鄉'),
(157, 528, 10, '芳苑鄉'),
(158, 525, 10, '竹塘鄉'),
(159, 511, 10, '社頭鄉'),
(160, 530, 10, '二水鄉'),
(161, 522, 10, '田尾鄉'),
(162, 523, 10, '埤頭鄉'),
(163, 524, 10, '溪洲鄉'),
(164, 640, 11, '斗六市'),
(165, 630, 11, '斗南鎮'),
(166, 632, 11, '虎尾鎮'),
(167, 648, 11, '西螺鎮'),
(168, 633, 11, '土庫鎮'),
(169, 651, 11, '北港鎮'),
(170, 647, 11, '莿桐鄉'),
(171, 643, 11, '林內鄉'),
(172, 646, 11, '古坑鄉'),
(173, 631, 11, '大埤鄉'),
(174, 637, 11, '崙背鄉'),
(175, 649, 11, '二崙鄉'),
(176, 638, 11, '麥寮鄉'),
(177, 636, 11, '臺西鄉'),
(178, 635, 11, '東勢鄉'),
(179, 634, 11, '褒忠鄉'),
(180, 654, 11, '四湖鄉'),
(181, 653, 11, '口湖鄉'),
(182, 652, 11, '水林鄉'),
(183, 655, 11, '元長鄉'),
(184, 612, 12, '太保市'),
(185, 613, 12, '朴子市'),
(186, 625, 12, '布袋鎮'),
(187, 622, 12, '大林鎮'),
(188, 621, 12, '民雄鄉'),
(189, 623, 12, '溪口鄉'),
(190, 616, 12, '新港鄉'),
(191, 615, 12, '六腳鄉'),
(192, 614, 12, '東石鄉'),
(193, 624, 12, '義竹鄉'),
(194, 611, 12, '鹿草鄉'),
(195, 608, 12, '水上鄉'),
(196, 606, 12, '中埔鄉'),
(197, 604, 12, '竹崎鄉'),
(198, 603, 12, '梅山鄉'),
(199, 602, 12, '番路鄉'),
(200, 607, 12, '大埔鄉'),
(201, 605, 12, '阿里山鄉'),
(202, 600, 13, '東區'),
(203, 600, 13, '西區'),
(204, 700, 14, '中西區'),
(205, 701, 14, '東區'),
(206, 702, 14, '南區'),
(207, 704, 14, '北區'),
(208, 708, 14, '安平區'),
(209, 709, 14, '安南區'),
(210, 710, 14, '永康區'),
(211, 711, 14, '歸仁區'),
(212, 712, 14, '新化區'),
(213, 713, 14, '左鎮區'),
(214, 714, 14, '玉井區'),
(215, 715, 14, '楠西區'),
(216, 716, 14, '南化區'),
(217, 717, 14, '仁德區'),
(218, 718, 14, '關廟區'),
(219, 719, 14, '龍崎區'),
(220, 720, 14, '官田區'),
(221, 721, 14, '麻豆區'),
(222, 722, 14, '佳里區'),
(223, 723, 14, '西港區'),
(224, 724, 14, '七股區'),
(225, 725, 14, '將軍區'),
(226, 726, 14, '學甲區'),
(227, 727, 14, '北門區'),
(228, 730, 14, '新營區'),
(229, 731, 14, '後壁區'),
(230, 732, 14, '白河區'),
(231, 733, 14, '東山區'),
(232, 734, 14, '六甲區'),
(233, 735, 14, '下營區'),
(234, 736, 14, '柳營區'),
(235, 737, 14, '鹽水區'),
(236, 741, 14, '善化區'),
(237, 742, 14, '大內區'),
(238, 743, 14, '山上區'),
(239, 744, 14, '新市區'),
(240, 745, 14, '安定區'),
(241, 811, 15, '楠梓區'),
(242, 813, 15, '左營區'),
(243, 804, 15, '鼓山區'),
(244, 807, 15, '三民區'),
(245, 803, 15, '鹽埕區'),
(246, 801, 15, '前金區'),
(247, 800, 15, '新興區'),
(248, 802, 15, '苓雅區'),
(249, 806, 15, '前鎮區'),
(250, 812, 15, '小港區'),
(251, 805, 15, '旗津區'),
(252, 830, 15, '鳳山區'),
(253, 831, 15, '大寮區'),
(254, 833, 15, '鳥松區'),
(255, 832, 15, '林園區'),
(256, 814, 15, '仁武區'),
(257, 840, 15, '大樹區'),
(258, 815, 15, '大社區'),
(259, 820, 15, '岡山區'),
(260, 821, 15, '路竹區'),
(261, 825, 15, '橋頭區'),
(262, 826, 15, '梓官區'),
(263, 827, 15, '彌陀區'),
(264, 828, 15, '永安區'),
(265, 824, 15, '燕巢區'),
(266, 823, 15, '田寮區'),
(267, 822, 15, '阿蓮區'),
(268, 852, 15, '茄萣區'),
(269, 829, 15, '湖內區'),
(270, 842, 15, '旗山區'),
(271, 843, 15, '美濃區'),
(272, 845, 15, '內門區'),
(273, 846, 15, '杉林區'),
(274, 847, 15, '甲仙區'),
(275, 844, 15, '六龜區'),
(276, 851, 15, '茂林區'),
(277, 848, 15, '桃源區'),
(278, 849, 15, '那瑪夏區'),
(279, 900, 16, '屏東市'),
(280, 920, 16, '潮州鎮'),
(281, 928, 16, '東港鎮'),
(282, 946, 16, '恆春鎮'),
(283, 913, 16, '萬丹鄉'),
(284, 908, 16, '長治鄉'),
(285, 909, 16, '麟洛鄉'),
(286, 904, 16, '九如鄉'),
(287, 905, 16, '里港鄉'),
(288, 907, 16, '鹽埔鄉'),
(289, 906, 16, '高樹鄉'),
(290, 923, 16, '萬巒鄉'),
(291, 912, 16, '內埔鄉'),
(292, 911, 16, '竹田鄉'),
(293, 925, 16, '新埤鄉'),
(294, 940, 16, '枋寮鄉'),
(295, 932, 16, '新園鄉'),
(296, 924, 16, '崁頂鄉'),
(297, 927, 16, '林邊鄉'),
(298, 926, 16, '南州鄉'),
(299, 931, 16, '佳冬鄉'),
(300, 929, 16, '琉球鄉'),
(301, 944, 16, '車城鄉'),
(302, 947, 16, '滿州鄉'),
(303, 941, 16, '枋山鄉'),
(304, 902, 16, '霧台鄉'),
(305, 903, 16, '瑪家鄉'),
(306, 921, 16, '泰武鄉'),
(307, 922, 16, '來義鄉'),
(308, 942, 16, '春日鄉'),
(309, 943, 16, '獅子鄉'),
(310, 945, 16, '牡丹鄉'),
(311, 901, 16, '三地門鄉'),
(312, 260, 17, '宜蘭市'),
(313, 265, 17, '羅東鎮'),
(314, 270, 17, '蘇澳鎮'),
(315, 261, 17, '頭城鎮'),
(316, 262, 17, '礁溪鄉'),
(317, 263, 17, '壯圍鄉'),
(318, 264, 17, '員山鄉'),
(319, 269, 17, '冬山鄉'),
(320, 268, 17, '五結鄉'),
(321, 266, 17, '三星鄉'),
(322, 267, 17, '大同鄉'),
(323, 272, 17, '南澳鄉'),
(324, 970, 18, '花蓮市'),
(325, 975, 18, '鳳林鎮'),
(326, 981, 18, '玉里鎮'),
(327, 971, 18, '新城鄉'),
(328, 973, 18, '吉安鄉'),
(329, 974, 18, '壽豐鄉'),
(330, 972, 18, '秀林鄉'),
(331, 978, 18, '瑞穗鄉'),
(332, 976, 18, '光復鄉'),
(333, 977, 18, '豐濱鄉'),
(334, 979, 18, '萬榮鄉'),
(335, 983, 18, '富里鄉'),
(336, 982, 18, '卓溪鄉'),
(337, 950, 19, '台東市'),
(338, 961, 19, '成功鎮'),
(339, 956, 19, '關山鎮'),
(340, 962, 19, '長濱鄉'),
(341, 957, 19, '海端鄉'),
(342, 958, 19, '池上鄉'),
(343, 959, 19, '東河鄉'),
(344, 955, 19, '鹿野鄉'),
(345, 953, 19, '延平鄉'),
(346, 954, 19, '卑南鄉'),
(347, 964, 19, '金峰鄉'),
(348, 965, 19, '大武鄉'),
(349, 966, 19, '達仁鄉'),
(350, 951, 19, '綠島鄉'),
(351, 952, 19, '蘭嶼鄉'),
(352, 963, 19, '太麻里鄉'),
(353, 880, 20, '馬公市'),
(354, 885, 20, '湖西鄉'),
(355, 884, 20, '白沙鄉'),
(356, 881, 20, '西嶼鄉'),
(357, 882, 20, '望安鄉'),
(358, 883, 20, '七美鄉'),
(359, 893, 21, '金城鎮'),
(360, 891, 21, '金湖鎮'),
(361, 890, 21, '金沙鎮'),
(362, 892, 21, '金寧鄉'),
(363, 894, 21, '烈嶼鄉'),
(364, 896, 21, '烏坵鄉'),
(365, 209, 22, '南竿鄉'),
(366, 210, 22, '北竿鄉'),
(367, 211, 22, '莒光鄉'),
(368, 212, 22, '東引鄉');

-- --------------------------------------------------------

--
-- 資料表結構 `Gash`
--

CREATE TABLE `Gash` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `gash` mediumint(8) UNSIGNED DEFAULT NULL COMMENT 'G幣',
  `dollar` mediumint(8) UNSIGNED DEFAULT NULL COMMENT '台幣'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `Gash`
--

INSERT INTO `Gash` (`id`, `gash`, `dollar`) VALUES
(1, 300, 300),
(2, 500, 500),
(3, 1000, 1000),
(4, 3030, 3000),
(5, 5100, 5000),
(6, 10250, 10000),
(7, 20600, 20000),
(8, 31000, 30000),
(9, 52000, 50000);

-- --------------------------------------------------------

--
-- 資料表結構 `Gift`
--

CREATE TABLE `Gift` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL COMMENT '會員id',
  `category_id` tinyint(3) UNSIGNED NOT NULL COMMENT '禮類id',
  `amount` smallint(5) DEFAULT 200 COMMENT '剩餘G幣',
  `expire_at` bigint(20) NOT NULL COMMENT '過期時間',
  `update_at` bigint(20) NOT NULL COMMENT '更動時間'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `Gift`
--

INSERT INTO `Gift` (`id`, `user_id`, `category_id`, `amount`, `expire_at`, `update_at`) VALUES
(1, 1, 4, 200, 1697899999, 1697888888),
(2, 1, 5, 200, 1697888888, 1697666666);

-- --------------------------------------------------------

--
-- 資料表結構 `HeadPhoto`
--

CREATE TABLE `HeadPhoto` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `headphoto` varchar(10) DEFAULT NULL COMMENT '頭像'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `HeadPhoto`
--

INSERT INTO `HeadPhoto` (`id`, `headphoto`) VALUES
(1, 'g1000'),
(2, 'g5000'),
(3, 'egg10'),
(4, 'ichiban10');

-- --------------------------------------------------------

--
-- 資料表結構 `Logistics`
--

CREATE TABLE `Logistics` (
  `id` int(10) UNSIGNED NOT NULL,
  `time` bigint(20) NOT NULL COMMENT '建立時間',
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '會員id',
  `logistics_people_id` int(10) UNSIGNED NOT NULL COMMENT '收件人id',
  `address_id` int(10) UNSIGNED NOT NULL COMMENT '收件地id',
  `method_id` tinyint(3) UNSIGNED NOT NULL COMMENT '物流方式id',
  `status_id` tinyint(3) UNSIGNED DEFAULT 6 COMMENT '狀態id',
  `deliver_time` enum('早上(09:00 ~ 12:00)','下午(13:30 ~ 16:30)','任意時段皆可','') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `Logistics`
--

INSERT INTO `Logistics` (`id`, `time`, `user_id`, `logistics_people_id`, `address_id`, `method_id`, `status_id`, `deliver_time`) VALUES
(1, 1697735674, 1, 1, 2, 1, 7, '早上(09:00 ~ 12:00)'),
(2, 1697620375, 1, 2, 1, 2, 8, '早上(09:00 ~ 12:00)');

-- --------------------------------------------------------

--
-- 資料表結構 `LogisticsItem`
--

CREATE TABLE `LogisticsItem` (
  `logistics_id` int(10) UNSIGNED NOT NULL COMMENT '物流單id',
  `records_id` int(10) UNSIGNED NOT NULL COMMENT '扭抽單id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `LogisticsItem`
--

INSERT INTO `LogisticsItem` (`logistics_id`, `records_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 4),
(2, 5);

-- --------------------------------------------------------

--
-- 資料表結構 `LogisticsMethod`
--

CREATE TABLE `LogisticsMethod` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `method` varchar(2) NOT NULL COMMENT '物流方式'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `LogisticsMethod`
--

INSERT INTO `LogisticsMethod` (`id`, `method`) VALUES
(1, '超商'),
(2, '宅配'),
(3, '自取');

-- --------------------------------------------------------

--
-- 資料表結構 `LogisticsPeople`
--

CREATE TABLE `LogisticsPeople` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '會員id',
  `name` varchar(51) NOT NULL COMMENT '收件人',
  `phone` text NOT NULL COMMENT '手機',
  `email` varchar(255) NOT NULL COMMENT '郵箱',
  `status_id` tinyint(3) UNSIGNED DEFAULT 13 COMMENT '常用id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `LogisticsPeople`
--

INSERT INTO `LogisticsPeople` (`id`, `user_id`, `name`, `phone`, `email`, `status_id`) VALUES
(1, 1, '大大1', '910234567', 'big1@qq.com', 13),
(2, 1, '大大2', '910234456', 'big2@qq.com', 12);

-- --------------------------------------------------------

--
-- 資料表結構 `Machine`
--

CREATE TABLE `Machine` (
  `id` int(10) UNSIGNED NOT NULL,
  `character_id` int(10) UNSIGNED DEFAULT NULL COMMENT '角色id',
  `remain` smallint(5) UNSIGNED NOT NULL COMMENT '剩餘',
  `amount` smallint(5) UNSIGNED NOT NULL COMMENT '總數'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `Machine`
--

INSERT INTO `Machine` (`id`, `character_id`, `remain`, `amount`) VALUES
(1, 1, 0, 6),
(2, 2, 0, 6),
(3, 3, 0, 6),
(4, 4, 6, 6),
(5, 5, 6, 6),
(6, 6, 5, 6),
(7, 7, 5, 6),
(8, 8, 5, 6),
(9, 9, 6, 6),
(10, 10, 5, 5),
(11, 11, 4, 5),
(12, 12, 5, 5),
(13, 13, 5, 5);

-- --------------------------------------------------------

--
-- 資料表結構 `Material`
--

CREATE TABLE `Material` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `material` varchar(25) DEFAULT NULL COMMENT '材質'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `Material`
--

INSERT INTO `Material` (`id`, `material`) VALUES
(1, 'PU+樹脂'),
(2, 'PU+進口樹脂'),
(4, 'PVC'),
(3, '進口樹脂+PU樹脂+PU透明樹脂'),
(5, '進口樹脂+進口PU');

-- --------------------------------------------------------

--
-- 資料表結構 `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表結構 `Price`
--

CREATE TABLE `Price` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `price` smallint(6) DEFAULT NULL COMMENT '價格'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `Price`
--

INSERT INTO `Price` (`id`, `price`) VALUES
(21, -200),
(1, 100),
(2, 200),
(3, 300),
(4, 400),
(5, 500),
(6, 600),
(7, 700),
(8, 800),
(9, 900),
(10, 1000),
(11, 1100),
(12, 1200),
(13, 1300),
(14, 1400),
(15, 1500),
(16, 1600),
(17, 1700),
(18, 1800),
(19, 1900),
(20, 2000);

-- --------------------------------------------------------

--
-- 資料表結構 `Prize`
--

CREATE TABLE `Prize` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `prize` varchar(1) DEFAULT NULL COMMENT '賞別'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `Prize`
--

INSERT INTO `Prize` (`id`, `prize`) VALUES
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D'),
(5, 'E'),
(6, 'F'),
(7, 'G'),
(8, 'H'),
(9, 'I');

-- --------------------------------------------------------

--
-- 資料表結構 `Records`
--

CREATE TABLE `Records` (
  `id` int(10) UNSIGNED NOT NULL,
  `time` bigint(20) NOT NULL COMMENT '抽扭時間',
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '會員id',
  `character_id` int(10) UNSIGNED NOT NULL COMMENT '角色id',
  `label` smallint(5) UNSIGNED DEFAULT NULL COMMENT '籤號',
  `status_id` tinyint(3) UNSIGNED DEFAULT 4 COMMENT '狀態id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `Records`
--

INSERT INTO `Records` (`id`, `time`, `user_id`, `character_id`, `label`, `status_id`) VALUES
(1, 1698234865, 1, 1, NULL, 6),
(2, 1698245865, 1, 1, NULL, 7),
(3, 1698256865, 1, 6, NULL, 4),
(4, 1698267865, 2, 7, 5, 4),
(5, 1698267865, 1, 8, 3, 4),
(6, 1698231865, 1, 11, NULL, 5),
(7, 1698234865, 1, 14, NULL, 2),
(8, 1698234865, 1, 15, NULL, 2);

-- --------------------------------------------------------

--
-- 資料表結構 `Series`
--

CREATE TABLE `Series` (
  `id` int(10) UNSIGNED NOT NULL,
  `category_id` tinyint(3) UNSIGNED NOT NULL COMMENT '商品類id',
  `name_title_id` int(10) UNSIGNED DEFAULT NULL COMMENT '系列主題名id',
  `name` varchar(20) NOT NULL COMMENT '系列名',
  `theme_id` tinyint(3) UNSIGNED DEFAULT NULL COMMENT '主題id',
  `price_id` tinyint(3) UNSIGNED NOT NULL COMMENT '價格id',
  `stock` tinyint(3) UNSIGNED NOT NULL COMMENT '庫存',
  `release_time` bigint(20) DEFAULT NULL COMMENT '上架時間',
  `end_time` bigint(20) DEFAULT NULL COMMENT '抽完、補貨時間'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `Series`
--

INSERT INTO `Series` (`id`, `category_id`, `name_title_id`, `name`, `theme_id`, `price_id`, `stock`, `release_time`, `end_time`) VALUES
(1, 1, 1, '海賊王系列第一蛋商品', 1, 4, 1, 1698154564, 1698154564),
(2, 1, 2, '企鵝家族系第一蛋商品', 2, 3, 3, 1698157304, 1698157304),
(3, 2, 3, '海賊王系列第二彈商品', 1, 5, 2, 1698153454, 1698153454),
(4, 1, 4, '海賊王系列第三蛋商品', 1, 6, 4, 1698012344, 1698092344),
(5, 4, NULL, '生日禮', NULL, 21, 1, NULL, NULL),
(6, 5, NULL, '推薦禮', NULL, 21, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- 資料表結構 `SeriesImg`
--

CREATE TABLE `SeriesImg` (
  `id` int(10) UNSIGNED NOT NULL,
  `series_id` int(10) UNSIGNED NOT NULL COMMENT '系列id',
  `img` varchar(100) DEFAULT NULL COMMENT '系列圖'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `SeriesImg`
--

INSERT INTO `SeriesImg` (`id`, `series_id`, `img`) VALUES
(1, 1, 'https://dummyimage.com/500x500/e8b603/000000&text=海賊王系列第一蛋系列1'),
(2, 1, 'https://dummyimage.com/500x500/e8b603/000000&text=海賊王系列第一蛋系列2'),
(3, 2, 'https://dummyimage.com/500x500/e8b603/000000&text=企鵝家族系第一蛋系列1'),
(4, 2, 'https://dummyimage.com/500x500/e8b603/000000&text=企鵝家族系第一蛋系列2'),
(5, 2, 'https://dummyimage.com/500x500/e8b603/000000&text=企鵝家族系第一蛋系列3'),
(6, 3, 'https://dummyimage.com/500x500/e8b603/000000&text=海賊王系列第二賞系列1'),
(7, 3, 'https://dummyimage.com/500x500/e8b603/000000&text=海賊王系列第二賞系列2'),
(8, 3, 'https://dummyimage.com/500x500/e8b603/000000&text=海賊王系列第二賞系列3'),
(9, 4, 'https://dummyimage.com/500x500/e8b603/000000&text=海賊王系列第三蛋系列1');

-- --------------------------------------------------------

--
-- 資料表結構 `SeriesTitle`
--

CREATE TABLE `SeriesTitle` (
  `id` int(10) UNSIGNED NOT NULL,
  `name_title` varchar(20) NOT NULL COMMENT '系列主題名'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `SeriesTitle`
--

INSERT INTO `SeriesTitle` (`id`, `name_title`) VALUES
(1, '海賊王系列第一蛋'),
(2, '企鵝家族系列第一蛋'),
(3, '海賊王系列第二彈'),
(4, '海賊王系列第三彈');

-- --------------------------------------------------------

--
-- 資料表結構 `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('Q1G3VYQV8fjwuNntt6VUfz698Ydvrb7s6viwcPUi', NULL, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUVBDZ0pRdGZiSndZWXNIYXg3OVRMdlR5cUs4emJYZTYyMzB5OThCMCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTA6Imh0dHA6Ly9sb2NhbGhvc3QvZ2FjaG9yYVByb2plY3QvcHVibGljL2FwaS9pY2hpYmFuIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1734016721),
('uTLvG7P8YPKjEvHKH1zjLjqhKzKSB5oUmFezx8RB', NULL, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaFpPakZKYlpPZE9PYXI1VGd3cG1PMzYzVE13SzlTODN6bEpEMkd0RiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDc6Imh0dHA6Ly9sb2NhbGhvc3QvZ2FjaG9yYVByb2plY3QvcHVibGljL2FwaS91c2VyIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1734058206);

-- --------------------------------------------------------

--
-- 資料表結構 `Status`
--

CREATE TABLE `Status` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `status` varchar(5) DEFAULT NULL COMMENT '狀態'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `Status`
--

INSERT INTO `Status` (`id`, `status`) VALUES
(13, '不常用'),
(6, '出貨準備中'),
(10, '到貨不通知'),
(11, '到貨需通知'),
(7, '商品已出貨'),
(8, '商品已送達'),
(4, '存於儲藏庫'),
(5, '存於購物車'),
(9, '完成退換貨'),
(3, '已兑換紅利'),
(2, '已到帳'),
(12, '常用'),
(1, '未到帳');

-- --------------------------------------------------------

--
-- 資料表結構 `Theme`
--

CREATE TABLE `Theme` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `theme` varchar(7) DEFAULT NULL COMMENT '系列主題'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `Theme`
--

INSERT INTO `Theme` (`id`, `theme`) VALUES
(2, '企鵝家族'),
(1, '海賊王'),
(3, '鬼滅之刃');

-- --------------------------------------------------------

--
-- 資料表結構 `ToG`
--

CREATE TABLE `ToG` (
  `id` int(10) UNSIGNED NOT NULL,
  `record_id` int(10) UNSIGNED NOT NULL COMMENT '品項id',
  `gash` tinyint(3) UNSIGNED NOT NULL COMMENT '回饋G幣',
  `time` bigint(20) DEFAULT NULL COMMENT '兌換時間'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- 資料表結構 `Users`
--

CREATE TABLE `Users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(51) DEFAULT NULL COMMENT '名',
  `email` varchar(255) NOT NULL COMMENT '郵箱',
  `email_verified_at` timestamp NULL DEFAULT NULL COMMENT '郵箱驗證時間',
  `password` varchar(255) NOT NULL COMMENT '密碼',
  `remember_token` varchar(100) DEFAULT NULL COMMENT '記住我',
  `phone` text DEFAULT NULL COMMENT '手機',
  `birth` date DEFAULT NULL COMMENT '生日',
  `county_id` smallint(5) UNSIGNED DEFAULT NULL COMMENT '城',
  `road` varchar(25) DEFAULT NULL COMMENT '路',
  `credit` varchar(16) DEFAULT NULL COMMENT '信用卡',
  `headphoto` tinyint(3) UNSIGNED DEFAULT NULL COMMENT '頭像id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '新增時間',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新時間'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `Users`
--

INSERT INTO `Users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `phone`, `birth`, `county_id`, `road`, `credit`, `headphoto`, `created_at`, `updated_at`) VALUES
(1, '嘎丘拉', 'gachora@qq.com', NULL, '1111', NULL, '912345678', '2000-01-01', 1, '鄉間小路1段1號', '1234567887654321', NULL, '2023-10-11 20:02:44', '2023-10-24 01:22:44'),
(2, '嘎丘羅', 'gachoro@qq.com', NULL, '2222', NULL, '912345678', '2000-02-02', 2, '鄉間小路2段2號', '1234567887654322', NULL, '2023-10-19 22:29:24', '2023-10-24 01:06:04');

-- --------------------------------------------------------

--
-- 替換檢視表以便查看 `vw_allegg`
-- (請參考以下實際畫面)
--
CREATE TABLE `vw_allegg` (
`series_id` int(10) unsigned
,`theme` varchar(7)
,`series_title` varchar(20)
,`name` varchar(20)
,`price` smallint(6)
,`amount` bigint(21)
);

-- --------------------------------------------------------

--
-- 替換檢視表以便查看 `vw_alleggwithdetail`
-- (請參考以下實際畫面)
--
CREATE TABLE `vw_alleggwithdetail` (
`series_id` int(10) unsigned
,`theme` varchar(7)
,`series_title` varchar(20)
,`name` varchar(20)
,`price` smallint(6)
,`amount` bigint(21)
,`rank` decimal(42,0)
,`rare` decimal(25,0)
,`release_time` bigint(20)
);

-- --------------------------------------------------------

--
-- 替換檢視表以便查看 `vw_allmygiftrecords`
-- (請參考以下實際畫面)
--
CREATE TABLE `vw_allmygiftrecords` (
`user_id` int(10) unsigned
,`record_id` int(10) unsigned
,`category` varchar(3)
,`series_title` varchar(20)
,`series_name` varchar(20)
,`character_name` varchar(20)
,`character_img` varchar(100)
,`price` int(1)
,`gift` tinyint(3) unsigned
,`prize` varchar(1)
,`status` varchar(5)
,`time` bigint(20)
);

-- --------------------------------------------------------

--
-- 替換檢視表以便查看 `vw_allmyrecords`
-- (請參考以下實際畫面)
--
CREATE TABLE `vw_allmyrecords` (
`user_id` int(10) unsigned
,`record_id` int(10) unsigned
,`category` varchar(3)
,`series_title` varchar(20)
,`series_name` varchar(20)
,`character_id` int(10) unsigned
,`character_name` varchar(20)
,`character_img` varchar(100)
,`price` smallint(6)
,`gift` int(7)
,`prize` varchar(1)
,`status_id` tinyint(3) unsigned
,`status` varchar(5)
,`time` bigint(20)
);

-- --------------------------------------------------------

--
-- 替換檢視表以便查看 `vw_blingegg`
-- (請參考以下實際畫面)
--
CREATE TABLE `vw_blingegg` (
`series_id` int(10) unsigned
,`theme` varchar(7)
,`series_title` varchar(20)
,`name` varchar(20)
,`price` smallint(6)
,`amount` bigint(21)
);

-- --------------------------------------------------------

--
-- 替換檢視表以便查看 `vw_detail`
-- (請參考以下實際畫面)
--
CREATE TABLE `vw_detail` (
`series_id` int(10) unsigned
,`prize` varchar(1)
,`character_name` varchar(20)
,`character_img` varchar(100)
,`size` varchar(11)
,`material` varchar(25)
,`remain` smallint(5) unsigned
,`total` smallint(5) unsigned
);

-- --------------------------------------------------------

--
-- 替換檢視表以便查看 `vw_eggcard`
-- (請參考以下實際畫面)
--
CREATE TABLE `vw_eggcard` (
`series_id` int(10) unsigned
,`theme` varchar(7)
,`series_title` varchar(20)
,`name` varchar(20)
,`price` smallint(6)
,`amount` bigint(21)
);

-- --------------------------------------------------------

--
-- 替換檢視表以便查看 `vw_eggcardimg`
-- (請參考以下實際畫面)
--
CREATE TABLE `vw_eggcardimg` (
`series_id` int(10) unsigned
,`series_img` varchar(100)
);

-- --------------------------------------------------------

--
-- 替換檢視表以便查看 `vw_hotegg`
-- (請參考以下實際畫面)
--
CREATE TABLE `vw_hotegg` (
`series_id` int(10) unsigned
,`theme` varchar(7)
,`series_title` varchar(20)
,`name` varchar(20)
,`price` smallint(6)
,`amount` bigint(21)
,`rank` bigint(21)
);

-- --------------------------------------------------------

--
-- 替換檢視表以便查看 `vw_ichiban`
-- (請參考以下實際畫面)
--
CREATE TABLE `vw_ichiban` (
`series_id` int(10) unsigned
,`theme_id` tinyint(3) unsigned
,`theme` varchar(7)
,`series_title` varchar(20)
,`name` varchar(20)
,`price` smallint(6)
,`release_time` bigint(20)
,`stock` tinyint(3) unsigned
);

-- --------------------------------------------------------

--
-- 替換檢視表以便查看 `vw_ichibanimg`
-- (請參考以下實際畫面)
--
CREATE TABLE `vw_ichibanimg` (
`series_id` int(10) unsigned
,`theme_id` tinyint(3) unsigned
,`series_img` varchar(100)
);

-- --------------------------------------------------------

--
-- 替換檢視表以便查看 `vw_ichibanremaintotal`
-- (請參考以下實際畫面)
--
CREATE TABLE `vw_ichibanremaintotal` (
`series_id` int(10) unsigned
,`theme_id` tinyint(3) unsigned
,`all_remain` decimal(27,0)
,`all_amount` decimal(27,0)
);

-- --------------------------------------------------------

--
-- 替換檢視表以便查看 `vw_newegg`
-- (請參考以下實際畫面)
--
CREATE TABLE `vw_newegg` (
`series_id` int(10) unsigned
,`theme` varchar(7)
,`series_title` varchar(20)
,`name` varchar(20)
,`price` smallint(6)
,`amount` bigint(21)
);

-- --------------------------------------------------------

--
-- 替換檢視表以便查看 `vw_rareegg`
-- (請參考以下實際畫面)
--
CREATE TABLE `vw_rareegg` (
`series_id` int(10) unsigned
,`theme` varchar(7)
,`series_title` varchar(20)
,`name` varchar(20)
,`price` smallint(6)
,`amount` bigint(21)
);

-- --------------------------------------------------------

--
-- 替換檢視表以便查看 `vw_remaintotal`
-- (請參考以下實際畫面)
--
CREATE TABLE `vw_remaintotal` (
`series_id` int(10) unsigned
,`prize` varchar(1)
,`name` varchar(20)
,`remain` smallint(5) unsigned
,`amount` smallint(5) unsigned
);

-- --------------------------------------------------------

--
-- 替換檢視表以便查看 `vw_series_img`
-- (請參考以下實際畫面)
--
CREATE TABLE `vw_series_img` (
`series_id` int(10) unsigned
,`series_img` varchar(100)
);

-- --------------------------------------------------------

--
-- 替換檢視表以便查看 `vw_theme`
-- (請參考以下實際畫面)
--
CREATE TABLE `vw_theme` (
`series_id` int(10) unsigned
,`theme_id` tinyint(3) unsigned
,`category_id` tinyint(3) unsigned
);

-- --------------------------------------------------------

--
-- 資料表結構 `Waitinglist`
--

CREATE TABLE `Waitinglist` (
  `series_id` int(10) UNSIGNED NOT NULL COMMENT '系列id',
  `user_id` int(10) UNSIGNED DEFAULT NULL COMMENT '會員id',
  `number` smallint(5) UNSIGNED NOT NULL DEFAULT 1 COMMENT '等待編號',
  `wait` bigint(20) DEFAULT NULL COMMENT '開抽時間'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `Waitinglist`
--

INSERT INTO `Waitinglist` (`series_id`, `user_id`, `number`, `wait`) VALUES
(3, 1, 1, 1697888888),
(3, 2, 2, NULL);

-- --------------------------------------------------------

--
-- 檢視表結構 `vw_allegg`
--
DROP TABLE IF EXISTS `vw_allegg`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `gachora`.`vw_allegg`  AS SELECT `s`.`id` AS `series_id`, `t`.`theme` AS `theme`, `st`.`name_title` AS `series_title`, `s`.`name` AS `name`, `p`.`price` AS `price`, count(`s`.`id`) AS `amount` FROM ((((`gachora`.`series` `s` left join `gachora`.`theme` `t` on(`s`.`theme_id` = `t`.`id`)) left join `gachora`.`price` `p` on(`s`.`price_id` = `p`.`id`)) left join `gachora`.`characters` `c` on(`s`.`id` = `c`.`series_id`)) left join `gachora`.`seriestitle` `st` on(`s`.`name_title_id` = `st`.`id`)) WHERE `s`.`category_id` = 1 GROUP BY `s`.`id` ORDER BY `s`.`stock` DESC ;

-- --------------------------------------------------------

--
-- 檢視表結構 `vw_alleggwithdetail`
--
DROP TABLE IF EXISTS `vw_alleggwithdetail`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `gachora`.`vw_alleggwithdetail`  AS SELECT `o`.`id` AS `series_id`, `gachora`.`theme`.`theme` AS `theme`, `gachora`.`seriestitle`.`name_title` AS `series_title`, `o`.`name` AS `name`, `gachora`.`price`.`price` AS `price`, count(`o`.`id`) AS `amount`, `o`.`rank` AS `rank`, `o`.`rare` AS `rare`, `o`.`release_time` AS `release_time` FROM (((((select `s`.`series_id` AS `id`,`gachora`.`series`.`name` AS `name`,`gachora`.`series`.`theme_id` AS `theme_id`,`gachora`.`series`.`name_title_id` AS `name_title_id`,`gachora`.`series`.`price_id` AS `price_id`,sum(`s`.`rank`) AS `rank`,sum(`s`.`rare`) AS `rare`,`gachora`.`series`.`release_time` AS `release_time` from ((select `c`.`series_id` AS `series_id`,count(`c`.`series_id`) AS `rank`,0 AS `rare` from (`gachora`.`records` `r` left join `gachora`.`characters` `c` on(`r`.`character_id` = `c`.`id`)) group by `c`.`series_id` union all select `gachora`.`series`.`id` AS `series_id`,0 AS `rank`,`gachora`.`series`.`stock` AS `rare` from `gachora`.`series`) `s` left join `gachora`.`series` on(`s`.`series_id` = `gachora`.`series`.`id`)) where `gachora`.`series`.`category_id` = 1 group by `s`.`series_id`) `o` left join `gachora`.`theme` on(`o`.`theme_id` = `gachora`.`theme`.`id`)) left join `gachora`.`seriestitle` on(`o`.`name_title_id` = `gachora`.`seriestitle`.`id`)) left join `gachora`.`price` on(`o`.`price_id` = `gachora`.`price`.`id`)) left join `gachora`.`characters` on(`o`.`id` = `gachora`.`characters`.`series_id`)) GROUP BY `o`.`id` ;

-- --------------------------------------------------------

--
-- 檢視表結構 `vw_allmygiftrecords`
--
DROP TABLE IF EXISTS `vw_allmygiftrecords`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `gachora`.`vw_allmygiftrecords`  AS SELECT `r`.`user_id` AS `user_id`, `r`.`record_id` AS `record_id`, `r`.`category` AS `category`, `r`.`series_title` AS `series_title`, `r`.`series_name` AS `series_name`, `r`.`character_name` AS `character_name`, `r`.`character_img` AS `character_img`, 0 AS `price`, `t`.`gash` AS `gift`, `r`.`prize` AS `prize`, `r`.`status` AS `status`, `t`.`time` AS `time` FROM ((select `gachora`.`tog`.`record_id` AS `record_id`,`gachora`.`tog`.`gash` AS `gash`,`gachora`.`tog`.`time` AS `time` from `gachora`.`tog`) `t` left join `gachora`.`vw_allmyrecords` `r` on(`t`.`record_id` = `r`.`record_id`)) ;

-- --------------------------------------------------------

--
-- 檢視表結構 `vw_allmyrecords`
--
DROP TABLE IF EXISTS `vw_allmyrecords`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `gachora`.`vw_allmyrecords`  AS SELECT `r`.`user_id` AS `user_id`, `r`.`id` AS `record_id`, `ca`.`category` AS `category`, `st`.`name_title` AS `series_title`, `s`.`name` AS `series_name`, `r`.`character_id` AS `character_id`, `c`.`name` AS `character_name`, `c`.`img` AS `character_img`, `p`.`price` AS `price`, floor(`p`.`price` / 10) AS `gift`, `pz`.`prize` AS `prize`, `sta`.`id` AS `status_id`, `sta`.`status` AS `status`, `r`.`time` AS `time` FROM ((((((((select `gachora`.`records`.`id` AS `id`,`gachora`.`records`.`user_id` AS `user_id`,`gachora`.`records`.`label` AS `label`,`gachora`.`records`.`character_id` AS `character_id`,`gachora`.`records`.`status_id` AS `status_id`,`gachora`.`records`.`time` AS `time` from `gachora`.`records`) `r` left join `gachora`.`characters` `c` on(`r`.`character_id` = `c`.`id`)) left join `gachora`.`series` `s` on(`c`.`series_id` = `s`.`id`)) left join `gachora`.`price` `p` on(`s`.`price_id` = `p`.`id`)) left join `gachora`.`prize` `pz` on(`c`.`prize_id` = `pz`.`id`)) left join `gachora`.`seriestitle` `st` on(`s`.`name_title_id` = `st`.`id`)) left join `gachora`.`status` `sta` on(`r`.`status_id` = `sta`.`id`)) left join `gachora`.`category` `ca` on(`s`.`category_id` = `ca`.`id`)) ORDER BY `r`.`time` DESC ;

-- --------------------------------------------------------

--
-- 檢視表結構 `vw_blingegg`
--
DROP TABLE IF EXISTS `vw_blingegg`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `gachora`.`vw_blingegg`  AS SELECT `s`.`id` AS `series_id`, `t`.`theme` AS `theme`, `st`.`name_title` AS `series_title`, `s`.`name` AS `name`, `p`.`price` AS `price`, count(`s`.`id`) AS `amount` FROM ((((`gachora`.`series` `s` left join `gachora`.`theme` `t` on(`s`.`theme_id` = `t`.`id`)) left join `gachora`.`price` `p` on(`s`.`price_id` = `p`.`id`)) left join `gachora`.`characters` `c` on(`s`.`id` = `c`.`series_id`)) left join `gachora`.`seriestitle` `st` on(`s`.`name_title_id` = `st`.`id`)) WHERE `s`.`category_id` = 1 GROUP BY `s`.`id` ORDER BY `s`.`release_time` ASC LIMIT 0, 10 ;

-- --------------------------------------------------------

--
-- 檢視表結構 `vw_detail`
--
DROP TABLE IF EXISTS `vw_detail`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `gachora`.`vw_detail`  AS SELECT `s`.`id` AS `series_id`, `pz`.`prize` AS `prize`, `c`.`name` AS `character_name`, `c`.`img` AS `character_img`, concat(`c`.`size1`,'x',`c`.`size2`,'x',`c`.`size3`) AS `size`, `m`.`material` AS `material`, `ms`.`remain` AS `remain`, `ms`.`amount` AS `total` FROM ((((`gachora`.`series` `s` left join `gachora`.`characters` `c` on(`s`.`id` = `c`.`series_id`)) left join `gachora`.`material` `m` on(`c`.`material_id` = `m`.`id`)) left join `gachora`.`prize` `pz` on(`c`.`prize_id` = `pz`.`id`)) left join `gachora`.`machine` `ms` on(`c`.`id` = `ms`.`character_id`)) ;

-- --------------------------------------------------------

--
-- 檢視表結構 `vw_eggcard`
--
DROP TABLE IF EXISTS `vw_eggcard`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `gachora`.`vw_eggcard`  AS SELECT `s`.`id` AS `series_id`, `t`.`theme` AS `theme`, `st`.`name_title` AS `series_title`, `s`.`name` AS `name`, `p`.`price` AS `price`, count(`s`.`id`) AS `amount` FROM ((((`gachora`.`series` `s` left join `gachora`.`theme` `t` on(`s`.`theme_id` = `t`.`id`)) left join `gachora`.`price` `p` on(`s`.`price_id` = `p`.`id`)) left join `gachora`.`characters` `c` on(`s`.`id` = `c`.`series_id`)) left join `gachora`.`seriestitle` `st` on(`s`.`name_title_id` = `st`.`id`)) WHERE `s`.`category_id` = 1 GROUP BY `s`.`id` ;

-- --------------------------------------------------------

--
-- 檢視表結構 `vw_eggcardimg`
--
DROP TABLE IF EXISTS `vw_eggcardimg`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `gachora`.`vw_eggcardimg`  AS SELECT `s`.`id` AS `series_id`, `si`.`img` AS `series_img` FROM (`gachora`.`series` `s` left join `gachora`.`seriesimg` `si` on(`s`.`id` = `si`.`series_id`)) WHERE `s`.`category_id` = 1 ORDER BY `s`.`id` ASC ;

-- --------------------------------------------------------

--
-- 檢視表結構 `vw_hotegg`
--
DROP TABLE IF EXISTS `vw_hotegg`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `gachora`.`vw_hotegg`  AS SELECT `o`.`id` AS `series_id`, `gachora`.`theme`.`theme` AS `theme`, `gachora`.`seriestitle`.`name_title` AS `series_title`, `o`.`name` AS `name`, `gachora`.`price`.`price` AS `price`, count(`o`.`id`) AS `amount`, `o`.`rank` AS `rank` FROM (((((select `s`.`series_id` AS `id`,`gachora`.`series`.`name` AS `name`,`gachora`.`series`.`theme_id` AS `theme_id`,`gachora`.`series`.`name_title_id` AS `name_title_id`,`gachora`.`series`.`price_id` AS `price_id`,`s`.`rank` AS `rank` from ((select `c`.`series_id` AS `series_id`,count(`c`.`series_id`) AS `rank` from (`gachora`.`records` `r` left join `gachora`.`characters` `c` on(`r`.`character_id` = `c`.`id`)) group by `c`.`series_id` order by count(`c`.`series_id`) desc) `s` left join `gachora`.`series` on(`s`.`series_id` = `gachora`.`series`.`id`)) where `gachora`.`series`.`category_id` = 1) `o` left join `gachora`.`theme` on(`o`.`theme_id` = `gachora`.`theme`.`id`)) left join `gachora`.`seriestitle` on(`o`.`name_title_id` = `gachora`.`seriestitle`.`id`)) left join `gachora`.`price` on(`o`.`price_id` = `gachora`.`price`.`id`)) left join `gachora`.`characters` on(`o`.`id` = `gachora`.`characters`.`series_id`)) GROUP BY `o`.`id` ;

-- --------------------------------------------------------

--
-- 檢視表結構 `vw_ichiban`
--
DROP TABLE IF EXISTS `vw_ichiban`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `gachora`.`vw_ichiban`  AS SELECT `s`.`id` AS `series_id`, `s`.`theme_id` AS `theme_id`, `t`.`theme` AS `theme`, `st`.`name_title` AS `series_title`, `s`.`name` AS `name`, `p`.`price` AS `price`, `s`.`release_time` AS `release_time`, `s`.`stock` AS `stock` FROM ((((`gachora`.`series` `s` left join `gachora`.`theme` `t` on(`s`.`theme_id` = `t`.`id`)) left join `gachora`.`price` `p` on(`s`.`price_id` = `p`.`id`)) left join `gachora`.`characters` `c` on(`s`.`id` = `c`.`series_id`)) left join `gachora`.`seriestitle` `st` on(`s`.`name_title_id` = `st`.`id`)) WHERE `s`.`category_id` = 2 GROUP BY `s`.`id` ;

-- --------------------------------------------------------

--
-- 檢視表結構 `vw_ichibanimg`
--
DROP TABLE IF EXISTS `vw_ichibanimg`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `gachora`.`vw_ichibanimg`  AS SELECT `s`.`id` AS `series_id`, `s`.`theme_id` AS `theme_id`, `si`.`img` AS `series_img` FROM (`gachora`.`series` `s` left join `gachora`.`seriesimg` `si` on(`s`.`id` = `si`.`series_id`)) WHERE `s`.`category_id` = 2 ORDER BY `s`.`id` ASC ;

-- --------------------------------------------------------

--
-- 檢視表結構 `vw_ichibanremaintotal`
--
DROP TABLE IF EXISTS `vw_ichibanremaintotal`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `gachora`.`vw_ichibanremaintotal`  AS SELECT `s`.`id` AS `series_id`, `s`.`theme_id` AS `theme_id`, sum(`m`.`remain`) AS `all_remain`, sum(`m`.`amount`) AS `all_amount` FROM ((`gachora`.`series` `s` left join `gachora`.`characters` `c` on(`s`.`id` = `c`.`series_id`)) left join `gachora`.`machine` `m` on(`c`.`id` = `m`.`character_id`)) WHERE `s`.`category_id` = 2 GROUP BY `s`.`id` ;

-- --------------------------------------------------------

--
-- 檢視表結構 `vw_newegg`
--
DROP TABLE IF EXISTS `vw_newegg`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `gachora`.`vw_newegg`  AS SELECT `s`.`id` AS `series_id`, `t`.`theme` AS `theme`, `st`.`name_title` AS `series_title`, `s`.`name` AS `name`, `p`.`price` AS `price`, count(`s`.`id`) AS `amount` FROM ((((`gachora`.`series` `s` left join `gachora`.`theme` `t` on(`s`.`theme_id` = `t`.`id`)) left join `gachora`.`price` `p` on(`s`.`price_id` = `p`.`id`)) left join `gachora`.`characters` `c` on(`s`.`id` = `c`.`series_id`)) left join `gachora`.`seriestitle` `st` on(`s`.`name_title_id` = `st`.`id`)) WHERE `s`.`category_id` = 1 GROUP BY `s`.`id` ORDER BY `s`.`release_time` DESC ;

-- --------------------------------------------------------

--
-- 檢視表結構 `vw_rareegg`
--
DROP TABLE IF EXISTS `vw_rareegg`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `gachora`.`vw_rareegg`  AS SELECT `s`.`id` AS `series_id`, `t`.`theme` AS `theme`, `st`.`name_title` AS `series_title`, `s`.`name` AS `name`, `p`.`price` AS `price`, count(`s`.`id`) AS `amount` FROM ((((`gachora`.`series` `s` left join `gachora`.`theme` `t` on(`s`.`theme_id` = `t`.`id`)) left join `gachora`.`price` `p` on(`s`.`price_id` = `p`.`id`)) left join `gachora`.`characters` `c` on(`s`.`id` = `c`.`series_id`)) left join `gachora`.`seriestitle` `st` on(`s`.`name_title_id` = `st`.`id`)) WHERE `s`.`category_id` = 1 GROUP BY `s`.`id` ORDER BY `s`.`stock` ASC ;

-- --------------------------------------------------------

--
-- 檢視表結構 `vw_remaintotal`
--
DROP TABLE IF EXISTS `vw_remaintotal`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `gachora`.`vw_remaintotal`  AS SELECT `s`.`id` AS `series_id`, `pz`.`prize` AS `prize`, `c`.`name` AS `name`, `m`.`remain` AS `remain`, `m`.`amount` AS `amount` FROM (((`gachora`.`series` `s` left join `gachora`.`characters` `c` on(`s`.`id` = `c`.`series_id`)) left join `gachora`.`machine` `m` on(`c`.`id` = `m`.`character_id`)) left join `gachora`.`prize` `pz` on(`c`.`prize_id` = `pz`.`id`)) ;

-- --------------------------------------------------------

--
-- 檢視表結構 `vw_series_img`
--
DROP TABLE IF EXISTS `vw_series_img`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `gachora`.`vw_series_img`  AS SELECT `s`.`series_id` AS `series_id`, `s`.`img` AS `series_img` FROM `gachora`.`seriesimg` AS `s` ;

-- --------------------------------------------------------

--
-- 檢視表結構 `vw_theme`
--
DROP TABLE IF EXISTS `vw_theme`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `gachora`.`vw_theme`  AS SELECT `c`.`series_id` AS `series_id`, `s`.`theme_id` AS `theme_id`, `s`.`category_id` AS `category_id` FROM ((`gachora`.`machine` `m` left join `gachora`.`characters` `c` on(`c`.`id` = `m`.`character_id`)) left join `gachora`.`series` `s` on(`s`.`id` = `c`.`series_id`)) WHERE `m`.`remain` > 0 GROUP BY `c`.`series_id` ;

--
-- 已傾印資料表的索引
--

--
-- 資料表索引 `Address`
--
ALTER TABLE `Address`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `county_id` (`county_id`),
  ADD KEY `status_id` (`status_id`);

--
-- 資料表索引 `Bill`
--
ALTER TABLE `Bill`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `gash_id` (`gash_id`);

--
-- 資料表索引 `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- 資料表索引 `Category`
--
ALTER TABLE `Category`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `category` (`category`);

--
-- 資料表索引 `Characters`
--
ALTER TABLE `Characters`
  ADD PRIMARY KEY (`id`),
  ADD KEY `series_id` (`series_id`),
  ADD KEY `prize_id` (`prize_id`),
  ADD KEY `material_id` (`material_id`);

--
-- 資料表索引 `City`
--
ALTER TABLE `City`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `Collection`
--
ALTER TABLE `Collection`
  ADD PRIMARY KEY (`user_id`,`series_id`),
  ADD KEY `series_id` (`series_id`);

--
-- 資料表索引 `County`
--
ALTER TABLE `County`
  ADD PRIMARY KEY (`id`),
  ADD KEY `city_id` (`city_id`);

--
-- 資料表索引 `Gash`
--
ALTER TABLE `Gash`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `gash` (`gash`),
  ADD UNIQUE KEY `dollar` (`dollar`);

--
-- 資料表索引 `Gift`
--
ALTER TABLE `Gift`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `category_id` (`category_id`);

--
-- 資料表索引 `HeadPhoto`
--
ALTER TABLE `HeadPhoto`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `Logistics`
--
ALTER TABLE `Logistics`
  ADD PRIMARY KEY (`id`,`time`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `method_id` (`method_id`),
  ADD KEY `status_id` (`status_id`),
  ADD KEY `logistics_people_id` (`logistics_people_id`),
  ADD KEY `address_id` (`address_id`);

--
-- 資料表索引 `LogisticsItem`
--
ALTER TABLE `LogisticsItem`
  ADD PRIMARY KEY (`logistics_id`,`records_id`),
  ADD KEY `records_id` (`records_id`);

--
-- 資料表索引 `LogisticsMethod`
--
ALTER TABLE `LogisticsMethod`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `LogisticsPeople`
--
ALTER TABLE `LogisticsPeople`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `status_id` (`status_id`);

--
-- 資料表索引 `Machine`
--
ALTER TABLE `Machine`
  ADD PRIMARY KEY (`id`),
  ADD KEY `character_id` (`character_id`);

--
-- 資料表索引 `Material`
--
ALTER TABLE `Material`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `material` (`material`);

--
-- 資料表索引 `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- 資料表索引 `Price`
--
ALTER TABLE `Price`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `price` (`price`);

--
-- 資料表索引 `Prize`
--
ALTER TABLE `Prize`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `prize` (`prize`);

--
-- 資料表索引 `Records`
--
ALTER TABLE `Records`
  ADD PRIMARY KEY (`id`,`time`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `character_id` (`character_id`),
  ADD KEY `status_id` (`status_id`);

--
-- 資料表索引 `Series`
--
ALTER TABLE `Series`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `theme_id` (`theme_id`),
  ADD KEY `price_id` (`price_id`),
  ADD KEY `name_title_id` (`name_title_id`);

--
-- 資料表索引 `SeriesImg`
--
ALTER TABLE `SeriesImg`
  ADD PRIMARY KEY (`id`),
  ADD KEY `series_id` (`series_id`);

--
-- 資料表索引 `SeriesTitle`
--
ALTER TABLE `SeriesTitle`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- 資料表索引 `Status`
--
ALTER TABLE `Status`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `status` (`status`);

--
-- 資料表索引 `Theme`
--
ALTER TABLE `Theme`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `theme` (`theme`);

--
-- 資料表索引 `ToG`
--
ALTER TABLE `ToG`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tog_ibfk_1` (`record_id`);

--
-- 資料表索引 `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `county_id` (`county_id`),
  ADD KEY `headphoto` (`headphoto`);

--
-- 資料表索引 `Waitinglist`
--
ALTER TABLE `Waitinglist`
  ADD KEY `series_id` (`series_id`),
  ADD KEY `user_id` (`user_id`);

--
-- 在傾印的資料表使用自動遞增(AUTO_INCREMENT)
--

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `Address`
--
ALTER TABLE `Address`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `Bill`
--
ALTER TABLE `Bill`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `Category`
--
ALTER TABLE `Category`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `Characters`
--
ALTER TABLE `Characters`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `City`
--
ALTER TABLE `City`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `County`
--
ALTER TABLE `County`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=369;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `Gash`
--
ALTER TABLE `Gash`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `Gift`
--
ALTER TABLE `Gift`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `HeadPhoto`
--
ALTER TABLE `HeadPhoto`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `Logistics`
--
ALTER TABLE `Logistics`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `LogisticsMethod`
--
ALTER TABLE `LogisticsMethod`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `LogisticsPeople`
--
ALTER TABLE `LogisticsPeople`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `Machine`
--
ALTER TABLE `Machine`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `Material`
--
ALTER TABLE `Material`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `Price`
--
ALTER TABLE `Price`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `Prize`
--
ALTER TABLE `Prize`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `Records`
--
ALTER TABLE `Records`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `Series`
--
ALTER TABLE `Series`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `SeriesImg`
--
ALTER TABLE `SeriesImg`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `SeriesTitle`
--
ALTER TABLE `SeriesTitle`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `Status`
--
ALTER TABLE `Status`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `Theme`
--
ALTER TABLE `Theme`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `ToG`
--
ALTER TABLE `ToG`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `Users`
--
ALTER TABLE `Users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 已傾印資料表的限制式
--

--
-- 資料表的限制式 `Address`
--
ALTER TABLE `Address`
  ADD CONSTRAINT `address_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`),
  ADD CONSTRAINT `address_ibfk_2` FOREIGN KEY (`county_id`) REFERENCES `County` (`id`),
  ADD CONSTRAINT `address_ibfk_3` FOREIGN KEY (`status_id`) REFERENCES `Status` (`id`);

--
-- 資料表的限制式 `Bill`
--
ALTER TABLE `Bill`
  ADD CONSTRAINT `bill_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`),
  ADD CONSTRAINT `bill_ibfk_2` FOREIGN KEY (`gash_id`) REFERENCES `Gash` (`id`);

--
-- 資料表的限制式 `Characters`
--
ALTER TABLE `Characters`
  ADD CONSTRAINT `characters_ibfk_1` FOREIGN KEY (`series_id`) REFERENCES `Series` (`id`),
  ADD CONSTRAINT `characters_ibfk_2` FOREIGN KEY (`prize_id`) REFERENCES `Prize` (`id`),
  ADD CONSTRAINT `characters_ibfk_3` FOREIGN KEY (`material_id`) REFERENCES `Material` (`id`);

--
-- 資料表的限制式 `Collection`
--
ALTER TABLE `Collection`
  ADD CONSTRAINT `collection_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`),
  ADD CONSTRAINT `collection_ibfk_2` FOREIGN KEY (`series_id`) REFERENCES `Series` (`id`);

--
-- 資料表的限制式 `County`
--
ALTER TABLE `County`
  ADD CONSTRAINT `county_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `City` (`id`);

--
-- 資料表的限制式 `Gift`
--
ALTER TABLE `Gift`
  ADD CONSTRAINT `gift_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`),
  ADD CONSTRAINT `gift_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `Category` (`id`);

--
-- 資料表的限制式 `Logistics`
--
ALTER TABLE `Logistics`
  ADD CONSTRAINT `logistics_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`),
  ADD CONSTRAINT `logistics_ibfk_2` FOREIGN KEY (`method_id`) REFERENCES `LogisticsMethod` (`id`),
  ADD CONSTRAINT `logistics_ibfk_3` FOREIGN KEY (`status_id`) REFERENCES `Status` (`id`),
  ADD CONSTRAINT `logistics_ibfk_4` FOREIGN KEY (`logistics_people_id`) REFERENCES `LogisticsPeople` (`id`),
  ADD CONSTRAINT `logistics_ibfk_5` FOREIGN KEY (`address_id`) REFERENCES `Address` (`id`);

--
-- 資料表的限制式 `LogisticsItem`
--
ALTER TABLE `LogisticsItem`
  ADD CONSTRAINT `logisticsitem_ibfk_1` FOREIGN KEY (`logistics_id`) REFERENCES `Logistics` (`id`),
  ADD CONSTRAINT `logisticsitem_ibfk_2` FOREIGN KEY (`records_id`) REFERENCES `Records` (`id`);

--
-- 資料表的限制式 `LogisticsPeople`
--
ALTER TABLE `LogisticsPeople`
  ADD CONSTRAINT `logisticspeople_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`),
  ADD CONSTRAINT `logisticspeople_ibfk_2` FOREIGN KEY (`status_id`) REFERENCES `Status` (`id`);

--
-- 資料表的限制式 `Machine`
--
ALTER TABLE `Machine`
  ADD CONSTRAINT `machine_ibfk_1` FOREIGN KEY (`character_id`) REFERENCES `Characters` (`id`);

--
-- 資料表的限制式 `Records`
--
ALTER TABLE `Records`
  ADD CONSTRAINT `records_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`),
  ADD CONSTRAINT `records_ibfk_2` FOREIGN KEY (`character_id`) REFERENCES `Characters` (`id`),
  ADD CONSTRAINT `records_ibfk_3` FOREIGN KEY (`status_id`) REFERENCES `Status` (`id`);

--
-- 資料表的限制式 `Series`
--
ALTER TABLE `Series`
  ADD CONSTRAINT `series_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `Category` (`id`),
  ADD CONSTRAINT `series_ibfk_2` FOREIGN KEY (`theme_id`) REFERENCES `Theme` (`id`),
  ADD CONSTRAINT `series_ibfk_3` FOREIGN KEY (`price_id`) REFERENCES `Price` (`id`),
  ADD CONSTRAINT `series_ibfk_4` FOREIGN KEY (`name_title_id`) REFERENCES `SeriesTitle` (`id`);

--
-- 資料表的限制式 `SeriesImg`
--
ALTER TABLE `SeriesImg`
  ADD CONSTRAINT `seriesimg_ibfk_1` FOREIGN KEY (`series_id`) REFERENCES `Series` (`id`);

--
-- 資料表的限制式 `ToG`
--
ALTER TABLE `ToG`
  ADD CONSTRAINT `tog_ibfk_1` FOREIGN KEY (`record_id`) REFERENCES `Records` (`id`);

--
-- 資料表的限制式 `Users`
--
ALTER TABLE `Users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`county_id`) REFERENCES `County` (`id`),
  ADD CONSTRAINT `users_ibfk_2` FOREIGN KEY (`headphoto`) REFERENCES `HeadPhoto` (`id`);

--
-- 資料表的限制式 `Waitinglist`
--
ALTER TABLE `Waitinglist`
  ADD CONSTRAINT `waitinglist_ibfk_1` FOREIGN KEY (`series_id`) REFERENCES `Series` (`id`),
  ADD CONSTRAINT `waitinglist_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
