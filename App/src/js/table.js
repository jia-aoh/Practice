function jsonToTable(tableContainerId, tableHeadKeyValue, jsonData) {
  // 指定容器
  const tableContainer = document.getElementById(tableContainerId);
  if (!tableContainer) return;

  // 建table
  const table = document.createElement('table');
  const thead = document.createElement('thead');
  const tbody = document.createElement('tbody');

  // 表頭
  const headerRow = document.createElement('tr');
  for (const key in tableHeadKeyValue) {
    const th = document.createElement('th');
    th.innerText = tableHeadKeyValue[key];  // 顯示
    headerRow.appendChild(th);
  }
  thead.appendChild(headerRow);
  thead.querySelectorAll('th').forEach((td) => {
    td.style.border = '1px solid black';
  });

  // data
  jsonData.forEach(rowData => {
    const row = document.createElement('tr');
    for (const key in tableHeadKeyValue) {
      const td = document.createElement('td');
      td.innerText = rowData[key] || '';  // 根據 key 得 value
      td.setAttribute('name', key);  // 設定 name 
      row.appendChild(td);
    }
    tbody.appendChild(row);
  });

  // 寫表
  table.appendChild(thead);
  table.appendChild(tbody);

  // 寫表
  tableContainer.innerHTML = '';
  tableContainer.appendChild(table);
}


function checkboxForTable(tableContainerId) {
  const tableContainer = document.getElementById(tableContainerId);
  if (!tableContainer) return;

  const table = tableContainer.querySelector('table');
  if (!table) return;

  const thead = table.querySelector('thead');
  const tbody = table.querySelector('tbody');

  // 全選checkbox
  const headerRow = thead.querySelector('tr');
  const thCheckbox = document.createElement('th');
  const checkbox = document.createElement('input');
  checkbox.type = 'checkbox';

  thCheckbox.appendChild(checkbox);
  headerRow.insertBefore(thCheckbox, headerRow.firstChild);
  thead.querySelectorAll('th').forEach((td) => {
    td.style.border = '1px solid black';
  });

  // tbody checkbox
  Array.from(tbody.rows).forEach(row => {
    const tdCheckbox = document.createElement('td');
    const rowCheckbox = document.createElement('input');
    rowCheckbox.type = 'checkbox';
    tdCheckbox.appendChild(rowCheckbox);
    row.insertBefore(tdCheckbox, row.firstChild);
  });

  // 攔截全選
  checkbox.addEventListener('change', () => {
    const isChecked = checkbox.checked;
    Array.from(tbody.rows).forEach(row => {
      const rowCheckbox = row.querySelector('td input[type="checkbox"]');
      rowCheckbox.checked = isChecked;
    });
  });

  // 攔截其他checkbox
  Array.from(tbody.rows).forEach(row => {
    const rowCheckbox = row.querySelector('td input[type="checkbox"]');
    rowCheckbox.addEventListener('change', () => {
      const allChecked = Array.from(tbody.rows).every(row => row.querySelector('td input[type="checkbox"]').checked);
      checkbox.checked = allChecked;
    });
  });
}

function answerOfTable(tableContainerId) {
  const tableContainer = document.getElementById(tableContainerId);
  if (!tableContainer) return [];

  const table = tableContainer.querySelector('table');
  if (!table) return [];

  const tbody = table.querySelector('tbody');
  const jsonResult = [];

  // 遍歷選到的checkbox
  Array.from(tbody.rows).forEach(row => {
    const rowCheckbox = row.querySelector('td input[type="checkbox"]');
    if (rowCheckbox && rowCheckbox.checked) {
      const rowData = {};
      Array.from(row.cells).forEach((cell, index) => {

        if (cell.hasAttribute('name')) {
          const columnName = cell.getAttribute('name');
          rowData[columnName] = cell.innerText;
        }
      });
      jsonResult.push(rowData);
    }
  });

  return jsonResult;
}
