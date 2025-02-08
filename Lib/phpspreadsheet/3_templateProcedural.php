<?php

use PhpOffice\PhpSpreadsheet\IOFactory;
use PhpOffice\PhpSpreadsheet\Style\Color;
use PhpOffice\PhpSpreadsheet\Style\Conditional;
use PhpOffice\PhpSpreadsheet\Style\Fill;

require 'vendor/autoload.php';

// ------------------------------
// load template
$reader = IOFactory::createReader('Xlsx');
$spreadsheet = $reader->load('./file/template.xlsx');
// content
$contentStartRow;
$currentContentRow;
// connecting mariadb using pdo if !connected exit('database connection failed')
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
require_once './config.php';
$mysqli = mysqli_connect($dbhost, $dbusername, $dbpassword, $dbname);
    
if (mysqli_connect_errno()) {
  die("Connection failed: " . mysqli_connect_error());
}

$query = "SELECT * FROM vw_eggcard WHERE series_id <= ?";
$stmt = mysqli_prepare($mysqli, $query);
$series_id = 7;
mysqli_stmt_bind_param($stmt, "i", $series_id);
mysqli_stmt_execute($stmt);

$result = mysqli_stmt_get_result($stmt);
// mysqli_stmt_bind_result($stmt, $id, $name, $email); // 如果有select col

// while ($row = mysqli_fetch_assoc($result)) {
// 知道col
//   echo $row['id'] . " - " . $row['name'] . "<br>";
// 不知道col
//   foreach ($row as $key => $value) {
//     echo $key . ": " . $value . "<br>";
//   }
//   echo "<hr>"; // 換下一row
// } else {
//   echo mysqli_error($mysqli);
// }

mysqli_stmt_close($stmt);
mysqli_close($mysqli);

$contentStartRow = 3;
$currentContentRow = 3;
foreach ($result as $key => $value) {
    $spreadsheet->getActiveSheet()->insertNewRowBefore($currentContentRow+1, 1);
    $spreadsheet->getActiveSheet()->setCellValue('A'.$currentContentRow, $value['series_id']);
    $spreadsheet->getActiveSheet()->setCellValue('B'.$currentContentRow, $value['theme']);
    $spreadsheet->getActiveSheet()->setCellValue('C'.$currentContentRow, $value['series_title']);
    $spreadsheet->getActiveSheet()->setCellValue('D'.$currentContentRow, $value['name']);
    $spreadsheet->getActiveSheet()->setCellValue('E'.$currentContentRow, $value['price']);
    $spreadsheet->getActiveSheet()->setCellValue('F'.$currentContentRow, $value['amount']);
    $currentContentRow++;
}



// remove last 2 rows
$spreadsheet->getActiveSheet()->removeRow($currentContentRow, 2);

// 客製化 conditional format(設定condition(判斷vs格式), 欄位範圍, 套用格式)
$conditional = new Conditional;
$conditional->setConditionType(Conditional::CONDITION_CELLIS)
  ->setOperatorType(Conditional::OPERATOR_LESSTHANOREQUAL)
  ->addCondition(4);
  $conditional->getStyle()->getFill()->setFillType(Fill::FILL_SOLID)
  ->getEndColor()->setARGB(Color::COLOR_RED);
  $conditional->getStyle()->getFont()->getColor()->setARGB(Color::COLOR_YELLOW);

$contentEndRow = $currentContentRow-1;
$conditionStyles = $spreadsheet->getActiveSheet()
  ->getStyle('F' . $contentStartRow . ':F' . $contentEndRow)
  ->getConditionalStyles();
 
array_push($conditionStyles, $conditional);
$spreadsheet->getActiveSheet()
  ->getStyle('F' . $contentStartRow . ':F' . $contentEndRow)
  ->setConditionalStyles($conditionStyles);

foreach (range('A', 'E') as $column) {
  $spreadsheet->getActiveSheet()->getColumnDimension($column)->setAutoSize(true);
}
// ------------------------------
// 存擋
$writer = IOFactory::createWriter($spreadsheet, 'Xlsx');
$writer->save('./file/usingtemplate.xlsx');
// ------------------------------
// 下載
// header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
// header('Content-Disposition: attachment;filename="downloadfile_name.xlsx"');
// header('Cache-Control: max-age=0');
// $writer = IOFactory::createWriter($spreadsheet, 'Xlsx');
// $writer->save('php://output');
exit;