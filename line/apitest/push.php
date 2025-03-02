<?php

require_once './config.php';

$data;

if (isset($_POST['message'])) {
    $channelAccessToken = CHANNEL_ACCESS_TOKEN;
    $toUserId = USER_LINE_ID;
    $userinput = $_POST['message'];

    $messageData = [
        'to' => $toUserId,
        'messages' => [
            [
                'type' => 'text',
                'text' => $userinput
            ]
        ]
    ];

    $ch = curl_init('https://api.line.me/v2/bot/message/push');

    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        'Content-Type: application/json',
        'Authorization: Bearer ' . $channelAccessToken
    ]);

    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($messageData));

    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

    $data = curl_exec($ch);

    curl_close($ch);

    $status_code = 200;
    $message = "Request Successful";

} else {
    $status_code = 400;
    $message = "Bad Request: Missing parameters";
}

$response = array(
    "status" => $status_code,
    "message" => $message,
    "data" => $data,
);

echo json_encode($response);
