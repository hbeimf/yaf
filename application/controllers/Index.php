<?php

use Illuminate\Database\Capsule\Manager as DB;

class IndexController extends AbstractController {

	// 默认Action
	public function indexAction() {
        $this->smarty->display('index/index.tpl');
	}

    public function loginAction() {

        if($this->request->isPost()){
            $data = [

                'username' => $this->request->getPost('username'),
                'password' => $this->request->getPost('password'),
            ];

            // check here
            $account = DB::table('system_account')
                ->where('account_name', $data['username'])
                ->where('passwd', md5(trim($data['password'])))
                ->first();


            if (!is_null($account)) {
                $_SESSION["username"] = $data['username'];
                $_SESSION['passwd'] = md5($data['password']);

                return $this->ajax_success('登录成功！');
            }

            return $this->ajax_error('登录失败！');
        }

        $this->smarty->display('index/login.tpl');
    }

    public function logoutAction(){
        unset($_SESSION['username']);
        unset($_SESSION['passwd']);

        $this->redirect("/index/login");
    }

}
