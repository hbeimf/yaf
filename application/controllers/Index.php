<?php

class IndexController extends AbstractController {

	// 默认Action
	public function indexAction() {
		// var_dump('fffss');exit;
		// $this->getView()->assign("content", "Hello World");
		// $this->getView()->display('index/index.html');

		// $this->getView()->display('demo/index.html');

		// var_dump("expression");exit;
		$data = [];
		$this->smarty->display('index/index.tpl', $data);
	}

}
