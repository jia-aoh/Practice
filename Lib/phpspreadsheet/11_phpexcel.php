<?php
function getExcelColChr($amount) {
  $result = '';
  
  while ($amount >= 0) {
      $result = chr($amount % 26 + 64) . $result; // A is 65
      $amount = floor($amount / 26) - 1;
  }
  
  return $result;
}

require 'vendor/autoload.php';

// ------------------------------
$objPHPExcel = new PHPExcel();
$sheet = $objPHPExcel->getActiveSheet();

// ------------------------------
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
require_once './config.php';
$mysqli = mysqli_connect($dbhost, $dbusername, $dbpassword, $dbname);
    
if (mysqli_connect_errno()) {
  die("Connection failed: " . mysqli_connect_error());
}

// Query data-------------------------------------
$query = "SELECT * FROM vw_eggcard WHERE series_id <= ?";
$stmt = mysqli_prepare($mysqli, $query);
$series_id = 7;
mysqli_stmt_bind_param($stmt, "i", $series_id);
mysqli_stmt_execute($stmt);
$result = mysqli_stmt_get_result($stmt);

// ------------------------------
// Header
$columns = ['series_id', 'theme', 'series_title', 'name', 'price', 'amount'];
$columnCount = count($columns);

// Merge first title row
$sheet->mergeCells('A1:' . getExcelColChr($columnCount) . '1');
$sheet->setCellValue('A1', 'Eggcard Report');

// Second row for column headers
$sheet->fromArray($columns, null, 'A2');

// ------------------------------
// Add data from query to the sheet
$row = 3;
while ($data = mysqli_fetch_assoc($result)) {
    foreach ($columns as $index => $column) {
        $sheet->setCellValue(getExcelColChr($index) . $row, $data[$column]);
    }
    $row++;
}

// ------------------------------
// Apply border style to the data range
$highestRow = $row - 1; // because row++ adds one extra row
$highestColumn = getExcelColChr($columnCount);

$styleArray = array(
    'borders' => array(
        'allborders' => array(
            'style' => PHPExcel_Style_Border::BORDER_THIN,
            'color' => array('argb' => '000000'),
        ),
    ),
);

// Apply the style to the entire data range
$sheet->getStyle('A2:' . $highestColumn . $highestRow)->applyFromArray($styleArray);

// ------------------------------
// Auto size columns
foreach (range('A', getExcelColChr($columnCount)) as $column) {
    $sheet->getColumnDimension($column)->setAutoSize(true);
}

// ------------------------------
// Save file
$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
$objWriter->save('./file/usingtemplate.xlsx');

// ------------------------------
// Optionally, download file
// header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
// header('Content-Disposition: attachment;filename="downloadfile_name.xlsx"');
// header('Cache-Control: max-age=0');
// $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
// $objWriter->save('php://output');

mysqli_stmt_close($stmt);
mysqli_close($mysqli);
exit;
