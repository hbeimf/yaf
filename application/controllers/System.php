<?php

use Illuminate\Database\Capsule\Manager as DB;

// use User;

// https://docs.golaravel.com/docs/5.0/eloquent/
// orm online doc
class SystemController extends AbstractController {

	// 默认Action
	// http://yaf.demo.com/demo/index
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

		// p($params);
		// $page = 1;
		// $pageSize = 3;

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

		// p($params);
		// $page = 1;
		// $pageSize = 3;

		$skip = ($params['page'] - 1) * $params['page_size'];

		$select = 'id, username as name, email, created_at';
		$users = Table_User::selectRaw($select)
			->skip($skip)
			->limit($params['page_size'])
			->get();

		$count = Table_User::count();

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

			$reply = [
				'code' => 200,
				'msg' => '增加成功',
			];

			echo json_encode($reply); exit;
		}

		$data = [];
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




	// http://yaf.demo.com/demo/insert
	public function insertAction() {

		$name = 'xiaomin' . time();
		$email = 'xiaomin@foxmail.com' . time();

		DB::table('users')->insert([
			array('username' => $name,
				'email' => $email,
				'created_at' => date("Y-m-d H:i:s", time()),
				'updated_at' => date("Y-m-d H:i:s", time())),
		]);

		var_dump('insert');
		exit;
	}

	// http://yaf.demo.com/demo/delete
	public function deleteAction() {
		if ($user = User::find(2)) {
			var_dump($user->delete());
		} else {
			echo "xx <br /> ";
		}

		$affectedRows = User::where('id', '<=', 4)->delete();
		var_dump($affectedRows);
		exit;
	}

	// http://yaf.demo.com/demo/update
	public function updateAction() {
		$user = User::find(6);

		$user->email = 'john@foo.com';

		var_dump($user->save());

		exit;
	}

	// http://yaf.demo.com/demo/select
	// http://d.laravel-china.org/docs/5.1/database#%E8%BF%90%E8%A1%8C%E5%8E%9F%E5%A7%8B-SQL-%E6%9F%A5%E6%89%BE
	public function selectAction() {
		DB::connection()->enableQueryLog();

		$user = DB::table('users')->where('username', 'xxx')->first();
		p($user);

		DB::table('users')->chunk(100, function ($users) {

			foreach ($users as $user) {
				echo $user['username'] . "<br />";
			}
			return false;
		});

		$name = DB::table('users')->lists('username', 'email');
		p($name);

		$users = DB::table('users')->select('username as name', 'email')->get();
		p($users);

		$admin = DB::table('users')
			->whereIdAndEmail(1, 'xxx@foxmail.com')
			->first();
		p($admin);

		try {
			DB::beginTransaction();
			$users = DB::table('users')
				->select('username as name', 'email')
				->where('username', 'xxx')
				->orwhere('username', 'overtrue')
				->get();
			DB::commit();
			p($users);
		} catch (Exception $e) {
			echo $e->getMessage();
		}

		$users = DB::select('select id,username,email from users where id <= ? and id >= ? ', [10, 5]);
		p($users);

		p(DB::getQueryLog());
		exit;
	}

	// http://www.cnblogs.com/brudeke/p/4227711.html
	// http://yaf.demo.com/demo/page
	// SELECT
	//  users.sNmame,
	//  users.iCreateTime,
	//  users_ext.iAge,
	//  users_ext.sSex
	// FROM
	//  users
	// LEFT JOIN users_ext ON users.iAutoId = users_ext.iUserID
	// WHERE
	//   users.iStatus = 1
	// AND users_ext.sSex = 0
	// ORDER BY
	//   users.iCreateTime
	// LIMIT 0,1
	public function pageAction() {
		// $select = 'users.sNmame,users.iCreateTime,users_ext.iAge,users_ext.sSex';
		// $resData = User::selectRaw($select)
		//            ->leftJoin('users_ext','users.iAutoId','=','users_ext.iUserID')
		//            ->where('users.iStatus','=',1)
		//            ->where('users_ext.sSex','=',0)
		//            ->skip(0)
		//            ->limit(1)
		//            ->get();
		// var_dump($resData->toArray());

		$page = 5;
		$pageSize = 3;

		$skip = ($page - 1) * $pageSize;

		$select = 'id,username, email';
		$resData = User::selectRaw($select)
		// ->leftJoin('users_ext','users.iAutoId','=','users_ext.iUserID')
		// ->where('users.iStatus','=',1)
		// ->where('users_ext.sSex','=',0)
			->skip($skip)
			->limit($pageSize)
			->get();

		p($resData->toArray());

		exit();
	}

	// http://yaf.demo.com/demo/showsql
	public function showsqlAction() {
		DB::connection()->enableQueryLog();

		$page = 5;
		$pageSize = 3;

		$skip = ($page - 1) * $pageSize;

		$select = 'id,username, email';
		$resData = User::selectRaw($select)
		// ->leftJoin('users_ext','users.iAutoId','=','users_ext.iUserID')
		// ->where('users.iStatus','=',1)
		// ->where('users_ext.sSex','=',0)
			->skip($skip)
			->limit($pageSize)
			->get();

		p($resData->toArray());

		p(DB::getQueryLog());
		exit();
	}

	public function listAction() {
		$params = [
			'name' => $this->request->getQuery('name'),
			'email' => $this->request->getQuery('email'),
			'page' => (!is_null($this->request->getQuery('page'))) ? $this->request->getQuery('page') : 1,
			'page_size' => (!is_null($this->request->getQuery('page_size'))) ? $this->request->getQuery('page_size') : 3,

		];

		// p($params);
		// $page = 1;
		// $pageSize = 3;

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
		$this->smarty->display('demo/list.tpl', $data);
	}

	public function addAction() {

		if ($this->request->isPost()) {

			print_r($_POST);exit;
		}

		$data = [];
		$this->getView()->display('demo/add.tpl');

	}

	public function modAction() {
		$data = [];
		$this->getView()->display('demo/mod.tpl');
	}

	// https://docs.golaravel.com/docs/5.0/database/
	public function dbsAction() {
		$user = DB::table('users')->first();
		p($user);

		$users = DB::connection('demo')->select("select * from sys_user limit 3");
		p($users);

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


			DB::table('system_menu')->insert([$data]);

			return $this->ajax_success('添加成功！');
		}

		$this->smarty->display('system/addMenu.tpl');
	}


	// public function addRoleAction() {
	// 	$reply = [
	// 		'code' => 200,
	// 		'msg' => '增加成功',
	// 	];

	// 	echo json_encode($reply); exit;
	// }

}
