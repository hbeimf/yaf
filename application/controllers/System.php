<?php

use Illuminate\Database\Capsule\Manager as DB;

// https://docs.golaravel.com/docs/5.0/eloquent/
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
			'page' => (!is_null($this->request->getQuery('page'))) ? $this->request->getQuery('page') : 1,
			'page_size' => (!is_null($this->request->getQuery('page_size'))) ? $this->request->getQuery('page_size') : 3,
		];

		$skip = ($params['page'] - 1) * $params['page_size'];

		$select = 'id, account_name as name, role_id, status, created_at';
		$account_obj = Table_System_Account::selectRaw($select);
		if (trim($params['name']) != '') {
			$account_obj->where('account_name', 'like', "%{$params['name']}%");
		}

		$count = $account_obj->count();
		$users = $account_obj->skip($skip)
							->limit($params['page_size'])
							->get();

		$totalPage = ceil($count / $params['page_size']);

		$data = [
			// 'js' => 'system_role',
			'rand' => time(),
			'users' => $users->toArray(), // 当前页记录
			'count' => $count, // 记录条数
			'page' => $params['page'], // 当前页
			'totalPage' => $totalPage, // 总页数
			'params' => $params,
		];

		$data['roles'] = Table_System_Role::all()->toArray();

		$this->smarty->getSmarty()->registerPlugin("function", "role_name", "role_name");
		$this->smarty->getSmarty()->registerPlugin("function", "acount_menu", "acount_menu");

		$this->smarty->display('system/account.tpl', $data);

	}

	public function addAccountAction() {
		if ($this->request->isPost()) {

			$data = [
				'nickname' => $this->request->getPost('nickname'),
				'account_name' => $this->request->getPost('account_name'),
				'passwd' => $this->request->getPost('passwd'),
				'email' => $this->request->getPost('email'),
				'phone' => $this->request->getPost('phone'),
				'role_id' => $this->request->getPost('role_id'),
				'status' => $this->request->getPost('status'),
				'note' => $this->request->getPost('note'),
			];

			if ($data['nickname'] == '') {
				return $this->ajax_error('昵称不能为空');
			}

			if ($data['account_name'] == '') {
				return $this->ajax_error('账号名称不能为空');
			}

			if ($data['email'] == '') {
				return $this->ajax_error('邮箱不能为空');
			}

			if ($data['phone'] == '') {
				return $this->ajax_error('电话不能为空');
			}

			if (is_array($data['role_id']) && !empty($data['role_id']) ) {
				$data['role_id'] = implode(',', $data['role_id']);
			} else {
				$data['role_id'] = '';
			}

			$id = $this->request->getPost('id');

			if ($id == '') {
				if ($data['passwd'] == '') {
					return $this->ajax_error('密码不能为空');
				}
				$data['passwd'] = md5(trim($data['passwd']));

				DB::table('system_account')->insert([$data]);
				return $this->ajax_success('添加成功！');
			} else {
				if (trim($data['passwd']) == '') {
					unset($data['passwd']);
				} else {
					$data['passwd'] = md5(trim($data['passwd']));
				}
				Table_System_Account::where('id', $id)->update($data);
				return $this->ajax_success('更新成功！');
			}
		}

		//初始化 modal
		if (! is_null($this->request->getParam('id'))) {
			$id = $this->request->getParam('id');
			$account = DB::table('system_account')->where('id', $id)->first();
			$account['role_id'] = explode(',', $account['role_id']);

			$this->smarty->assign('account', $account);
		}

		$roles = Table_System_Role::all();
		$data = [
			'roles' => $roles,
		];

		$this->smarty->display('system/addAccount.tpl', $data);
	}


	public function roleAction() {
		$params = [
			'name' => $this->request->getQuery('name'),
			'page' => (!is_null($this->request->getQuery('page'))) ? $this->request->getQuery('page') : 1,
			'page_size' => (!is_null($this->request->getQuery('page_size'))) ? $this->request->getQuery('page_size') : 3,
		];

		$skip = ($params['page'] - 1) * $params['page_size'];

		$select = 'id, role_name as name, menu_ids, status, created_at';
		$table_user = Table_System_Role::selectRaw($select);
		if (trim($params['name']) != '') {
			$name = urldecode($params['name']);
			$table_user->where('role_name', 'like', "%{$name}%");
		}
		$count = $table_user->count();
		$users = $table_user
			->skip($skip)
			->limit($params['page_size'])
			->get();

		$totalPage = ceil($count / $params['page_size']);

		$data = [
			'js' => 'system_role',
			'rand' => time(),
			'users' => $users->toArray(), // 当前页记录
			'count' => $count, // 记录条数
			'page' => $params['page'], // 当前页
			'totalPage' => $totalPage, // 总页数
			'params' => $params,
		];

		// $list = Table_Gp_List::find(1)->toArray();

		$this->smarty->getSmarty()->registerPlugin("function", "menu_name", "menu_name");
		$this->smarty->display('system/role.tpl', $data);

	}

	public function delRoleAction(){
		$id = $this->request->getParam('id');

		$this->ajax_success('目前未提供删除功能'.$id);
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
			$role['menu_ids'] = explode(',', $role['menu_ids']);

			$this->smarty->assign('role', $role);
		}

		$this->smarty->display('system/addRole.tpl');
	}

    // =====================================
	public function addMenuAction() {
		if ($this->request->isPost()) {
			$data = [
				'menu_name' => $this->request->getPost('menu_name'),
				'parent_id' => $this->request->getPost('parent_id'),
				'status' => $this->request->getPost('status'),
				'note' => $this->request->getPost('note'),
				'controller' => $this->request->getPost('controller'),
				'action' => $this->request->getPost('actions'),
				'type' => $this->request->getPost('type'),

			];

			if ($data['menu_name'] == '') {
				return $this->ajax_error('名称不能为空');
			}

			if ($data['parent_id'] > 0) {

				if ($data['controller'] == '') {
					return $this->ajax_error('Controller 不能为空');
				}

				if ($data['action'] == '') {
					return $this->ajax_error('Action 不能为空');
				}

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
			$this->smarty->assign('menu', $menu);
		}

		$this->smarty->display('system/addMenu.tpl');
	}

}
