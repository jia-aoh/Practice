<?php
require_once '../config/conn.php';
require_once '../src/CSV/funcs.php';

use App\CSV\CSV;

CSV::get_table(
  $conn,
  "SELECT theme, series_title, name, price, amount FROM vw_eggcard",
  ['Theme', 'Series Title', 'Name', 'Price', 'Amount']
);
