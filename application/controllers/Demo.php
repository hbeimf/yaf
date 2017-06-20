<?php

use Illuminate\Database\Capsule\Manager as DB;

// use User;

// https://docs.golaravel.com/docs/5.0/eloquent/
// orm online doc
class DemoController extends AbstractController {

	// 默认Action
	// http://yaf.demo.com/demo/index
	public function indexAction() {
		// $this->getView()->assign("content", "Hello World");
		$this->getView()->display('demo/index.html');
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


	// public function downloadAction() {
	// 	set_time_limit(0);
 //        ini_set('memory_limit', '1024M');

 //        header('Content-type: text/csv; charset=gbk');
 //        header('Content-Disposition: attachment; filename=' . str_replace(' ', '_', $export->filename));
 //        header('Content-Transfer-Encoding: chunked'); // changed to chunked
 //        header('Content-Encoding: gbk');
 //        header('Content-Transfer-Encoding: binary');
 //        header('Expires: 0');
 //        header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
 //        header('Pragma: public');
 //        header('Content-Length: ' . $export->size);
 //        readfile($filepath);
 //        exit;
	// }

}
