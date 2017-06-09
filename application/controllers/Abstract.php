<?php

/**
 * Class AbstractController
 */
abstract class AbstractController extends Yaf_Controller_Abstract {

	/**
	 * 登录、权限判断、初始化
	 */
	public function init() {
		// header("Content-Type:text/html;charset=utf-8");
		// session_start();
		$this->request = Yaf_Dispatcher::getInstance()->getRequest();
		$this->smarty = View::getInstance();
		$this->_controller = strtolower($this->request->getControllerName());
		$this->_action = strtolower($this->request->getActionName());

		if (! $this->is_login() && $this->_controller != 'index' && $this->_action != 'login') {
			 $this->redirect("/index/login");
		}

		$menu = Table_System_Menu::all()->toArray();
		$this->smarty->assign('system_menu', $this->parse_menu($menu));
		$this->smarty->assign('current_menu', $this->current_menu($menu));

		// 定义开发环境
		$app_env = (isset($_SERVER['APP_ENV'])) ? $_SERVER['APP_ENV'] : '';
		$this->smarty->assign('APP_ENV', $app_env);


	}


	protected function is_login() {
		return true;
	}


	protected function current_menu($menu) {
		$controller_name = strtolower($this->request->getControllerName());
		$action_name = strtolower($this->request->getActionName());


		foreach ($menu as $m) {
			$arr = explode("/",  trim($m['link'], '/'));

			$ctrl = isset($arr[0]) ? strtolower($arr[0]) : 'index';
			$action = isset($arr[1]) ? strtolower($arr[1]) : 'index';

			if ($ctrl == $controller_name && $action == $action_name) {
				return $m;
			}
		}

		return ['id'=>0, 'parent_id'=>0];
	}

	protected function parse_menu($menu) {
		$list = [];
		foreach ($menu as $m) {
			$m['child'] = [];
			if ($m['parent_id'] == 0) {
				foreach ($menu as $mm) {
					if ($m['id'] == $mm['parent_id']) {
						$m['child'][] = $mm;
					}
				}
				$list[] = $m;
			}
		}
		return $list;
	}



	protected function ajax_error($msg = '') {
		$reply = [
			'code' => '500',
			'msg' => $msg,
		];

		die(json_encode($reply));
	}

	protected function ajax_success($msg = '') {
		$reply = [
			'code' => '200',
			'msg' => $msg,
		];

		die(json_encode($reply));
	}




}
