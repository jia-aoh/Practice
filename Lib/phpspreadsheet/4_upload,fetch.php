<?php

require 'vendor/autoload.php';

use PhpOffice\PhpSpreadsheet\IOFactory;

if(empty($_FILES)){
  echo "
  <form method='post' enctype='multipart/form-data' action='4_upload,fetch.php'>
    <input type='file' name='excel'>
    <br>
    <button type='submit'>see on browser</button>
  </form>
";
} else {
  // ------------------------------
  // load template
  $reader = IOFactory::createReader('Xlsx');
  // content
  $spreadsheet = $reader->load($_FILES['excel']['tmp_name']); // $spreadsheet = $reader->load('./file/usingtemplate.xlsx');
  // $spreadsheet->setActiveSheetIndex(0); // 設定第一個工作表為活躍工作表
  // $spreadsheet->setActiveSheetIndexByName('工作表名稱'); // 設定指定名稱的工作表為活躍工作表

  echo "<table border = 1>";
  // print to html table
  $dataStartRow = 3;
  $i = $dataStartRow;
  while($spreadsheet->getActiveSheet()->getCell('A' . $i-1)->getValue()!=''){
    $id     = $spreadsheet->getActiveSheet()->getCell('A'.$i-1)->getValue();
    $theme  = $spreadsheet->getActiveSheet()->getCell('B'.$i-1)->getValue();
    $title  = $spreadsheet->getActiveSheet()->getCell('C'.$i-1)->getValue();
    $name   = $spreadsheet->getActiveSheet()->getCell('D'.$i-1)->getValue();
    $price  = $spreadsheet->getActiveSheet()->getCell('E'.$i-1)->getValue();
    $amount = $spreadsheet->getActiveSheet()->getCell('F'.$i-1)->getValue();

    echo "
      <tr>
        <td>{$id}</td>
        <td>{$theme}</td>
        <td>{$title}</td>
        <td>{$name}</td>
        <td>{$price}</td>
        <td>{$amount}</td>
      </tr>
    ";

    $i++;
  }
  echo "</table>";
}