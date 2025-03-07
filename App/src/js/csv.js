function csv_easy_table($method, $url, $table_id) {
  var xhr = new XMLHttpRequest();
  xhr.open($method, $url, true);

  xhr.onload = () => {
    if (xhr.status === 200) {
      // parse csv
      var data = xhr.responseText;
      var rows = data.split('\n');

      // get container div
      var div = document.querySelector($table_id);
      var table = document.createElement('table');
      div.appendChild(table);

      var thead = document.createElement('thead');
      var tbody = document.createElement('tbody');
      table.appendChild(thead);
      table.appendChild(tbody);

      let head_already_been_printed = false;
      rows.forEach((row) => {
        var cols = row.split(',');

        if (cols.length > 1) {
          var tableRow = document.createElement('tr');

          cols.forEach((col) => {
            var td = document.createElement('td');
            col = col.replace(/"/g, '').trim();
            td.textContent = col;

            // thead font style
            if (!head_already_been_printed) td.style.fontWeight = 'bold';
            tableRow.appendChild(td);

          });
          // thead 
          !head_already_been_printed && thead.appendChild(tableRow);
          // tbody
          tbody.appendChild(tableRow);
        }
      });
    }
  };

  xhr.send();
}
