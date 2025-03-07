<?php
//============================================================+
// File name   : myTcpdf_2.php
// Begin       : 2025-01-06
// Last Update : 2025-01-06
//
// Description : Using template
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
require_once('form_template.php');

$pdf = new PDF_Template('P', 'mm', 'A4');
$pdf->setPrintHeader(false);
$pdf->setPrintFooter(false);
$pdf->AddPage();

$form_name = 'User Form';
$json = file_get_contents("MOCK_DATA.json");
$size = [20, 25, 115, 30];
$pdf->generate_pdf_table($json, $form_name, $size);

// output
$pdf->Output();
//============================================================+
// END OF FILE
//============================================================+
