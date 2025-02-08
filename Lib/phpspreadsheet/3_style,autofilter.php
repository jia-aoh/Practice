<?php
// object, 
// defaultfont(stype, size),
// Heading表名(text, merge, size, alignment), 
// Header欄位標題
require 'vendor/autoload.php';

use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\IOFactory;

// object
$spreadsheet = new Spreadsheet();
// ------------------------------
// font
$spreadsheet->getDefaultStyle()
->getFont()
->setName('Arial')
->setSize(10);
// ------------------------------
// column width 寬
$spreadsheet->getActiveSheet()->getColumnDimension('A')->setWidth(6);
$spreadsheet->getActiveSheet()->getColumnDimension('B')->setAutoSize(true);
$spreadsheet->getActiveSheet()->getColumnDimension('C')->setAutoSize(true);
$spreadsheet->getActiveSheet()->getColumnDimension('D')->setAutoSize(true);
$spreadsheet->getActiveSheet()->getColumnDimension('E')->setAutoSize(true);
$spreadsheet->getActiveSheet()->getColumnDimension('F')->setAutoSize(true);

// $activeWorksheet->getStyle('A1')->getFont()->setName('標楷體');

// ------------------------------
// 表名 heading (text, merge, size, alignment置中)
$spreadsheet->getActiveSheet()->setCellValue('A1', "Students");
$spreadsheet->getActiveSheet()->mergeCells('A1:F1');

use PhpOffice\PhpSpreadsheet\Style\Alignment;
$spreadsheet->getActiveSheet()->getStyle('A1')->getFont()->setName('標楷體');
$spreadsheet->getActiveSheet()->getStyle('A1')->getFont()->setSize(20);
$spreadsheet->getActiveSheet()->getStyle('A1')->getAlignment()->setHorizontal(Alignment::HORIZONTAL_CENTER);

// 欄位標題 (text, font(size, bold, bg_array))
$spreadsheet->getActiveSheet()
  ->setCellValue('A2', "ID")
  ->setCellValue('B2', "名")
  ->setCellValue('C2', "姓")
  ->setCellValue('D2', "郵箱")
  ->setCellValue('E2', "性")
  ->setCellValue('F2', "國家");

use \PhpOffice\PhpSpreadsheet\Style\Fill;
$row_style_head = [
  'font'=>[
    'color'=>[
      'rgb'=>'FFFFFF',
    ],
    'bold'=>true, // $spreadsheet->getActiveSheet()->getStyle('A2:F2')->getFont()->setSize(12);
    'size'=>12, // $spreadsheet->getActiveSheet()->getStyle('A2:F2')->getFont()->setBold(true);
  ],
  'fill'=>[
    'fillType'=>Fill::FILL_SOLID,
    'startColor'=>[
      'rgb'=>'538ED5',
    ],
  ],
];
$spreadsheet->getActiveSheet()->getStyle('A2:F2')->applyFromArray($row_style_head);
// 奇偶欄顏色
$row_style_even = [
  'fill'=>[
    'fillType'=>Fill::FILL_SOLID,
    'startColor'=>[
      'rgb'=>'00BDFF',
    ],
  ],
];
$row_style_odd = [
  'fill'=>[
    'fillType'=>Fill::FILL_SOLID,
    'startColor'=>[
      'rgb'=>'00EAFF',
    ],
  ],
];
$file = file_get_contents('students.json');
$studentData = json_decode($file, true);
$row = 3;
foreach ($studentData as $student) {
  $spreadsheet->getActiveSheet()->setCellValue('A' . $row, $student['id']);
  $spreadsheet->getActiveSheet()->setCellValue('B' . $row, $student['first_name']);
  $spreadsheet->getActiveSheet()->setCellValue('C' . $row, $student['last_name']);
  $spreadsheet->getActiveSheet()->setCellValue('D' . $row, $student['email']);
  $spreadsheet->getActiveSheet()->setCellValue('E' . $row, $student['gender']);
  $spreadsheet->getActiveSheet()->setCellValue('F' . $row, $student['country']);
  if ($row % 2 == 0) {
    $spreadsheet->getActiveSheet()->getStyle('A' . $row . ':F' . $row)->applyFromArray($row_style_even);
  } else {
    $spreadsheet->getActiveSheet()->getStyle('A' . $row . ':F' . $row)->applyFromArray($row_style_odd);
  }
  $row++;
}
// AUtoFIlter(定義表範圍)
$firstRow = 2; // header
$lastRow = $row-1; // 扣掉最後一次++
$spreadsheet->getActiveSheet()->setAutoFilter("A{$firstRow}:F{$lastRow}");
// ------------------------------
// sheet name資料表標題
$spreadsheet->getActiveSheet()
  ->setTitle('student info');
// ------------------------------
// 輸出
$writer = IOFactory::createWriter($spreadsheet, 'Xlsx');
// ------------------------------
// 存擋
$writer->save('./file/student.xlsx');

// ------------------------------
// 下載
// header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
// header('Content-Disposition: attachment;filename="downloadfile_name.xlsx"');
// header('Cache-Control: max-age=0');
// $writer->save('php://output');
exit;