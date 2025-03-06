<?php
$host = ""; 
$dbname = ""; 
$username = ""; 
$password = ""; 

$connection = mysqli_connect($host, $username, $password, $dbname);

if (!$connection) {
    die("Connection failed: " . mysqli_connect_error());
}

$query = "SELECT * FROM students";
$result = mysqli_query($connection, $query);

// 檢查是否有資料
if (mysqli_num_rows($result) > 0) {
    $xml = new SimpleXMLElement('<students/>');

    while ($student = mysqli_fetch_assoc($result)) {
        $studentElement = $xml->addChild('student');
        $studentElement->addChild('student_id', $student['student_id']);
        $studentElement->addChild('name', $student['name']);
        $studentElement->addChild('age', $student['age']);
        $studentElement->addChild('gender', $student['gender']);
        $studentElement->addChild('address', $student['address']);
        $studentElement->addChild('phone', $student['phone']);
        $studentElement->addChild('email', $student['email']);
    }

    $xml->asXML('students.xml');
    echo "XML 檔案生成成功!";
} else {
    echo "沒有資料可以生成 XML";
}

mysqli_close($connection);
?>

