<?php

/**
 * Class AbstractController
 */
abstract class AbstractController extends Yaf_Controller_Abstract {

	/**
	 * 登录、权限判断、初始化
	 */
	public function init() {
		$this->request = Yaf_Dispatcher::getInstance()->getRequest();
		$this->smarty = View::getInstance();
		$this->_controller = strtolower($this->request->getControllerName());
		$this->_action = strtolower($this->request->getActionName());

		if (!$this->is_login()) {
			if (!(trim($this->_controller) == 'index' && trim($this->_action) == 'login')) {
				$this->redirect("/index/login");

			}

		} else {

			$menu = Table_System_Menu::all()->toArray();
			$this->smarty->assign('system_menu', $this->parse_menu($menu));
			$this->smarty->assign('current_menu', $this->current_menu($menu));

			// 定义开发环境
			$app_env = (isset($_SERVER['APP_ENV'])) ? $_SERVER['APP_ENV'] : '';
			$this->smarty->assign('APP_ENV', $app_env);

			$nickname = isset($_SESSION['nickname']) ? $_SESSION['nickname'] : 'no name';
			$this->smarty->assign('nickname', $nickname);
			$right = isset($_SESSION['right']) ? $_SESSION['right'] : [];

			$this->smarty->assign('menu_right', $this->access_right($menu));
		}

	}

	protected function access_right($all_menu) {
		if (isset($_SESSION['account_id'])) {
			$account_id = $_SESSION['account_id'];

			$table = new Table_System_Account();
			$row = $table->where('id', $account_id)->first()->toArray();

			return $this->right($row, $all_menu);
		}

		return [];
	}

	protected function right($account, $all_menu) {
		$roles = explode(',', trim($account['role_id']));
		$all_role = Table_System_Role::all()->toArray();

		$menu = [];
		foreach ($all_role as $key => $value) {
			if (in_array($value['id'], $roles)) {
				if (trim($value['menu_ids']) != '') {
					$ids = explode(',', $value['menu_ids']);
					foreach ($ids as $id) {
						$menu[$id] = $id;
					}
				}
			}
		}

		// $all_menu = Table_System_Menu::all()->toArray();
		foreach ($all_menu as $key => $value) {
			if (in_array($value['id'], $menu)) {
				$menu[$value['parent_id']] = $value['parent_id'];
			}
		}

		return $menu;
	}

	// 检查是否登录　
	protected function is_login() {
		// 获取当前会话id
		$sid = session_id();

		// p($_SESSION);exit;
		if (isset($_SESSION["username"]) && isset($_SESSION['passwd'])) {
			return true;
		}
		return false;
	}

	protected function current_menu($menu) {
		$reply = [
			'id' => 0,
			'parent_id' => 0,
			'menu_name' => '控制台',
			'parent_menu_name' => '',
		];

		foreach ($menu as $m) {
			$ctrl = strtolower($m['controller']);
			$action = strtolower($m['action']);

			if ($ctrl == strtolower($this->_controller) && strtolower($action == $this->_action)) {
				$reply = [
					'id' => $m['id'],
					'parent_id' => $m['parent_id'],
					'menu_name' => $m['menu_name'],
					'parent_menu_name' => '',
				];
			}
		}

		if ($reply['parent_id'] > 0) {
			foreach ($menu as $v) {
				if ($v['id'] == $reply['parent_id']) {
					$reply['parent_menu_name'] = $v['menu_name'];
				}
			}
		}

		return $reply;
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
