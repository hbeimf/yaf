<?php

class IndexController extends AbstractController {

	// 默认Action
	public function indexAction() {
		// echo 'hello world';exit;

        $data = [];
        $this->smarty->display('index/index.tpl', $data);
	}

}
