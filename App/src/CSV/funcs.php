<?php

namespace App\CSV;

use Exception;

class CSV
{
  public static function get_table($conn, $sql, $title)
  {
    $result = mysqli_query($conn, $sql);

    if ($result && mysqli_num_rows($result) > 0) {
      header('Content-Type: text/csv');
      header('Content-Disposition: attachment; filename="data.csv"');

      $output = fopen('php://output', 'w');

      fputcsv($output, $title);

      while ($row = mysqli_fetch_assoc($result)) {
        fputcsv($output, $row);
      }

      fclose($output);
    } else {
      echo "No data found.";
    }
    mysqli_close($conn);
  }
}
