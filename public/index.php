<?php

try {
	error_reporting(E_ALL | E_STRICT);
	ini_set('display_errors', true); // 关闭警告
	define("APP_PATH", realpath(dirname(__FILE__) . '/../')); /* 指向public的上一级 */
	$app = new Yaf_Application(APP_PATH . "/conf/application.ini");
	Yaf_Dispatcher::getInstance()->autoRender(false);

	$include_path = PATH_SEPARATOR . "." . APP_PATH . "/application/library";
	// $include_path .= PATH_SEPARATOR."./application/modules";
	set_include_path($include_path);

	// var_dump('ss');exit;
	$app->bootstrap()->run();
} catch (Exception $e) {
	echo $e->getMessage();
}

// try{
//     error_reporting(E_ALL | E_STRICT);
//     ini_set('display_errors', true); // 关闭警告

//     date_default_timezone_set('Asia/Shanghai');
//     $include_path = PATH_SEPARATOR."./application/library";
//     $include_path .= PATH_SEPARATOR."./application/modules";
//     set_include_path($include_path);

//     define("APP_PATH", dirname(__FILE__));
//     $application = new Yaf_Application(APP_PATH ."config/application.ini");
//     Yaf_Dispatcher::getInstance()->autoRender(false);
//     $response = $application->bootstrap()->run();
// }catch (Exception $e){
//     echo $e->getMessage();
// }

?>
