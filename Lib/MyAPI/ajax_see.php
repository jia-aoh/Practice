<?php
// composer require ezyang/htmlpurifier

require_once __DIR__ . '/vendor/autoload.php';

$config = HTMLPurifier_Config::createDefault();
$purifier = new HTMLPurifier($config);

foreach ($_REQUEST as $key => $value) {
    $cleanAjax[$key] =
        is_array($value)
        ?
        array_map(fn($item) => is_array($item) ? $item : $purifier->purify($item), $value)
        :
        $purifier->purify($value);
}

$status_code = 200;
$message = "Request Successful";
$data = array();
$debug = array();

if (!isset($_REQUEST)) {
    $status_code = 400;
    $message = "Bad Request: Missing parameters";
} else {
    $data = $cleanAjax;
}

$response = array(
    "status" => $status_code,
    "message" => $message,
    "data" => $data,
);

echo json_encode($response);
