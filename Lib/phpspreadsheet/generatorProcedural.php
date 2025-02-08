<?php
// 寫在取資料邏輯的directory（store procedure）
function getProductData(mysqli $mysqli, $minId, $maxId) {
    $sql = "SELECT id, name FROM product WHERE id BETWEEN ? AND ?";
    $stmt = mysqli_prepare($mysqli, $sql);
    mysqli_stmt_bind_param($stmt, "ii", $minId, $maxId);
    mysqli_stmt_execute($stmt);
    mysqli_stmt_bind_result($stmt, $id, $name);
    // mysqli_stmt_get_result($stmt); // select *
    while (mysqli_stmt_fetch($stmt)) {
        yield ['id' => $id, 'name' => $name];
    }
    mysqli_stmt_close($stmt);
}

// 寫在config, 執行取資料的地方
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
$mysqli = mysqli_connect("localhost", "root", "", "gachora");

if (mysqli_connect_errno()) {
    die("Connection failed: " . mysqli_connect_error());
}

foreach (getProductData($mysqli, 1, 5) as $product) {
    echo "ID: " . $product['id'] . "\n";
    echo "Name: " . $product['name'] . "\n";
    echo "-------------------------\n";
}

mysqli_close($mysqli);