-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- 主機： localhost
-- 產生時間： 2024 年 12 月 12 日 10:40
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

-- --------------------------------------------------------

--
-- 資料表結構 `Characters`
--

CREATE TABLE `Characters` (
  `id` int(10) UNSIGNED NOT NULL,
  `series_id` int(10) UNSIGNED NOT NULL COMMENT '系列id',
  `prize_id` tinyint(3) UNSIGNED COMMENT '賞別id',
  `name` varchar(20) NOT NULL COMMENT '角色名',
  `img` varchar(100) DEFAULT NULL COMMENT '角色圖',
  `material_id` tinyint(3) UNSIGNED DEFAULT NULL COMMENT '材質id',
  `size1` tinyint(3) UNSIGNED DEFAULT NULL COMMENT '長',
  `size2` tinyint(3) UNSIGNED DEFAULT NULL COMMENT '中',
  `size3` tinyint(3) UNSIGNED DEFAULT NULL COMMENT '短'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- 資料表結構 `City`
--

CREATE TABLE `City` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `city` varchar(3) NOT NULL COMMENT '縣'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- 資料表結構 `Collection`
--

CREATE TABLE `Collection` (
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '會員id',
  `series_id` int(10) UNSIGNED NOT NULL COMMENT '系列id',
  `notification_status` tinyint(3) UNSIGNED DEFAULT 10 COMMENT '是否補貨'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

-- --------------------------------------------------------

--
-- 資料表結構 `Gash`
--

CREATE TABLE `Gash` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `gash` mediumint(8) UNSIGNED DEFAULT NULL COMMENT 'G幣',
  `dollar` mediumint(8) UNSIGNED DEFAULT NULL COMMENT '台幣'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

-- --------------------------------------------------------

--
-- 資料表結構 `HeadPhoto`
--

CREATE TABLE `HeadPhoto` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `headphoto` varchar(10) DEFAULT NULL COMMENT '頭像'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `status_id` tinyint(3) UNSIGNED DEFAULT 6 COMMENT '狀態id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- 資料表結構 `LogisticsItem`
--

CREATE TABLE `LogisticsItem` (
  `logistics_id` int(10) UNSIGNED NOT NULL COMMENT '物流單id',
  `records_id` int(10) UNSIGNED NOT NULL COMMENT '扭抽單id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- 資料表結構 `LogisticsMethod`
--

CREATE TABLE `LogisticsMethod` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `method` varchar(2) NOT NULL COMMENT '物流方式'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

-- --------------------------------------------------------

--
-- 資料表結構 `Material`
--

CREATE TABLE `Material` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `material` varchar(25) DEFAULT NULL COMMENT '材質'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

-- --------------------------------------------------------

--
-- 資料表結構 `Prize`
--

CREATE TABLE `Prize` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `prize` varchar(1) DEFAULT NULL COMMENT '賞別'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

-- --------------------------------------------------------

--
-- 資料表結構 `Series`
--

CREATE TABLE `Series` (
  `id` int(10) UNSIGNED NOT NULL,
  `category_id` tinyint(3) UNSIGNED NOT NULL COMMENT '商品類id',
  `name_title_id` int(10) UNSIGNED DEFAULT NULL COMMENT '系列主題名id',
  `name` varchar(20) NOT NULL COMMENT '系列名',
  `theme_id` tinyint(3) UNSIGNED COMMENT '主題id',
  `price_id` tinyint(3) UNSIGNED NOT NULL COMMENT '價格id',
  `stock` tinyint(3) UNSIGNED NOT NULL COMMENT '庫存',
  `release_time` bigint(20) COMMENT '上架時間',
  `end_time` bigint(20) COMMENT '抽完、補貨時間'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- 資料表結構 `SeriesImg`
--

CREATE TABLE `SeriesImg` (
  `id` int(10) UNSIGNED NOT NULL,
  `series_id` int(10) UNSIGNED NOT NULL COMMENT '系列id',
  `img` varchar(100) DEFAULT NULL COMMENT '系列圖'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- 資料表結構 `SeriesTitle`
--

CREATE TABLE `SeriesTitle` (
  `id` int(10) UNSIGNED NOT NULL,
  `name_title` varchar(20) NOT NULL COMMENT '系列主題名'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
('2cTx7g97GvVr6ujcDw24cyfXlETrMjlSkWr8t3AE', NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiZTdnMHVDclRqRXBJRHFEcWVyNXA3aVZZd0N0eXluYmdQY2hvdzZXeiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1733671104);

-- --------------------------------------------------------

--
-- 資料表結構 `Status`
--

CREATE TABLE `Status` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `status` varchar(5) DEFAULT NULL COMMENT '狀態'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- 資料表結構 `Theme`
--

CREATE TABLE `Theme` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `theme` varchar(7) DEFAULT NULL COMMENT '系列主題'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `time` bigint(20) DEFAULT NULL COMMENT '開抽時間'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- 檢視表結構 `vw_allegg`
--
DROP TABLE IF EXISTS `vw_allegg`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `gachora`.`vw_allegg`  AS SELECT `s`.`id` AS `series_id`, `t`.`theme` AS `theme`, `st`.`name_title` AS `series_title`, `s`.`name` AS `name`, `p`.`price` AS `price`, count(`s`.`id`) AS `amount` FROM ((((`gachora`.`series` `s` left join `gachora`.`theme` `t` on(`s`.`theme_id` = `t`.`id`)) left join `gachora`.`price` `p` on(`s`.`price_id` = `p`.`id`)) left join `gachora`.`characters` `c` on(`s`.`id` = `c`.`series_id`)) left join `gachora`.`seriestitle` `st` on(`s`.`name_title_id` = `st`.`id`)) WHERE `s`.`category_id` = 1 GROUP BY `s`.`id` ORDER BY `s`.`stock` DESC ;

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

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `gachora`.`vw_hotegg`  AS SELECT `c`.`series_id` AS `series_id`, `t`.`theme` AS `theme`, `st`.`name_title` AS `series_title`, `s`.`name` AS `name`, `p`.`price` AS `price`, `a`.`amount` AS `amount` FROM ((((((`gachora`.`records` `r` left join `gachora`.`characters` `c` on(`r`.`character_id` = `c`.`id`)) left join `gachora`.`series` `s` on(`s`.`id` = `c`.`series_id`)) left join `gachora`.`seriestitle` `st` on(`s`.`name_title_id` = `st`.`id`)) left join `gachora`.`theme` `t` on(`s`.`theme_id` = `t`.`id`)) left join `gachora`.`price` `p` on(`s`.`price_id` = `p`.`id`)) left join (select `s`.`id` AS `series_id`,count(`s`.`id`) AS `amount` from (`gachora`.`series` `s` left join `gachora`.`characters` `c` on(`s`.`id` = `c`.`series_id`)) where `s`.`category_id` = 1 group by `s`.`id`) `a` on(`c`.`series_id` = `a`.`series_id`)) WHERE `s`.`category_id` = 1 GROUP BY `c`.`series_id` ORDER BY count(`c`.`series_id`) DESC ;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `Bill`
--
ALTER TABLE `Bill`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `Category`
--
ALTER TABLE `Category`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `Characters`
--
ALTER TABLE `Characters`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `City`
--
ALTER TABLE `City`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `County`
--
ALTER TABLE `County`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `Gash`
--
ALTER TABLE `Gash`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `Gift`
--
ALTER TABLE `Gift`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `HeadPhoto`
--
ALTER TABLE `HeadPhoto`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `Logistics`
--
ALTER TABLE `Logistics`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `LogisticsMethod`
--
ALTER TABLE `LogisticsMethod`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `LogisticsPeople`
--
ALTER TABLE `LogisticsPeople`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `Machine`
--
ALTER TABLE `Machine`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `Material`
--
ALTER TABLE `Material`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `Price`
--
ALTER TABLE `Price`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `Prize`
--
ALTER TABLE `Prize`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `Records`
--
ALTER TABLE `Records`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `Series`
--
ALTER TABLE `Series`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `SeriesImg`
--
ALTER TABLE `SeriesImg`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `SeriesTitle`
--
ALTER TABLE `SeriesTitle`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `Status`
--
ALTER TABLE `Status`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `Theme`
--
ALTER TABLE `Theme`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `ToG`
--
ALTER TABLE `ToG`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `Users`
--
ALTER TABLE `Users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

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
