<?php

class IndexController extends AbstractController {

	// 默认Action
	public function indexAction() {
		$data = [];
		$this->smarty->display('index/index.tpl', $data);
	}

}
