<?php
// object, font, 
require 'vendor/autoload.php';

use PhpOffice\PhpSpreadsheet\Spreadsheet;
// output
use PhpOffice\PhpSpreadsheet\IOFactory;
// contentype\datetime
use PhpOffice\PhpSpreadsheet\Shared\Date;
use PhpOffice\PhpSpreadsheet\Style\NumberFormat;

// object
$spreadsheet = new Spreadsheet();
$activeWorksheet = $spreadsheet->getActiveSheet();
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

// $activeWorksheet->getStyle('A1')->getFont()->setName('標楷體');

// ------------------------------
// content type
$spreadsheet->getActiveSheet()
            ->setCellValue('A1', "String")
            ->setCellValue('B1', "Symbol, UTF-8")
            ->setCellValue('C1', "♀♂⚥ фдаф");

$spreadsheet->getActiveSheet()
            ->setCellValue('A2', "Number")
            ->setCellValue('B2', "Negative")
            ->setCellValue('C2', -55.55);

$spreadsheet->getActiveSheet()
            ->setCellValue('A3', "Boolean")
            ->setCellValue('B3', true)
            ->setCellValue('C3', false);

// 時間
$current_time = time();
// https://phpoffice.github.io/PhpSpreadsheet/classes/PhpOffice-PhpSpreadsheet-Style-NumberFormat.html#method_setFormatCode

$spreadsheet->getActiveSheet()
            ->setCellValue('A4', "Date")
            ->setCellValue('B4', "Date")
            ->setCellValue('C4', Date::PHPToExcel($current_time));
$spreadsheet->getActiveSheet()
            ->getStyle('C4')
            ->getNumberFormat()
            ->setFormatCode(NumberFormat::FORMAT_DATE_YYYYMMDD);

$spreadsheet->getActiveSheet()
            ->setCellValue('A5', "Date")
            ->setCellValue('B5', "Date Time")
            ->setCellValue('C5', Date::PHPToExcel($current_time));
$spreadsheet->getActiveSheet()
            ->getStyle('C5')
            ->getNumberFormat()
            ->setFormatCode(NumberFormat::FORMAT_DATE_DATETIME);

$spreadsheet->getActiveSheet()
            ->setCellValue('A6', "Date")
            ->setCellValue('B6', "Date")
            ->setCellValue('C6', Date::PHPToExcel($current_time));
$spreadsheet->getActiveSheet()
            ->getStyle('C6')
            ->getNumberFormat()
            ->setFormatCode(NumberFormat::FORMAT_DATE_TIME4);

// 顏色, 粗體, 斜體
$spreadsheet->getActiveSheet()
            ->setCellValue('A7', "Rich Text");
use \PhpOffice\PhpSpreadsheet\RichText\RichText;
use \PhpOffice\PhpSpreadsheet\Style\Color;
// $richText = new \PhpOffice\PhpSpreadsheet\RichText\RichText();
$richText = new RichText();
$richText->createText('normal text ');
$payable = $richText->createTextRun('bold, italic, and darkgreen ');
$payable->getFont()->setBold(true);
$payable->getFont()->setItalic(true);
$payable->getFont()->setColor( new Color( Color::COLOR_DARKGREEN ) );
$redText = $richText->createTextRun('red text ');
$redText->getFont()->setColor( new Color( Color::COLOR_RED ) );
$richText->createText('normal text again.');
$spreadsheet->getActiveSheet()->getCell('C7')->setValue($richText);

// 超連結(hover不同vshover同)
$spreadsheet->getActiveSheet()
            ->setCellValue('A8', "Link")
            ->setCellValue('B8', "Cell HyperLink")
            ->setCellValue('C8', "visit phpspreadsheet namespace docs");
$spreadsheet->getActiveSheet()
            ->getCell('C8')
            ->getHyperlink()
            ->setUrl('https://phpoffice.github.io/PhpSpreadsheet/')
            ->setTooltip('To Docs');
            
$spreadsheet->getActiveSheet()
            ->setCellValue('A9', "Link")
            ->setCellValue('B9', "Formula HyperLink")
            ->setCellValue('C9', "=HYPERLINK(\"https://phpoffice.github.io/PhpSpreadsheet/\", \"To Namespace Docs\")");

// ------------------------------
// content
// sheet title資料表標題
$spreadsheet->getActiveSheet()
            ->setTitle('types');
// ------------------------------
// 輸出
$writer = IOFactory::createWriter($spreadsheet, 'Xlsx');
// ------------------------------
// 存擋
$writer->save('./file/hello.xlsx');

// ------------------------------
// 下載
// header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
// header('Content-Disposition: attachment;filename="downloadfile_name.xlsx"');
// header('Cache-Control: max-age=0');
// $writer->save('php://output');
exit;