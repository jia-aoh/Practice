<?php
require_once('tcpdf.php');

// 创建 PDF 实例
$pdf = new TCPDF();
$pdf->AddPage();

// 假设数据结构如下：
$data = [
    ['company' => 'A', 'sales' => 100, 'orders' => 10, 'profit' => 50, 'cost' => 30, 'tax' => 10],
    ['company' => 'A', 'sales' => 100, 'orders' => 10, 'profit' => 50, 'cost' => 30, 'tax' => 10],
    ['company' => 'A', 'sales' => 100, 'orders' => 10, 'profit' => 50, 'cost' => 30, 'tax' => 10],
    ['company' => 'A', 'sales' => 120, 'orders' => 12, 'profit' => 60, 'cost' => 35, 'tax' => 15],
    ['company' => 'B', 'sales' => 200, 'orders' => 20, 'profit' => 100, 'cost' => 50, 'tax' => 20],
    ['company' => 'B', 'sales' => 180, 'orders' => 18, 'profit' => 90, 'cost' => 45, 'tax' => 18],
];

$current_company = '';
$sums = [0, 0, 0, 0, 0]; // 用来存储小计的合计值

// 表格的头部
$pdf->SetFont('times', 'B', 14);
$pdf->Cell(30, 10, 'name', 1, 0, 'C');
$pdf->Cell(30, 10, 'price', 1, 0, 'C');
$pdf->Cell(30, 10, 'amount', 1, 0, 'C');
$pdf->Cell(30, 10, 'profit', 1, 0, 'C');
$pdf->Cell(30, 10, 'cost', 1, 0, 'C');
$pdf->Cell(30, 10, 'tax', 1, 0, 'C');
$pdf->Ln();

// 设置普通行的字体
$pdf->SetFont('times', 'B', 14);

// 遍历数据
foreach ($data as $row) {
    if ($row['company'] !== $current_company) {
        // 如果是新的公司，插入“小計”行并计算合计值
        if ($current_company !== '') { // 防第一行
            $pdf->SetFont('times', 'B', 14);
            $pdf->Cell(30, 10, 'total', 1, 0, 'C');

            // 遍利後五格
            foreach ($sums as $sum) {
                $pdf->Cell(30, 10, $sum, 1, 0, 'C');
            }
            $pdf->Ln();

            $sums = [0, 0, 0, 0, 0];
        }


        // 更新当前公司
        $current_company = $row['company'];
    }

    $pdf->SetFont('times', 'B', 14);
    $pdf->Cell(30, 10, $row['company'], 1, 0, 'C'); 
    $pdf->Cell(30, 10, $row['sales'], 1, 0, 'C');
    $pdf->Cell(30, 10, $row['orders'], 1, 0, 'C');
    $pdf->Cell(30, 10, $row['profit'], 1, 0, 'C');
    $pdf->Cell(30, 10, $row['cost'], 1, 0, 'C');
    $pdf->Cell(30, 10, $row['tax'], 1, 0, 'C');
    $pdf->Ln();

    // 加總
    $sums[0] += $row['sales'];
    $sums[1] += $row['orders'];
    $sums[2] += $row['profit'];
    $sums[3] += $row['cost'];
    $sums[4] += $row['tax'];
}

// 输出最后一个公司的小计行
$pdf->SetFont('times', 'B', 14);
$pdf->Cell(30, 10, 'total', 1, 0, 'C');
foreach ($sums as $sum) {
    $pdf->Cell(30, 10, $sum, 1, 0, 'C');
}
$pdf->SetLineWidth(0.5);
$pdf->Ln(); // 输出最后的小计行


// 结束生成 PDF
$pdf->Output();
