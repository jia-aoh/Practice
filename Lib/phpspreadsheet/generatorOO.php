<?php
// 寫在取資料邏輯的directory（store procedure）
function getProductsData(mysqli $mysqli, $minId, $maxId) {
    $sql = "SELECT id, name FROM products WHERE id BETWEEN ? AND ?";
    $stmt = $mysqli->prepare($sql);
    $stmt->bind_param("ii", $minId, $maxId);
    $stmt->execute();
    $stmt->bind_result($id, $name);
    // $stmt->get_result(); // select *

    while ($stmt->fetch()) {
        yield ['id' => $id, 'name' => $name];
    }

    $stmt->close();
}

// 寫在config, 執行取資料的地方
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
$mysqli = new mysqli("localhost", "root", "", "gachora");

if ($mysqli->connect_error) {
    die("Connection failed: " . $mysqli->connect_error);
}

foreach (getProductsData($mysqli, 1, 5) as $products) {
    echo "ID: " . $products['id'] . "\n";
    echo "Name: " . $products['name'] . "\n";
    echo "-------------------------\n";
}

$mysqli->close();
