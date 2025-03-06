<?php
// 資料庫連接設定
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "school";  // 假設您的資料庫名稱是 school

// 建立資料庫連接
$conn = new mysqli($servername, $username, $password, $dbname);

// 檢查連接
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// 查詢學生資料
$sql = "SELECT student_id, name, age, gender, address, phone, email FROM students";
$result = $conn->query($sql);

$students = [];
if ($result->num_rows > 0) {
    // 將查詢結果轉換成陣列
    while($row = $result->fetch_assoc()) {
        $students[] = $row;
    }
} else {
    echo "沒有資料";
}

$conn->close();

try {
    // 啟動 Bartender 應用程式
    $btApp = new COM("BarTender.Application") or die("Bartender ActiveX 物件未能加載");

    // 設定為不顯示 Bartender 主畫面
    $btApp->Visible = false;

    // 打開標籤模板（.btw）
    $btFormat = $btApp->Forms->Open('C:\\path\\to\\your\\label_template.btw'); // 修改為您的 Bartender 標籤模板路徑

    // 迴圈處理每個學生資料
    foreach ($students as $student) {
        // 設置資料源，這裡直接在 PHP 中設置每個學生的資料
        $btFormat->SetDataSource([
            'student_id' => $student['student_id'],
            'name' => $student['name'],
            'age' => $student['age'],
            'gender' => $student['gender'],
            'address' => $student['address'],
            'phone' => $student['phone'],
            'email' => $student['email'],
        ]);

        // 開始列印每一個學生資料對應的標籤
        $btFormat->PrintOut();
    }

    // 關閉 Bartender 應用程式
    $btApp->Quit();

    echo "批次列印完成！";
} catch (Exception $e) {
    echo "錯誤：", $e->getMessage();
}
?>
