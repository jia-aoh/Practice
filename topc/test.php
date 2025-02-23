<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
</head>

<body>
  <form action="./test.php" method="post">
    <input list="units" class="list" name="unit_from" placeholder="起始單位">
    <input type="number" name="number" placeholder="請輸入數字">
    <input list="units" class="list" name="unit_to" placeholder="目標單位">
    <datalist id="units">
      <option value="台尺"></option>
      <option value="台寸"></option>
      <option value="台分"></option>
      <option value="英呎"></option>
      <option value="英吋"></option>
      <option value="毫米"></option>
      <option value="公分"></option>
      <option value="公尺"></option>
    </datalist>
  </form>
  <script>
    const input = document.querySelector(".list");
    const datalist = document.getElementById("units");

    input.addEventListener("blur", function() {
      const isValid = Array.from(datalist.options).some(option => option.value === input.value);

      if (!isValid) {
        input.value = '';
      }
    });
    input.addEventListener("keydown", function(event) {
      if (event.key === " ") {
        event.preventDefault();
        form.submit();
      }
    });
  </script>
</body>

</html>
<?php
var_dump($_POST);
if($_POST['number'] && $_POST['unit_from'] && $_POST['unit_to']){
  $result = convertUnit($_POST['unit_from'], $_POST['number'], $_POST['unit_to']);
  var_dump($result);
}
// define
DEFINE('EDGE_PROCESS_MODE', 'N'); // Normal(正常2長2短), Custom(客製化型)
DEFINE('TAIWANESE_FOOT_MODE', 'H'); // Actual(實際台尺), Hundred(/百 台尺)
DEFINE('INCH_MODE', 'O'); // Decimal(10進位英吋), Octal(8進位英吋)
// DEFINE('UNIT_COEFFICIENT', []); // 單位轉換係數設定
DEFINE('UNIT_COEFFICIENT', [1 / 303, 10 / 303, 100 / 303, 10 / 3048, 10 / 254, 1, 1 / 10, 1 / 1000]); // 單位轉換係數設定
/** 
 * 預設： 原數除自係數 ＊ 目標係數 ＝ 目標數
 *   台尺       台寸   台分      英呎         英吋    毫米  公分  公尺
 *  33/10000  33/1000 33/100 100/30480  100/2540    1  1/10 1/1000 (預設精準)
 *  1/303     10/303 100/303  10/3048   10/254      1  1/10 1/1000（excel現行）
 */
DEFINE('C_UNITS', ['台尺', '台寸', '台分', '英呎', '英吋', '毫米', '公分', '公尺']);
DEFINE('UNITS', ['tfoot', 'tinch', 'tcent', 'foot', 'inch', 'mm', 'cm', 'm']);
// 偵測使用者輸入多少數字，並排序
function checkIfTwoOrFourValues($length_1st = 0, $length_2nd = 0, $width_1st = 0, $width_2nd = 0)
{
  // pre-check 1 (type check)
  if (!is_numeric($length_1st) || !is_numeric($length_2nd) || !is_numeric($width_1st) || !is_numeric($width_2nd)) {
    return ['status_code' => 400, 'message' => 'Only numbers are allowed incheckIfTwoOrFourValues.'];
    exit;
  }
  // pre-check 2 (value check)
  if ($length_1st < 0 || $length_2nd < 0 || $width_1st < 0 || $width_2nd < 0) {
    return ['status_code' => 400, 'message' => 'Numbers must be positive in checkIfTwoOrFourValues.'];
    exit;
  }
  // condition 4 values
  if ($length_1st !== 0 && $length_2nd !== 0 && $width_1st === 0 && $width_2nd === 0) {
    return [
      'status_code' => 200,
      'message' => 'Success',
      'data' => [
        $length_1st > $length_2nd ? formatFloatBasedOnInput($length_1st) : formatFloatBasedOnInput($length_2nd),
        $length_1st < $length_2nd ? formatFloatBasedOnInput($length_1st) : formatFloatBasedOnInput($length_2nd)
      ]
    ];
    exit;
  }
  // condition 4 values
  if ($length_1st !== 0 && $length_2nd !== 0 && $width_1st !== 0 && $width_2nd !== 0) {
    $length_sorted = $length_1st > $length_2nd ? [formatFloatBasedOnInput($length_1st), formatFloatBasedOnInput($length_2nd)] : [formatFloatBasedOnInput($length_2nd), formatFloatBasedOnInput($length_1st)];
    $width_sorted = $width_1st > $width_2nd ? [formatFloatBasedOnInput($width_1st), formatFloatBasedOnInput($width_2nd)] : [formatFloatBasedOnInput($width_2nd), formatFloatBasedOnInput($width_1st)];
    return [
      'status_code' => 200,
      'message' => 'Success',
      'data' => array_merge($length_sorted, $width_sorted)
    ];
    exit;
  }

  return ['status_code' => 400, 'message' => 'Only 2 or 4 numeric values are accepted in checkIfTwoOrFourValues.'];
  exit;
}
// ----------------------------------------------------------
// 取長邊（為了磨邊計算）
function getMaxLengthAndWidth($input_array, $mode = EDGE_PROCESS_MODE)
{
  switch ($mode) {
    case 'N': // normal mode: LLWW
      if (count($input_array) == 2) {
        return [
          'status_code' => 200,
          'message' => 'Success',
          'data' => $input_array,
        ];
      }
      if (count($input_array) == 4) {
        return [
          'status_code' => 200,
          'message' => 'Success',
          'data' => [$input_array[0], $input_array[2]],
        ];
      }
      break;
    case 'C': // custom mode
      return [
        'status_code' => 200,
        'message' => 'Success',
        'data' => $input_array,
      ];
    default:
      return [
        'status_code' => 400,
        'message' => 'Error in getMaxLengthAndWidth.',
      ];
  }
}
// ------------------------------------------------------------
// 取得使用者輸入小數位數（解決小數點binary問題）
function formatFloatBasedOnInput($number)
{
  $numberChunks = explode('.', (string)$number);
  if (count($numberChunks) == 2) {
    $decimalPlaces =  strlen($numberChunks[1]);
  }else{
    $decimalPlaces = 0;
  }
  // Float精度重編
  return number_format($number, $decimalPlaces, '.', '');
}
// -----------------------------------------
// 轉到實際單位mode
// Actual(實際台尺), Hundred(/百 台尺)
function getActualTaiwaneseFoot($number, $mode = TAIWANESE_FOOT_MODE)
{
  if ($mode === 'A') {
    return $number;
    exit;
  }
  if ($mode === 'H') {
    return $number / 100;
    exit;
  }
}
// -----------------------------------------
// Decimal(10進位英吋), Octal(8進位英吋)
function getActualInch($number, $mode = INCH_MODE)
{
  switch ($mode) {

    case 'D':

      return $number;
      break;

    case 'O':

      $integerPart = floor($number);
      $fractionalPart = $number - $integerPart;

      if ($fractionalPart === 0) {
        return $integerPart;
      } else {
        return $integerPart + $fractionalPart * 1.25; // 0.125 * 10小數變整數
        exit;
      }

    default:

      return null;
      break;
  }
}
// -----------------------------------------
// 轉回廠須單位mode
// Actual(實際台尺), Hundred(/百 台尺)
function toCustomTaiwaneseFootValue($number, $mode = TAIWANESE_FOOT_MODE)
{
  switch ($mode) {

    case 'A':
      return $number;
      break;

    case 'H':
      return $number * 100;
      break;

    default:
      return null;
      break;
  }
}
// -----------------------------------------
// Decimal(10進位英吋), Octal(8進位英吋)
function toCustomInchValue($number, $mode = INCH_MODE)
{
  switch ($mode) {

    case 'D':
      return $number;
      break;

    case 'O':
      $integerPart = floor($number);
      $fractionalPart = $number - $integerPart;

      if ($fractionalPart === 0) {
        return $integerPart;
      } else {
        return $integerPart + $fractionalPart / 1.25; // 0.125 * 10小數變整數
      }
      break;

    default:
      return null;
      break;
  }
}
// ------------------------------------------
// 轉換單位
function convertUnit($from_unit, $number, $to_unit, $coefficient = UNIT_COEFFICIENT, $cUnits = C_UNITS, $units = UNITS)
{
  if (!is_numeric($number)) {
    return [
      'status_code' => 400,
      'message' => 'Only number is accepted in convertUnit.',
    ];
    exit;
  }
  $length_cunit = ['台尺', '台寸', '台分', '英呎', '英吋', '毫米', '公分', '公尺'];
  $cUnits === [] ? ($cUnits = $length_cunit) : ($cUnits = $cUnits);
  $length_unit = ['tfoot', 'tinch', 'tcent', 'foot', 'inch', 'mm', 'cm', 'm'];
  $units === [] ? ($units = $length_unit) : ($units = $units);
  $length_coefficient = [33 / 10000, 33 / 1000, 33 / 100, 10 / 3048, 10 / 254, 1, 1 / 10, 1 / 1000];
  $round = [2, 1, 0, 1, 1, 0, 1, 3];
  if (isset($from_unit) && isset($to_unit)) {
    if (in_array($from_unit, $cUnits)) {
      $fromUnit_index = array_search($from_unit, $cUnits);
    }
    if (in_array($from_unit, $units)) {
      $fromUnit_index = array_search($from_unit, $units);
    }
    if (in_array($to_unit, $cUnits)) {
      $toUnit_index = array_search($to_unit, $cUnits);
    }
    if (in_array($to_unit, $units)) {
      $toUnit_index = array_search($to_unit, $units);
    }
  }
  if (!isset($toUnit_index) || !isset($fromUnit_index)) {
    return [
      'status_code' => 400,
      'message' => 'Not an acceptable unit in convertUnit.',
    ];
    exit;
  }
  $coefficient === [] ? ($coefficient = $length_coefficient) : ($coefficient = $coefficient);
  $result = $number / $coefficient[$fromUnit_index] * $coefficient[$toUnit_index];
  switch ($toUnit_index) {
    case 0:
      $result = number_format(toCustomTaiwaneseFootValue($result, TAIWANESE_FOOT_MODE), $round[$toUnit_index]);
      break;
    case 4:
      $result = number_format(toCustomInchValue($result, INCH_MODE), $round[$toUnit_index]);
      break;
    default:
      $result = number_format($result, $round[$toUnit_index]);
      break;
  }
  return
    [
      'status_code' => 200,
      'message' => 'Success',
      'data' => [
        'number' => $result,
        'unit' => $units[$toUnit_index],
        'cunit' => $cUnits[$toUnit_index],
      ]
    ];
}
function addPriceUnit($number, $toUnit, $add, $addUnit = 'inch', $coefficient = UNIT_COEFFICIENT, $cUnits = C_UNITS, $units = UNITS)
{
  $length_cunit = ['台尺', '台寸', '台分', '英呎', '英吋', '毫米', '公分', '公尺'];
  $length_unit = ['tfoot', 'tinch', 'tcent', 'foot', 'inch', 'mm', 'cm', 'm'];
  $cUnits === [] ? ($cUnits = $length_cunit) : ($cUnits = $cUnits);
  $units === [] ? ($units = $length_unit) : ($units = $units);
  $length_coefficient = [33 / 10000, 33 / 1000, 33 / 100, 10 / 3048, 10 / 254, 1, 1 / 10, 1 / 1000];
  $round = [2, 1, 0, 1, 1, 0, 1, 3];
  if (isset($toUnit) && isset($addUnit)) {
    if (in_array($toUnit, $cUnits)) {
      $toUnit_index = array_search($toUnit, $cUnits);
    }
    if (in_array($toUnit, $units)) {
      $toUnit_index = array_search($toUnit, $units);
    }
    if (in_array($addUnit, $cUnits)) {
      $addUnit_index = array_search($addUnit, $cUnits);
    }
    if (in_array($addUnit, $units)) {
      $addUnit_index = array_search($addUnit, $units);
    }
  }
  if (!isset($addUnit_index) || !isset($toUnit_index)) {
    return [
      'status_code' => 400,
      'message' => 'Not an acceptable unit in addPriceUnit.',
    ];
    exit;
  }
  $coefficient === [] ? ($coefficient = $length_coefficient) : ($coefficient = $coefficient);

  $result = $add / $coefficient[$addUnit_index] * $coefficient[$toUnit_index];
  $result = $number + $result;
  switch ($toUnit_index) {
    case 0:
      $result = number_format(toCustomTaiwaneseFootValue($result, TAIWANESE_FOOT_MODE), $round[$toUnit_index]);
      break;
    case 4:
      $result = number_format(toCustomInchValue($result, INCH_MODE), $round[$toUnit_index]);
      break;
    default:
      $result = number_format($result, $round[$toUnit_index]);
      break;
  }
  return
    [
      'status_code' => 200,
      'message' => 'Success',
      'data' => [
        'number' => $result,
        'unit' => $units[$toUnit_index],
        'cunit' => $cUnits[$toUnit_index],
      ]
    ];
}
// --------------------------------------------
// 進位
function roundUp($number, $roundMethod)
{
  $number = formatFloatBasedOnInput($number);
  $lastChar = mb_substr($roundMethod, -1, 1);

  if ($lastChar === '進') {
    if (preg_match('/^\d+/', $roundMethod, $firstChar)) {
      $result =  ceil($number / $firstChar[0]) * $firstChar[0];
    } else {
      $result =  ceil($number);
    }
  } else {
    $firstChar = mb_substr($roundMethod, 0, 1);
    echo $firstChar;

    switch ($firstChar) {
      case '英':
        $result = round($number, 2);
        break;
      case '台':
        $result = $number;
        break;
      case '寸':
        $result = ceil($number / toCustomTaiwaneseFootValue(0.1)) * toCustomTaiwaneseFootValue(0.1);
        break;
      case '二':
        $result = ceil($number / toCustomTaiwaneseFootValue(0.25)) * toCustomTaiwaneseFootValue(0.25);
        break;;
        break;
      case '五':
        $result = ceil($number / toCustomTaiwaneseFootValue(0.5)) * toCustomTaiwaneseFootValue(0.5);
        break;;
        break;
      case 'm':
        $result = round($number, 3);
        break;
      case 'c':
        $result = round($number, 1);
        break;
      default:
        $result = $number;
    }
  }
  return [
    'status_code' => 200,
    'message' => 'Success',
    'data' => [
      'number' => $result,
      'round_method' => $roundMethod,
    ]
  ];
}

// --------------------------------------------
// 材數計算
function calculateArea($length, $width, $unit, $coefficient = UNIT_COEFFICIENT)
{
  switch ($unit) {
    case '台尺':
    case 'tfoot':
      $length = getActualTaiwaneseFoot($length, TAIWANESE_FOOT_MODE);
      $width = getActualTaiwaneseFoot($width, TAIWANESE_FOOT_MODE);
      break;
    case '英吋':
    case 'inch':
      $length = $length / $coefficient[4] * $coefficient[0];
      $width = $width / $coefficient[4] * $coefficient[0];
      // $length = getActualInch($length, INCH_MODE) / $coefficient[4] * $coefficient[0];
      // $width = getActualInch($width, INCH_MODE) / $coefficient[4] * $coefficient[0];
      break;
    case '公分':
    case 'cm':
      $length = $length / $coefficient[6] * $coefficient[0];
      $width = $width / $coefficient[6] * $coefficient[0];
    case '毫米':
    case 'mm':
      $length = $length / $coefficient[5] * $coefficient[0];
      $width = $width / $coefficient[5] * $coefficient[0];

    default:
      break;
  }
  $result = $length * $width;
  return [
    'status_code' => 200,
    'message' => 'Success',
    'data' => [
      'number' => number_format($result, 2),
      'cunit' => '材',
      'length' => number_format($length, 2),
      'width' => number_format($width, 2),
    ]
  ];
}

echo '<pre>';
var_dump(calculateArea(30.24, 15.96, '英吋'));
echo '</pre>';
// 台尺, tfoot, 英吋, inch, 公分, cm, 毫米, mm

echo '<pre>';
var_dump(roundUp(253.12, '12英吋進'));
echo '</pre>';
// 英吋進, 3英吋進, 6英吋進, 12英吋進, 英吋實材, 台尺實材, 寸材, 二寸半材, 五寸材, m2_10.764, m2_10.89, cm2_900, cm2_918

echo '<pre>';
var_dump(convertUnit('tfoot', 100, 'inch'));
echo '</pre>';

echo '<pre>';
var_dump(addPriceUnit(254, 'mm', 1));
echo '</pre>';

// call function
$originalLengthAndWidth = checkIfTwoOrFourValues(5.23, 100, 1000.234, 1);

if (strpos((string)$originalLengthAndWidth['status_code'], '2') === 0) {
  $maxLengthAndWidth = getMaxLengthAndWidth($originalLengthAndWidth['data']);
  echo '<pre>';
  var_dump($originalLengthAndWidth['data']);
  echo '</pre><pre>';
  var_dump($maxLengthAndWidth['data']);
  echo '</pre>';
} else {
  echo 'Error ' . $originalLengthAndWidth['status_code'] . ': ' . $originalLengthAndWidth['message'];
}
