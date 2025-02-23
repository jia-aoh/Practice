<?php

namespace App\Math;

use Exception;
class UnitConverter
{
  // 換算係數
  private $conversion_factors;
  // ORM
  private $unit_map;

  public function __construct($conversion_factors, $unit_map)
  {
    $this->conversion_factors = $conversion_factors;
    $this->unit_map = $unit_map;
  }

  public function getConversionFactors()
  {
    return $this->conversion_factors;
  }
  public function getUnitMap()
  {
    return $this->unit_map;
  }
  public function getUnitORM($searchUnit)
  {
    $unitCode = null;
    foreach ($this->unit_map as $keys => $value) {
      if ($value === $searchUnit) {
        $unitCode = $value;
        break;
      }
    }

    if (!$unitCode) {
      foreach ($this->unit_map as $keys => $value) {
        $keysArray = explode(', ', $keys);
        if (in_array($searchUnit, $keysArray)) {
          $unitCode = $value;
          break;
        }
      }
    }
    return $unitCode ?? throw new Exception("Invalid searchunit in (getUnitORM)");;
  }

  // 取的單位換算係數
  public function getConversionFactor($fromUnit, $toUnit)
  {
    $fromUnit = $this->getUnitORM($fromUnit);
    $toUnit = $this->getUnitORM($toUnit);

    // Check if the units are valid（單位是否被定義）
    if (!array_key_exists($fromUnit, $this->conversion_factors) || !array_key_exists($toUnit, $this->conversion_factors)) {
      throw new Exception("Invalid unit");
    }

    // Return the conversion factor（得單位換算係數）
    return $this->conversion_factors[$toUnit] / $this->conversion_factors[$fromUnit];
  }

  // 人看的單位（百台尺、八進位英吋）
  public function convertHumanUnit($numbers, $mode = null, $conversionType = null)
  {
    if (!is_array($numbers)) {
      $numbers = [$numbers];
    }
    $convertedValues = [];

    // foreach ($numbers as $number) {
    // 客戶打單尺寸採實際尺寸
    if ($mode === 'A') {
      $convertedValues = array_values($numbers);
    } elseif ($conversionType === 'toActual') {

      // 客戶打單尺寸有{H:百台尺, O:英吋小數點後八進位}
      if ($mode === 'H') {
        $convertedValues = array_map(fn($number) => $number / 100, $numbers);
      } elseif ($mode === 'O') {
        $convertedValues = array_map(function ($number) {
          $integerPart = floor($number);
          $fractionalPart = $number - $integerPart;

          return $fractionalPart === 0 ? $integerPart : $integerPart + $fractionalPart * 1.25;
        }, $numbers);
      }
    } elseif ($conversionType === 'toCustom') {
      if ($mode === 'H') {
        $convertedValues = array_map(fn($number) => $number * 100, $numbers);
      } elseif ($mode === 'O') {
        $convertedValues = array_map(function ($number) {
          $integerPart = floor($number);
          $fractionalPart = $number - $integerPart;
          return $fractionalPart === 0 ? $integerPart : $integerPart + $fractionalPart / 1.25; // 反轉為8進位
        }, $numbers);
      }
    } else {
      throw new Exception("Invalid mode, or invalid conversion type (Glass.convertHumanUnit)");
    }
    // }

    return $convertedValues;
  }

  // 單位換算
  public function convertUnits($values, $fromUnit, $toUnit)
  {
    $conversionFactor = $this->getConversionFactor($fromUnit, $toUnit);
    return array_map(fn($value) => $value * $conversionFactor, $values);
  }
}
