<?php

session_id(SID);
session_start();
try {
	error_reporting(E_ALL | E_STRICT);

	define("APP_PATH", realpath(dirname(__FILE__) . '/../')); /* 指向public的上一级 */

	if (isset($_SERVER['APP_ENV']) && $_SERVER['APP_ENV'] == 'PRODUCTION') {
		ini_set('display_errors', false); // 关闭警告
		$config = APP_PATH . "/conf/application.ini";
	} else {
		ini_set('display_errors', true); // 开启警告
		$config = APP_PATH . "/conf/application_development.ini";
	}
	$app = new Yaf_Application($config);
	Yaf_Dispatcher::getInstance()->autoRender(false);

	$app->bootstrap()->run();
} catch (Exception $e) {
	echo $e->getMessage();
}

?>
