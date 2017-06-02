<?php

use Illuminate\Database\Capsule\Manager as DB;

class IndexController extends AbstractController
{

    // 默认Action
    public function indexAction()
    {
        $this->getView()->assign("content", "Hello World");
        $this->getView()->display('index/index.html');
    }

}
