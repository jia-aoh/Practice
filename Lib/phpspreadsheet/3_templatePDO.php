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
try {
    require_once './config.php';
    $pdo = new PDO($dsn, $dbusername, $dbpassword);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $pdo->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
    
    $sql = 'select * from vw_eggcard order by series_id desc limit 0, 10';
    $stmt = $pdo->prepare($sql);
    $stmt->execute();
    $result = $stmt->fetchAll(); 
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
    $pdo = null;
} catch (PDOException $e) {
    die('database connection failed' . $e->getMessage());
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