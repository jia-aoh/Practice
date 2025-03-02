<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
</head>
<body>
  <input id="linepost" type="text" placeholder="message">
  <button id="send">send</button>

  <script type="module">
    import { ajax } from '../Lib/MyAPI/ajax.js';

    const { get, post } = ajax;

    const linepost = document.getElementById('linepost');

    const send = document.getElementById('send');

    send.addEventListener('click', () => {
      post('http://localhost:8000/line/apitest/push.php', {
        message: linepost.value
      })
      .then(response => {
        console.log('get ok:', response);
      })
      .catch(error => {
        console.log('get error:', error);
      });
    });

  </script>
</body>

</html>