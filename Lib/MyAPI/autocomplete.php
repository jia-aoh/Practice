<!DOCTYPE html>
<html lang="zh-TW">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Autocomplete Example</title>

    <!-- jquery導入這3個 -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
    <!-- - -->
</head>

<body>
    <div class="ui-widget">
        <input type="text" id="size">
        <input type="text" id="glass">
        <input type="text" id="work">
    </div>

    <script>
        var datalist = ["11", "12", "13", "14", "15", "16", "17", "18", "19", "110"];
        $("#size").autocomplete({
            source: datalist,
            minLength: 0,
            response: function(event, ui) {
                !ui.content.length && $(this).val('')
            },
        });

        var datalist = ["21", "22", "23", "24", "25", "62", "27", "28", "29", "210", "11", "12", "13", "14", "15", "16", "17", "18", "19", "110"];
        $("#glass").autocomplete({
            source: datalist,
            minLength: 0,
            response: function(event, ui) {
                !ui.content.length && $(this).val('')
            },
        });
    </script>
</body>

</html>