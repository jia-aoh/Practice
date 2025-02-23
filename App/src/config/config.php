<?php
namespace App\config;
// 定義$mode= A:原始尺寸, H:百台尺, O:英吋8進位
DEFINE('UNIT_MODE', [
  'tfoot' => 'H',
  'inch' => 'O'
]);

// 定義單位換算係數
DEFINE('CONVERSION_FACTORS', [
  'tfoot' => 33 / 10000,
  'tinch' => 33 / 1000,
  'tcent' => 33 / 100,
  'foot'  => 10 / 3048,
  'inch'  => 10 / 254,
  'mm'    => 1  / 1,
  'cm'    => 1  / 10,
  'm'     => 1  / 1000,
]);

// 配置ORM
DEFINE('UNIT_MAP', [
  '台尺, 台呎' => 'tfoot',
  '台寸, 台吋' => 'tinch',
  '台分' => 'tcent',
  '英呎, 英尺' => 'foot',
  '英吋, 英寸' => 'inch',
  '毫米' => 'mm',
  '公分' => 'cm',
  '公尺' => 'm',
]);
