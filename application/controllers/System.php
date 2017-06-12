<?php

use Illuminate\Database\Capsule\Manager as DB;

// https://docs.golaravel.com/docs/5.0/eloquent/
// orm online doc
class SystemController extends AbstractController {

	public function indexAction() {
		$data = [
			'js' => 'system_index',
		];
		$this->smarty->display('system/index.tpl', $data);
	}


	public function accountAction() {
		$params = [
			'name' => $this->request->getQuery('name'),
			'email' => $this->request->getQuery('email'),
			'page' => (!is_null($this->request->getQuery('page'))) ? $this->request->getQuery('page') : 1,
			'page_size' => (!is_null($this->request->getQuery('page_size'))) ? $this->request->getQuery('page_size') : 3,

		];

		$skip = ($params['page'] - 1) * $params['page_size'];

		$select = 'id, username as name, email, created_at';
		$users = Table_User::selectRaw($select)
			->skip($skip)
			->limit($params['page_size'])
			->get();

		$count = Table_User::count();

		$totalPage = ceil($count / $params['page_size']);

		$data = [
			'js' => 'demo',
			'rand' => time(),
			'users' => $users->toArray(), // 当前页记录
			'count' => $count, // 记录条数
			'page' => $params['page'], // 当前页
			'totalPage' => $totalPage, // 总页数
		];
		$this->smarty->display('system/account.tpl', $data);
	}


	public function addAccountAction() {
		if ($this->request->isPost()) {

			print_r($_POST);exit;
		}

		$data = [];
		$this->getView()->display('system/addAccount.tpl');
	}

	public function roleAction() {
		$params = [
			'name' => $this->request->getQuery('name'),
			'email' => $this->request->getQuery('email'),
			'page' => (!is_null($this->request->getQuery('page'))) ? $this->request->getQuery('page') : 1,
			'page_size' => (!is_null($this->request->getQuery('page_size'))) ? $this->request->getQuery('page_size') : 3,

		];

		$skip = ($params['page'] - 1) * $params['page_size'];

		$select = 'id, role_name as name,  menu_ids, created_at';
		$users = Table_System_Role::selectRaw($select)
			->skip($skip)
			->limit($params['page_size'])
			->get();

		$count = Table_System_Role::count();

		$totalPage = ceil($count / $params['page_size']);

		$data = [
			'js' => 'system_role',
			'rand' => time(),
			'users' => $users->toArray(), // 当前页记录
			'count' => $count, // 记录条数
			'page' => $params['page'], // 当前页
			'totalPage' => $totalPage, // 总页数
		];


		$this->smarty->display('system/role.tpl', $data);

	}

	public function addRoleAction() {
		if ($this->request->isPost()) {

			$data = [
				'role_name' => $this->request->getPost('role_name'),
				'menu_ids' => $this->request->getPost('menu_ids'),
				'status' => $this->request->getPost('status'),
				'note' => $this->request->getPost('note'),
			];

			if ($data['role_name'] == '') {
				return $this->ajax_error('角色名称不能为空');
			}

			if (is_array($data['menu_ids']) && !empty($data['menu_ids']) ) {
				$data['menu_ids'] = implode(',', $data['menu_ids']);
			} else {
				$data['menu_ids'] = '';
			}


			$id = $this->request->getPost('id');

			if ($id == '') {
				DB::table('system_role')->insert([$data]);
				return $this->ajax_success('添加成功！');
			} else {
				Table_System_Role::where('id', $id)->update($data);
				return $this->ajax_success('更新成功！');
			}
		}

		//初始化 modal
		if (! is_null($this->request->getParam('id'))) {
			$id = $this->request->getParam('id');
			$role = DB::table('system_role')->where('id', $id)->first();

			// p($role);exit;
			$role['menu_ids'] = explode(',', $role['menu_ids']);

			$this->smarty->assign('role', $role);
		}

		$this->smarty->display('system/addRole.tpl');
	}


	public function menuAction() {
		$menu = [
			[
				'id' => 1,
				'menu_name' => '系统管理',
				'parent_id' => 0,
				'link' => '',
				'icon' => '',
				'status' => 1,
				'note' => ''
			],
			[
				'id' => 2,
				'menu_name' => '导航管理',
				'parent_id' => 1,
				'link' => '/system/index/',
				'icon' => '',
				'status' => 1,
				'note' => '',
			],
			[
				'id' => 3,
				'menu_name' => '账号管理',
				'parent_id' => 1,
				'link' => '/system/account/',
				'icon' => '',
				'status' => 1,
				'note' => '',
			],
			[
				'id' => 4,
				'menu_name' => '权限管理',
				'parent_id' => 1,
				'link' => '/system/role/',
				'icon' => '',
				'status' => 1,
				'note' => '',
			],
		];

		DB::table('system_menu')->insert($menu);

		p($menu);
	}

    // =====================================
	public function addMenuAction() {
		if ($this->request->isPost()) {
			$data = [
				'menu_name' => $this->request->getPost('menu_name'),
				'parent_id' => $this->request->getPost('parent_id'),
				'link' => $this->request->getPost('link'),
				'icon' => $this->request->getPost('icon'),
				'status' => $this->request->getPost('status'),
				'note' => $this->request->getPost('note'),
			];

			if ($data['menu_name'] == '') {
				return $this->ajax_error('名称不能为空');
			}

			if ($data['parent_id'] > 0 && $data['link'] == '') {
				return $this->ajax_error('链接不能为空');
			}

			$id = $this->request->getPost('id');

			if ($id == '') {
				DB::table('system_menu')->insert([$data]);
				return $this->ajax_success('添加成功！');
			} else {
				Table_System_Menu::where('id', $id)->update($data);
				return $this->ajax_success('更新成功！');
			}

		}

		//初始化 modal
		if (! is_null($this->request->getParam('id'))) {
			$id = $this->request->getParam('id');
			$menu = DB::table('system_menu')->where('id', $id)->first();
			// p($menu);

			$this->smarty->assign('menu', $menu);
		}

		$this->smarty->display('system/addMenu.tpl');
	}

}
