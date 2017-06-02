<?php

use Illuminate\Database\Capsule\Manager as DB;

class IndexController extends AbstractController
{

    // 默认Action
    public function indexAction()
    {
        // var_dump('fffss');exit;
        // $this->getView()->assign("content", "Hello World");
        // $this->getView()->display('index/index.html');

        // $this->getView()->display('demo/index.html');
        $data = [];
        $this->smarty->display('index/index.tpl', $data);
    }

}
