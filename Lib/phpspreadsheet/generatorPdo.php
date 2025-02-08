<?php
// 寫在取資料邏輯的directory（store procedure）
function getProductData(PDO $pdo, $minId, $maxId) {
    $sql = "SELECT id, name FROM product WHERE id BETWEEN :minId AND :maxId";
    $stmt = $pdo->prepare($sql);
    $stmt->bindParam(':minId', $minId, PDO::PARAM_INT);
    $stmt->bindParam(':maxId', $maxId, PDO::PARAM_INT);
    $stmt->execute();

    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        yield $row;
    }
}

// 寫在config, 執行取資料的地方
try {
    $pdo = new PDO("mysql:host=localhost;dbname=gachora", "root", "");
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    foreach (getProductData($pdo, 1, 5) as $product) {
        echo "ID: " . $product['id'] . "\n";
        echo "Name: " . $product['name'] . "\n";
        echo "-------------------------\n";
    }

} catch (PDOException $e) {
    echo "Connection failed: " . $e->getMessage();
}

$pdo = null;