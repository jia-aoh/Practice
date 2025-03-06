<?php
// 這是與 Bartender 進行互動的範例程式

/**
 *  1. 安裝 Bartender，啟用 ActiveX 才能COM
 *  2. php.ini -> extension=php_com_dotnet.dll
 *  3. code
 *  4. crontab -e
 *  5. 0 9 * * * /usr/bin/php /path/to/print_label.php
 */

ini_set('log_errors', 1);
ini_set('error_log', 'php_errors.log'); // 設置錯誤日誌文件

try {
    // 啟動 Bartender 應用程式
    $btApp = new COM("BarTender.Application") or die("Bartender ActiveX 物件未能加載");
    
    // 設定為不顯示 Bartender 主畫面
    $btApp->Visible = false;

    // 打開標籤模板
    $btFormat = $btApp->Forms->Open('C:\\path\\to\\your\\label_template.btw'); // 修改為您的 Bartender 標籤模板路徑

    // 設定資料來源 XML 文件
    $btFormat->SetDataSource("C:\\path\\to\\students.xml"); // 修改為您的 XML 檔案路徑

    // 開始列印
    $btFormat->PrintOut();

    // 可選：設置列印次數（例如：列印 1 次）
    // $btFormat->PrintOut(1);

    // 關閉 Bartender 應用程式
    $btApp->Quit();

    echo "列印完成！";
} catch (Exception $e) {
    echo "錯誤：", $e->getMessage();
    error_log("錯誤： " . $e->getMessage()); // 記錄錯誤到日誌
}
?>
