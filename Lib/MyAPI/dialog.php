<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>dialog</title>
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
  <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
</head>
<style>

  input {
    display: block;
  }

  input.text {
    margin-bottom: 12px;
    width: 95%;
    padding: .4em;
  }

  fieldset {
    padding: 0;
    border: 0;
    margin-top: 25px;
  }

  h1 {
    font-size: 1.2em;
    margin: .6em 0;
  }

  div#users-contain {
    width: 350px;
    margin: 20px 0;
  }

  div#users-contain table {
    margin: 1em 0;
    border-collapse: collapse;
    width: 100%;
  }

  div#users-contain table td,
  div#users-contain table th {
    border: 1px solid #eee;
    padding: .6em 10px;
    text-align: left;
  }

  .ui-dialog .ui-state-error {
    padding: .3em;
  }

  .validateTips {
    /* border: 1px solid transparent; */
    padding: 0em;
  }
</style>

<body>
  <div id="dialog-form" title="Dialog Title">
    <p class="validateTips">content...</p>

    <!-- dialog -->
    <form>
      <fieldset>
        <input type="text" name="name" id="name" value="" class="text ui-widget-content ui-corner-all" placeholder="Name">
        <input type="text" name="email" id="email" value="" class="text ui-widget-content ui-corner-all" placeholder="Email">
        <input type="password" name="password" id="password" value="" class="text ui-widget-content ui-corner-all" placeholder="Password">
        <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
      </fieldset>
    </form>
  </div>

  <!-- 主畫面 -->
  <div id="users-contain" class="ui-widget">

    <table id="users" class="ui-widget ui-widget-content">

      <thead>
        <tr class="ui-widget-header ">
          <th>Name</th>
          <th>Email</th>
          <th>Password</th>
        </tr>
      </thead>

      <tbody></tbody>

    </table>

  </div>

  <button id="open_dialog">Add</button>
  <script>
    $(() => {
      $(() => {
        var dialog, form,

          emailRegex = /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/,
          name = $("#name"),
          email = $("#email"),
          password = $("#password"),
          allFields = $([]).add(name).add(email).add(password),
          tips = $(".validateTips");

        // 驗證警示
        function updateTips(t) {
          tips
            .text(t)
            .addClass("ui-state-highlight");
          setTimeout(() => {
            tips.removeClass("ui-state-highlight", 1500);
          }, 500);
        }

        function checkLength(o, n, min, max) {
          if (o.val().length > max || o.val().length < min) {
            o.addClass("ui-state-error");
            updateTips("Length of " + n + " must be between " +
              min + " and " + max + ".");
            return false;
          } else {
            return true;
          }
        }

        function checkRegexp(o, regexp, n) {
          if (!(regexp.test(o.val()))) {
            o.addClass("ui-state-error");
            updateTips(n);
            return false;
          } else {
            return true;
          }
        }

        // 驗證邏輯
        function addUser() {
          var valid = true;
          allFields.removeClass("ui-state-error");

          valid = valid && checkLength(name, "username", 3, 16);
          valid = valid && checkLength(email, "email", 6, 80);
          valid = valid && checkLength(password, "password", 5, 16);

          valid = valid && checkRegexp(name, /^[a-z]([0-9a-z_\s])+$/i, "Username may consist of a-z, 0-9, underscores, spaces and must begin with a letter.");
          valid = valid && checkRegexp(email, emailRegex, "eg. ui@jquery.com");
          valid = valid && checkRegexp(password, /^([0-9a-zA-Z])+$/, "Password field only allow : a-z 0-9");

          if (valid) {
            $("#users tbody").append("<tr>" +
              "<td>" + name.val() + "</td>" +
              "<td>" + email.val() + "</td>" +
              "<td>" + password.val() + "</td>" +
              "</tr>");
            dialog.dialog("close");
          }
          return valid;
        }

        // dialog排版
        dialog = $("#dialog-form").dialog({
          autoOpen: false,
          height: 500,
          width: 350,
          modal: true,
          buttons: {
            "Create account": addUser,
            Cancel: function() {
              dialog.dialog("close");
            }
          },
          close: function() {
            form[0].reset();
            allFields.removeClass("ui-state-error");
          }
        });

        // 提交
        form = dialog.find("form").on("submit", function(event) {
          event.preventDefault();
          addUser();
        });

        // 打開dialog
        $("#open_dialog").button().on("click", function() {
          dialog.dialog("open");
        });
      });
    });
  </script>
</body>

</html>