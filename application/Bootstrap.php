<?php

use Illuminate\Database\Capsule\Manager as Capsule;

class Bootstrap extends Yaf_Bootstrap_Abstract {

	public function _initLoader() {
		set_error_handler(
			create_function(
				'$severity, $message, $file, $line',
				'throw new ErrorException($message, $severity, $severity, $file, $line);'
			)
		);

		// 开启日志
		// register_shutdown_function(array($this, 'cleanup'));

		Yaf_Loader::import(APP_PATH . "/vendor/autoload.php");
		Yaf_Loader::import(APP_PATH . "/application/function.php");

		// 注册本地类名前缀, 这部分类名将会在本地类库查找
		Yaf_Loader::getInstance()->registerLocalNameSpace(array('Log', 'Cache', 'Upload', 'Http', 'Util'));
	}

	public function _initConfig() {
		$config = Yaf_Application::app()->getConfig();
		Yaf_Registry::set('config', $config);
	}

	public function _initDefaultName(Yaf_Dispatcher $dispatcher) {
		$dispatcher->setDefaultModule('Index')->setDefaultController('Index')->setDefaultAction('index');
	}

	public function _initDatabaseEloquent() {
		$capsule = new Capsule;

		// 创建默认链接 system 库, system 系统导航库
		$capsule->addConnection(Yaf_Application::app()->getConfig()->database->toArray());

		// gp 库
		$capsule->addConnection(Yaf_Application::app()->getConfig()->demo->toArray(), 'demo');

		// 设置全局静态可访问
		$capsule->setAsGlobal();

		// 启动Eloquent
		$capsule->bootEloquent();

		// 开启sql查询记录　
		$capsule::connection()->enableQueryLog();
		// 多个数据库链接 要开启多次， 打印日志也是分开打印的，要手动添加打印日志，
		$capsule::connection('demo')->enableQueryLog();

	}

	public function _initRoute(Yaf_Dispatcher $dispatcher) {
		$router = $dispatcher->getRouter();
		$router->addRoute('404', new Yaf_Route_Rewrite(
			'/404$',
			array(
				'controller' => 'Public',
				'action' => 'unknow',
			)
		));
	}

	// redis init
	// public function _initSession()
	// {
	//     try {
	//         $redis = redisConnect();
	//         $redis->ping();
	//         $session = new Util_Session();
	//         session_set_save_handler($session, true);
	//     } catch (Exception $e) {
	//         Log_Log::info('[Bootstrap] session init error:' . $e->getMessage(), true, true);
	//     }
	// }

	public function cleanup() {

		restore_error_handler();

		// 捕获fatal error
		$e = error_get_last();
		if ($e['type'] == E_ERROR) {
			$str = <<<TYPEOTHER
[message] {$e['message']}
[file] {$e['file']}
[line] {$e['line']}
TYPEOTHER;
			// todo 发送邮件、短息、写日志报警……
		}

		// 定义了开关，便关闭log
		if (!defined('SHUTDOWN')) {
			Log_Log::info('receive:' . var_export($_REQUEST, true), true, true);

			// DEFAULT
			$this->log(Capsule::getQueryLog(), 'DEFAULT');

			// 业务库相关SQL
			if (defined('BIZ')) {
				$this->log(Capsule::connection(BIZ)->getQueryLog(), 'BIZ');
			}

		}

	}

	/**
	 * @param $info
	 * @param $link
	 */
	public function log($info, $link) {
		foreach ($info as $val) {
			Log_Log::info('[' . $link . ' query] ' . $val['query'] . ' [bindings] ' . implode(' ', $val['bindings']) . ' [time] ' . $val['time'], 1, 1);
		}
	}
}
