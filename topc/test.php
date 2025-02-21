<?php
// define
define('EDGE_PROCESS_MODE', 'N'); // Normal(正常2長2短), Custom(客製化型)
define('TAIWANESE_FOOT_MODE', 'A'); // Actual(實際台尺), Hundred(/百 台尺)
define('INCH_MODE', 'O'); // Decimal(10進位英吋), Octal(8進位英吋)

$originalLengthAndWidth = [];
$maxLengthAndWidth = [];
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
      'message' => 'Success.',
      'data' => [$length_1st > $length_2nd ? formatFloatBasedOnInput($length_1st) : formatFloatBasedOnInput($length_2nd), 
                $length_1st < $length_2nd ? formatFloatBasedOnInput($length_1st) : formatFloatBasedOnInput($length_2nd)]
    ];
    exit;
  }
  // condition 4 values
  if ($length_1st !== 0 && $length_2nd !== 0 && $width_1st !== 0 && $width_2nd !== 0) {
    $length_sorted = $length_1st > $length_2nd ? [formatFloatBasedOnInput($length_1st), formatFloatBasedOnInput($length_2nd)] : [formatFloatBasedOnInput($length_2nd), formatFloatBasedOnInput($length_1st)];
    $width_sorted = $width_1st > $width_2nd ? [formatFloatBasedOnInput($width_1st), formatFloatBasedOnInput($width_2nd)] : [formatFloatBasedOnInput($width_2nd), formatFloatBasedOnInput($width_1st)];
    return [
      'status_code' => 200,
      'message' => 'Success.',
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
  if ($mode === 'N') { // normal mode: LLWW
    if (count($input_array) == 2) {
      return [
        'status_code' => 200,
        'message' => 'Success.',
        'data' => $input_array,
      ];
    }
    if (count($input_array) == 4) {
      return [
        'status_code' => 200,
        'message' => 'Success.',
        'data' => [$input_array[0], $input_array[2]],
      ];
    }
  }

  if ($mode === 'C') { // custom mode
    return [
      'status_code' => 200,
      'message' => 'Success.',
      'data' => $input_array,
    ];
  }

  return [
    'status_code' => 400,
    'message' => 'Error in getMaxLengthAndWidth($input_array, $mode = "N").',
  ];
}
// ------------------------------------------------------------
// 取得使用者輸入小數位數（解決小數點binary問題）
function getInputDecimal($number) {
  $numberChunks = explode('.', (string)$number);
  if (count($numberChunks) == 2) {
      return strlen($numberChunks[1]);
  }
  return 0;
}

// Float精度重編
function formatFloatBasedOnInput($number) {
  $decimalPlaces = getInputDecimal($number);
  return number_format($number, $decimalPlaces, '.', '');
}
// -----------------------------------------
// 單位mode


// call function
$originalLengthAndWidth = checkIfTwoOrFourValues(6.6, 100);

if (strpos((string)$originalLengthAndWidth['status_code'], '2') === 0) {
  $maxLengthAndWidth = getMaxLengthAndWidth($originalLengthAndWidth['data']);
  var_dump($maxLengthAndWidth);
} else {
  echo 'Error ' . $originalLengthAndWidth['status_code'] . ': ' . $originalLengthAndWidth['message'];
}
