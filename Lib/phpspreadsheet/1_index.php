<!-- 
 template excel 表名 + 欄位名
 -->
<!-- 
使用template 
從第三行開始
-->
<!--
其餘功能:
autofilter
conditional formula
-->

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
</head>
<body>
  <button id="excel">download</button>
  <form action="5_toTCPDF.php" method="POST" target="_blank" enctype="multipart/form-data">
    <input type="file" name="filename">
    <input type="submit" name="pdf_creater" value="toPDF">
  </form>
  
  <script>
    window.onload = function() {
      let redo = false;
      document.getElementById('excel').onclick = function() {
        xhr = downloadExcel();
        // response
        xhr.onload = function() {
          // 如果狀態200就顯示下載成功
          xhr.status == 200 ?
          alert('已下載') :
          alert('下載失敗');
        }
      }
      function downloadExcel(){
        var xhr = new XMLHttpRequest();
        // here
        xhr.open("GET", "./libcopy.php", true);
        xhr.send();
        return xhr;
      }
    }
  </script>
</body>
</html>