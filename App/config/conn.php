<?php
require_once 'conn_config.php';
$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
  die("db connection failed: " . $conn->connect_error);
}
?>