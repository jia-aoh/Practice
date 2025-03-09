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
<input type="submit" id="xx">

  <script src="../src/js/table.js"></script>
  <script>
    jsonData = [
      { "name": "John", "age": 30, "city": "New York" },
      { "name": "Jane", "age": 25, "city": "London" },
      { "name": "Bob", "age": 40, "city": "Paris" },
      { "name": "Alice", "age": 35, "city": "Tokyo" }
    ];
    let answer = '';
    // window.onload = csv_easy_table('GET', '../model/csv_easy_table.php', '#easy_table');
    window.onload = jsonToTable(
      'easy_table', 
      {
        'name': '姓名',
        'age': '年齡',
        'city': '城市'
      }, jsonData)
    checkboxForTable('easy_table');
    document.getElementById('xx').onclick = () => {
      answer = answerOfTable('easy_table');
      console.log(answer);
    } 
  </script>

</body>

</html>