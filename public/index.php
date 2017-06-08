<?php

try {
	error_reporting(E_ALL | E_STRICT);
	ini_set('display_errors', true); // 关闭警告
	define("APP_PATH", realpath(dirname(__FILE__) . '/../')); /* 指向public的上一级 */

    if (isset($_SERVER['APP_ENV']) && $_SERVER['APP_ENV'] == 'PRODUCTION') {
        $config = APP_PATH . "/conf/application.ini";
    } else {
        $config = APP_PATH . "/conf/application_development.ini";
    }
	$app = new Yaf_Application($config);
	Yaf_Dispatcher::getInstance()->autoRender(false);

	$app->bootstrap()->run();
} catch (Exception $e) {
	echo $e->getMessage();
}

?>
