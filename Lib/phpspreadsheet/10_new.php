<?php
function getExcelColChr($amount) {
  $result = '';
  
  while ($amount >= 0) {
      $result = chr($amount % 26 + 64) . $result; // A是65
      $amount = floor($amount / 26) - 1;
  }
  
  return $result;
}

use PhpOffice\PhpSpreadsheet\IOFactory;
use PhpOffice\PhpSpreadsheet\Style\Border;

require 'vendor/autoload.php';

// ------------------------------
// Initialize spreadsheet
$spreadsheet = new \PhpOffice\PhpSpreadsheet\Spreadsheet();
$sheet = $spreadsheet->getActiveSheet();

// ------------------------------
// Connect to database
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
// Set header row and column titles
$columns = ['series_id', 'theme', 'series_title', 'name', 'price', 'amount'];
$columnCount = count($columns);

// Merge first row for title
$sheet->mergeCells('A1:' . getExcelColChr($columnCount) . '1');
$sheet->setCellValue('A1', 'Eggcard Report');

// Second row for column headers
$sheet->fromArray($columns, null, 'A2');

// ------------------------------
// Add data from query to the sheet
$row = 3;
while ($data = mysqli_fetch_assoc($result)) {
    foreach ($columns as $index => $column) {
        $sheet->setCellValue(getExcelColChr(65 + $index) . $row, $data[$column]);
    }
    $row++;
}

// ------------------------------
// Apply border style to the data range
$highestRow = $row - 1; // 因為row++多一個
$highestColumn = getExcelColChr($columnCount);
$styleArray = [
    'borders' => [
        'allBorders' => [
            'borderStyle' => Border::BORDER_THIN,
            'color' => ['argb' => '000000'],
        ],
    ],
];

// Apply the style to the entire data range
$sheet->getStyle('A2:' . $highestColumn . $highestRow)->applyFromArray($styleArray);

// ------------------------------
// Auto size columns
foreach (range('A', $highestColumn) as $column) {
    $sheet->getColumnDimension($column)->setAutoSize(true);
}

// ------------------------------
// Save file
$writer = IOFactory::createWriter($spreadsheet, 'Xlsx');
$writer->save('./file/usingtemplate.xlsx');

// ------------------------------
// Optionally, download file
// header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
// header('Content-Disposition: attachment;filename="downloadfile_name.xlsx"');
// header('Cache-Control: max-age=0');
// $writer = IOFactory::createWriter($spreadsheet, 'Xlsx');
// $writer->save('php://output');

mysqli_stmt_close($stmt);
mysqli_close($mysqli);
exit;