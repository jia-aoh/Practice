<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
</head>

<body>
  <!-- 用法 -->
  <script type="module">
    import { ajax } from './ajax.js';

    const { get, post } = ajax;

    get('http://localhost:8000/Lib/MyAPI/test_frontajax.php', {
        key1: ['ok', 2, 3],
        key2: 'place',
      })
      .then(response => {
        console.log('get 1:', response.php);
      })
      .catch(error => {
        console.log('get 2:', error);
      });

    post('http://localhost:8000/Lib/MyAPI/test_frontajax.php', {
        key1: ['apple', 'banna'],
        key2: '4',
      })
      .then(response => {
        console.log('post 1:', response.php);
      })
      .catch(error => {
        console.log('post 2:', error);
      });
  </script>
</body>

</html>




幫我生成一段javascript代碼並export成一個工具包
一個input 當我focus時 按下alt+2及彈出一個dialog
Dialog 必須按esc或關閉扭才能離開 dialog內也有兩個inpit在同一行 並且可以在css調整他的大小 當我onfocus在dialog內的inpit 再按下alt+2 依然可以再彈出一個dialog 一個比一個zindex都再高一點，以確保最新的dialog在最上層 esc也是將他一層一層關掉

做autocomplete, dump, dialog,tab自動選到另一個沒隱藏的select checkbox inpit，返回鍵

我想設計一個方便key數據的表格 按tab或enter直接跳到另一個非隱藏的input 或 select 或 checkbox 按下 是將select展開 input 用datalist 一樣按下展開所有擁有的datalist checkbox 按v打勾再按一次取消打勾 返回上一個輸入格請你幫我選一個適當的按鍵 幫我把以上需求寫成程式碼 Javascript and php

<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>數據輸入表格</title>
    <style>
        table { border-collapse: collapse; width: 100%; }
        td, th { border: 1px solid #ddd; padding: 8px; text-align: left; }
        input, select { width: 100%; padding: 5px; }
    </style>
</head>
<body>

<h2>數據輸入表格</h2>
<form action="submit.php" method="post">
    <table>
        <tr>
            <th>名稱</th>
            <th>數值</th>
            <th>類別</th>
            <th>確認</th>
        </tr>
        <tr>
            <td><input type="text" name="name1" class="form-input" list="name-list"></td>
            <td><input type="number" name="value1" class="form-input"></td>
            <td>
                <select name="category1" class="form-input">
                    <option value="">請選擇</option>
                    <option value="A">A類</option>
                    <option value="B">B類</option>
                    <option value="C">C類</option>
                </select>
            </td>
            <td><input type="checkbox" name="confirm1" class="form-checkbox"></td>
        </tr>
        <tr>
            <td><input type="text" name="name2" class="form-input" list="name-list"></td>
            <td><input type="number" name="value2" class="form-input"></td>
            <td>
                <select name="category2" class="form-input">
                    <option value="">請選擇</option>
                    <option value="A">A類</option>
                    <option value="B">B類</option>
                    <option value="C">C類</option>
                </select>
            </td>
            <td><input type="checkbox" name="confirm2" class="form-checkbox"></td>
        </tr>
    </table>
    <button type="submit">提交</button>
</form>

<!-- DataList 用於 AutoComplete -->
<datalist id="name-list">
    <option value="項目1"></option>
    <option value="項目2"></option>
    <option value="項目3"></option>
</datalist>

<script>
document.addEventListener("DOMContentLoaded", function() {
    let inputs = Array.from(document.querySelectorAll(".form-input, .form-checkbox"));
    
    document.addEventListener("keydown", function(event) {
        let activeElement = document.activeElement;
        let currentIndex = inputs.indexOf(activeElement);

        if (event.key === "Tab" || event.key === "Enter") {
            event.preventDefault(); 
            let nextIndex = (event.shiftKey) ? currentIndex - 1 : currentIndex + 1;
            focusNextInput(nextIndex);
        } else if (event.key.toLowerCase() === "v" && activeElement.classList.contains("form-checkbox")) {
            activeElement.checked = !activeElement.checked;
        } else if (event.key === "ArrowDown" || event.key === "Enter") {
            if (activeElement.tagName === "SELECT") {
                activeElement.size = activeElement.options.length;
                activeElement.addEventListener("blur", () => activeElement.size = 1, { once: true });
            } else if (activeElement.tagName === "INPUT" && activeElement.getAttribute("list")) {
                activeElement.focus();
            }
        }
    });

    function focusNextInput(index) {
        if (index >= 0 && index < inputs.length) {
            let nextElement = inputs[index];
            if (!nextElement.hidden) {
                nextElement.focus();
                if (nextElement.tagName === "SELECT") nextElement.size = 1; 
            }
        }
    }
});
</script>

</body>
</html>

幫我基於datalist 寫一個autocomplete 的function 並需要留一個接口能傳入datalist所需的資料 並且當使用者按確定 能夠讀到他的數值
