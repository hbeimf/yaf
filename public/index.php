<?php

try {
	error_reporting(E_ALL | E_STRICT);
	ini_set('display_errors', true); // 关闭警告
	define("APP_PATH", realpath(dirname(__FILE__) . '/../')); /* 指向public的上一级 */
	$app = new Yaf_Application(APP_PATH . "/conf/application.ini");
	Yaf_Dispatcher::getInstance()->autoRender(false);

	$app->bootstrap()->run();
} catch (Exception $e) {
	echo $e->getMessage();
}

?>
