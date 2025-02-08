<?php
require 'vendor/autoload.php';

use PhpOffice\PhpSpreadsheet\IOFactory;
use PhpOffice\PhpSpreadsheet\Spreadsheet;

if ($_POST['pdf_creater']=='toPDF' && isset($_FILES)){
  // 读取 Excel 文件
  $inputFileName = $_FILES['filename']['tmp_name']; // 你需要的 Excel 文件路径
  $spreadsheet = IOFactory::load($inputFileName);

  // 使用 TCPDF 写入器将 Excel 转换为 PDF
  $writer = IOFactory::createWriter($spreadsheet, 'TCPDF');

  // 保存 PDF 文件
  $outputFileName = 'excel_to_pdf.pdf'; // 保存的 PDF 文件名
  $writer->save($outputFileName);

  echo "Excel file has been successfully converted to PDF.";
  exit;

}else{
  echo "nothing";
  exit;
}