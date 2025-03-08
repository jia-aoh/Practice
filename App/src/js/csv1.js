function csv_easy_table($method, $url, $table_id) {
  var xhr = new XMLHttpRequest();
  xhr.open($method, $url, true);

  xhr.onload = () => {
    if (xhr.status === 200) {
      // Parse CSV
      var data = xhr.responseText;
      var rows = data.split('\n');

      // Get container div
      var div = document.querySelector($table_id);
      var table = document.createElement('table');
      div.appendChild(table);

      var thead = document.createElement('thead');
      var tbody = document.createElement('tbody');
      table.appendChild(thead);
      table.appendChild(tbody);

      // Add CSS for borders on thead only
      table.style.borderCollapse = 'collapse'; // Collapse borders for the table
      thead.style.border = 'none';  // No border for thead
      tbody.style.border = 'none';  // No border for tbody

      let head_already_been_printed = false;
      let headerNames = [];  // Store header names for later use

      rows.forEach((row, index) => {
        var cols = row.split(',');

        if (cols.length > 1) {
          var tableRow = document.createElement('tr');
          var checkboxTd = document.createElement('td');
          var checkbox = document.createElement('input');
          checkbox.type = 'checkbox';

          // Add checkbox to the first column of both thead and tbody rows
          checkboxTd.appendChild(checkbox);
          tableRow.appendChild(checkboxTd);

          // If it's the first row (the header row)
          if (index === 0) {
            // Create the header row with a checkbox in the first column
            var theadRow = document.createElement('tr');
            var theadCheckboxTd = document.createElement('th');
            var theadCheckbox = document.createElement('input');
            theadCheckbox.type = 'checkbox';
            theadCheckboxTd.appendChild(theadCheckbox);
            theadRow.appendChild(theadCheckboxTd);

            cols.forEach((col, colIndex) => {
              var th = document.createElement('th');
              col = col.replace(/"/g, '').trim();
              th.textContent = col;

              headerNames[colIndex] = col;  // Save the header names
              theadRow.appendChild(th);  // Add to thead
            });

            thead.appendChild(theadRow);  // Add the header row with checkbox

            thead.querySelectorAll('th').forEach((td) => {
              td.style.border = '1px solid black';
            });

            // Add event listener for the "select all" checkbox
            theadCheckbox.addEventListener('change', function () {
              let checkboxes = tbody.querySelectorAll('input[type="checkbox"]');
              checkboxes.forEach((checkbox) => {
                checkbox.checked = theadCheckbox.checked;
              });
            });
          } else {
            // For other rows (data rows), add the data in tbody
            cols.forEach((col, colIndex) => {
              var td = document.createElement('td');
              col = col.replace(/"/g, '').trim();
              td.textContent = col;

              // Set the name of the <td> based on the corresponding header
              td.setAttribute('name', headerNames[colIndex]);  // Set name from header

              tableRow.appendChild(td);
            });

            // Append the row to tbody
            tbody.appendChild(tableRow);

            // Add event listener for individual row checkboxes
            checkbox.addEventListener('change', function () {
              let allCheckboxes = tbody.querySelectorAll('input[type="checkbox"]');
              let headerCheckbox = thead.querySelector('input[type="checkbox"]');
              headerCheckbox.checked = Array.from(allCheckboxes).every((cb) => cb.checked);
            });
          }
        }
      });

      // Add submit button for data submission
      var submitButton = document.createElement('button');
      submitButton.textContent = 'Submit';
      submitButton.addEventListener('click', function () {
        var selectedRows = [];
        var checkedRows = tbody.querySelectorAll('input[type="checkbox"]:checked');

        checkedRows.forEach((checkbox) => {
          var row = checkbox.closest('tr');
          var rowData = [];

          row.querySelectorAll('td').forEach((td, index) => {
            if (index > 0) { // Skip the checkbox column
              rowData.push({
                name: td.getAttribute('name'),  // Use the name from the <td>
                value: td.textContent
              });
            }
          });

          selectedRows.push(rowData);
        });

        // Here you can send the selected rows data to the backend
        console.log(selectedRows);
        // Use your preferred method (e.g., fetch, XMLHttpRequest) to POST the data to your server
      });

      div.appendChild(submitButton);
    }
  };

  xhr.send();
}
