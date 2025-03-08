<?php
require __DIR__ . '/../vendor/autoload.php';
?>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>csv</title>
  <style>
    table {
      border-collapse: collapse;
    }
    table td{
      border: 1px solid black;
    }
  </style>
</head>

<body>
<div id="easy_table"></div>

  <script src="../src/js/csv1.js"></script>
  <script>
    window.onload = csv_easy_table('GET', '../model/csv_easy_table.php', '#easy_table');
  </script>

</body>

</html>