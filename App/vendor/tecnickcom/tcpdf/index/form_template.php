<?php
//============================================================+
// File name   : form_template.php
// Begin       : 2025-01-06
// Last Update : 2025-01-06
//
// Description : pdf template
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

class PDF_Template extends TCPDF {
  
  function generate_pdf_table($json, $form_name, $size){

    $data = json_decode($json);

    if (empty($data) || !is_array($data)) return;

    $this->SetFont('Times', 'BIU', 20);
    $this->Cell('', '', $title, 1, 1, 'C');

    $ths = array_keys((array)$data[0]);
    $this->SetFont('Times', 'B', 16);
    foreach ($ths as $index => $th) {
        $this->Cell($size[$index], 10, $th, 1, 0, 'C');
    }
    $this->Ln();

    $this->SetFont('Times', '', 14);
    foreach ($data as $user) {
        foreach ($ths as $index => $th) {
            $this->Cell($size[$index], '', $user->$th, 1, 0, 'C');
        }
        $this->Ln();
    }
  }

}