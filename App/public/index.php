<?php

require __DIR__ . '/../vendor/autoload.php';

use App\Glass\Glass;

try {
  $input_length_width = array(101.1, 203.3, 305.5, 407.7);
  $inputUnit = '台吋';
  $convertUnit = '台尺';
  $units = 1;
  $round = '寸材';
  echo '<pre>';
  $glass = new Glass($input_length_width, $inputUnit);

  echo '1.輸入' . $inputUnit;
  $sides = $glass->getSides();
  foreach ($sides as $key => $value) {
    echo  ' | ' . $value;
  }

  echo '<br><br>2.磨邊' . $inputUnit;
  $largeSides = $glass->getLargerSides();
  foreach ($largeSides as $key => $value) {
    echo  ' | ' . $value;
  }

  echo '<br><br>3.實際' . $inputUnit;
  $ActualSides = $glass->getSidesActualValue();
  foreach ($ActualSides as $key => $value) {
    echo  ' | ' . $value;
  }

  echo '<br><br>4.轉換單位成' . $convertUnit;
  $mmSides = $glass->getSidesConvertTo($convertUnit);
  foreach ($mmSides as $key => $value) {
    echo  ' | ' . $value;
  }

  echo '<br><br>5.加' . $units . '單位(英吋本位) | ';
  $addLength = $glass->getAddLength([$units]);
  foreach ($addLength as $key => $value) {
    echo $value . ' ' .  $inputUnit;
  }

  echo '<br><br>6.' . $round;
  $roundedSides = $glass->getSidesRounded($round);
  foreach ($roundedSides as $key => $value) {
    echo  ' | ' . $value;
  }

  echo '<br><br>7.' . $round . '面積';
  $roundedSides = $glass->calculateArea($round);
  foreach ($roundedSides as $key => $value) {
    echo  '<br> ' . $key . ' | ' . $value;
  }

  echo '</pre>';
} catch (Exception $e) {
  echo "Error: " . $e->getMessage() . "\n";
}
