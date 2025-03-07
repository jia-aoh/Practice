<?php
//============================================================+
// File name   : myTcpdf_1.php
// Begin       : 2025-01-06
// Last Update : 2025-01-06
//
// Description : Include -> Object -> Page -> Content -> Output
//
// Author: XX
//
// (c) Copyright:
//               XX
//               XX.com LTD
//               www.XX.com
//               info@XX.com
//============================================================+

/**
 * Creates an example PDF TEST document using TCPDF
 * @package com.tecnick.tcpdf
 * @abstract TCPDF - Example: WriteHTML and RTL support
 * @author Nicola Asuni
 * @since 2008-03-04
 */
// include
require_once(realpath('../tcpdf.php'));

// new TCPDF object
// $pdf = new TCPDF(PDF_PAGE_ORIENTATION, PDF_UNIT, PDF_PAGE_FORMAT, true, 'UTF-8', false);
$pdf = new TCPDF('p', 'mm', 'A4');

// Default Header Footer <hr>
$pdf->setPrintHeader(false);
$pdf->setPrintFooter(false);

// add page
$pdf->AddPage();

// add content

  // 效能好 ----------------------------------------
  // $pdf->SetFont($family, $style = '', $size = 12);
  // $pdf->SetFont('Times, Helvetica, Arial', 'BIU', 20);
  // $pdf->Cell($w, $h, $txt, $border(1|0), $ln(1|0), $align=''|'LCR');
  $pdf->SetFont('Times', 'BIU', 20);
  $pdf->Cell('', '', 'User Form', 1, 1, 'C');

  // $pdf->Ln($px = $size);
  // $pdf->Ln();

  $pdf->SetFont('Times', 'B', 16);
  $pdf->Cell(20, '', 'Id', 1, 0, 'C');
  $pdf->Cell(25, '', 'Name', 1, 0, 'C');
  $pdf->Cell(30, '', 'Gender', 1, 0, 'C');
  $pdf->Cell('', '', 'Email', 1, 1, 'C');
  
  $json = file_get_contents("MOCK_DATA.json");
  $data = json_decode($json);
  
  $pdf->SetFont('Times', '', 14);
  foreach($data as $user){
    $pdf->Cell(20, '', $user->id, 1, 0, 'C');
    $pdf->Cell(25, '', $user->name, 1, 0, 'C');
    $pdf->Cell(30, '', $user->gender, 1, 0, 'C');
    $pdf->Cell('', '', $user->email, 1, 1, 'C');
  }

  

  /*
  // 效能差 ----------------------------------------
  // $html = "<h1>brad company</h1>";
  $html = "
  <style>
    table {
      border-collapse: collapse;
    }
    th, td { 
      border: 1px solid black;
    }
    table tr th {
      background-color: #888;
      color: #fff;
      font-weight: bold;
    }
  </style>
  <table>
    <tr>
      <th>title</th>
      <th>title</th>
    </tr>
    <tr>
      <td>content</td>
      <td>content</td>
    </tr>
  </table>";
  // $pdf->writeHTMLCell($w, $h, $x, $y, $html, $border, $ln, $fill, $reseth=true, $align='', $autopadding=true);
  // $pdf->writeHTMLCell('', '', '', '', $html, 'TBLR', 1, 0, false, 'LCR', true);
  // $pdf->writeHTMLCell('', '', '', '', $html, 'TBLR', 1, 0, false, 'C', true);
  $pdf->writeHTMLCell(192, 0, 9, '', $html, 0, 1); // for table collapse
  */

// output
$pdf->Output();
//============================================================+
// END OF FILE
//============================================================+
