<?php
// this file should use namespace App\Math\UnitConverter (src/Math/UnitConverter.php)

namespace App\Glass;

use App\Math\UnitConverter;
use Exception;

class Glass
{
  private $sidesHuman;
  private $sidesActual;
  private $sidesConverted;
  private $unitOriginal;
  private $unitConverter;

  public function __construct($sides, $unit)
  {
    if (count($sides) != 2 && count($sides) != 4) {
      throw new Exception("Input should be either 2 or 4 sides (Glass.validateSides)");
    } else {
      $this->sidesHuman = $sides;
      $this->unitOriginal = $unit;
      $this->unitConverter = new UnitConverter(CONVERSION_FACTORS, UNIT_MAP);
      $this->sortSides();
    }
  }
  // 看邊長
  public function getSides()
  {
    return $this->sidesHuman;
  }

  // 按長長短短排序
  public function sortSides()
  {
    // 兩個邊將邊長大到小排列，四個邊分別處理前兩個和後兩個
    if (count($this->sidesHuman) == 2) {
      rsort($this->sidesHuman);
    } elseif (count($this->sidesHuman) == 4) {
      $firstPart = array_slice($this->sidesHuman, 0, 2);
      $secondPart = array_slice($this->sidesHuman, 2, 2);

      rsort($firstPart);
      rsort($secondPart);
      $this->sidesHuman = array_merge($firstPart, $secondPart);
    }
  }

  // 取磨邊長寬
  public function getLargerSides()
  {
    if (count($this->sidesHuman) == 2) {
      return $this->sidesHuman;
    } elseif (count($this->sidesHuman) == 4) {
      return [$this->sidesHuman[0], $this->sidesHuman[2]];
    } else {
      throw new Exception("Invalid amount of sides (getLargerSides)");
    }
  }

  // 轉實際值(排除百台尺、英吋8進位)
  public function getSidesActualValue()
  {
    $unit_map = $this->unitConverter->getUnitMap();
    array_key_exists($this->unitOriginal, $unit_map) ? $mode = $unit_map[$this->unitOriginal] : $mode = $this->unitOriginal;
    !array_key_exists($mode, $unit_map) || in_array($mode, $unit_map) && throw new Exception("Invalid unit origin: {$this->unitOriginal}, will change to 'A' finally. (getSidesActualValue)");
    // 得對應慣用模式，其他人工 = 實際值設定為 A for Actual
    $mode = UNIT_MODE[$mode] ?? 'A';


    // 人工轉實際值
    $this->sidesActual = $this->unitConverter->convertHumanUnit($this->sidesHuman, $mode, 'toActual');

    return $this->sidesActual;
  }
  
  // 看換單位(實材)
  function getSidesConvertTo($toUnit)
  {
    $this->sidesConverted = $this->unitConverter->convertUnits($this->getSidesActualValue(), $this->unitOriginal, $toUnit);
    return $this->sidesConverted;
  }

  // 加大加長加寬(inch單位轉實際單位)
  function getAddLength($addUnits)
  {
    $length = $this->unitConverter->convertUnits($addUnits, 'inch', $this->unitOriginal); // 要加的單位數(inch)
    return $length;
  }

  // 玻璃進位、計
  function getSidesRounded($roundMethod)
  {
    //??夾單位要顯示在計價材上（幾x幾）的話，需要修改

    $lastChar = mb_substr($roundMethod, -1, 1);

    if ($lastChar === '進') {
      if (preg_match('/^\d+/', $roundMethod, $firstChar)) {
        // 轉英吋，並進位
        $sides = $this->getSidesConvertTo('inch');
        $result = array_map(fn($number) => ceil($number / $firstChar[0]) * $firstChar[0], $sides);
      } else {
        // 轉英吋，不進位
        $sides = $this->getSidesConvertTo('inch');
        $result = array_map(fn($number) => ceil($number), $sides);
      }
    } else {
      $firstChar = mb_substr($roundMethod, 0, 1);

      switch ($firstChar) {
        case '英':
          $sides = $this->getSidesConvertTo('inch');
          $result = array_map(fn($number) => round($number, 2), $sides);
          break;
        case '台':
          $sides = $this->getSidesConvertTo('tfoot');
          $result = $sides;
          break;
        case '寸':
          $sides = $this->getSidesConvertTo('tfoot');
          $result = array_map(fn($number) => ceil($number / 0.1) * 0.1, $sides);
          break;
        case '二':
          $sides = $this->getSidesConvertTo('tfoot');
          $result = array_map(fn($number) => ceil($number / 0.25) * 0.25, $sides);
          break;
        case '五':
          $sides = $this->getSidesConvertTo('tfoot');
          $result = array_map(fn($number) => ceil($number / 0.5) * 0.5, $sides);
          break;;
          break;
        case 'm':
          $sides = $this->getSidesConvertTo('m');
          $result = array_map(fn($number) => round($number, 3), $sides);
          break;
        case 'c':
          $sides = $this->getSidesConvertTo('cm');
          $result = array_map(fn($number) => round($number, 1), $sides);
          break;
        default:
          throw new Exception("Invalid rounded method(getSidesRounded)");
      }
    }
    return $result;
  }

  // 計算面積（未進位、已進位）
  public function calculateArea($roundMethod = 'Actual')
  {
    $length_width = [];
    // 未進位面積
    if ($roundMethod === 'Actual') {
      $sides = $this->sidesConverted;
      if (count($sides) == 2) {
        $length_width = $sides;
      } elseif (count($sides) == 4) {
        $length_width = [$sides[0], $sides[2]];
      }
    } else {
      // 已進位面積
      $sides = $this->getSidesRounded($roundMethod);
      if (count($sides) == 2) {
        $length_width = $$this->getSidesRounded($roundMethod);
      } elseif (count($sides) == 4) {
        $length_width = [$sides[0], $sides[2]];
      }
    }

    $width = $length_width[1];
    $length = $length_width[0];
    return [
      'length' => $length,
      'width' => $width,
      'area' => $width * $length
    ];
  }
}
