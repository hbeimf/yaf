<?php

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


            $_SESSION["username"] = $data['username'];
            $_SESSION['passwd'] = md5($data['password']);

            return $this->ajax_success('登录成功！');

        }

        $this->smarty->display('index/login.tpl');
    }

}
