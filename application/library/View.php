<?php

include APP_PATH . '/application/library/Smarty/libs/Smarty.class.php';
include APP_PATH . '/application/library/SmartyPlugins/plugin_funtions.php';

class View {
	private $_smarty = null;
	private function __construct() {
		Smarty::muteExpectedErrors();
		$this->_smarty = new Smarty();

		$root_dir = rtrim($_SERVER['DOCUMENT_ROOT'], 'public');

		$this->_smarty->template_dir = $root_dir . "application/views/";

		$this->_smarty->compile_dir = $root_dir . "cache/compile_dir/";
		$this->_smarty->cache_dir = $root_dir . "application/library/Smarty/cache_dir/";
		$this->_smarty->plugins_dir = $root_dir . "application/library/SmartyPlugins/";

		$this->_smarty->left_delimiter = '{{';
		$this->_smarty->right_delimiter = '}}';

		$this->_smarty->registerPlugin("function", "page", "page");
		$this->_smarty->registerPlugin("function", "queryLog", "queryLog");

	}

	public function getSmarty() {
		return $this->_smarty;
	}

	public function assign($key, $val) {
		$this->_smarty->assign($key, $val);
	}

	public function display($temp = '', $data = array()) {

		if (!empty($data)) {
			foreach ($data as $key => $v) {
				$this->_smarty->assign($key, $v);
			}
		}

		$this->_smarty->display($temp);

	}

	public function fetch($temp = '', $data = array(), $filter = false) {

		if (!empty($data)) {
			foreach ($data as $key => $v) {
				$this->_smarty->assign($key, $v);
			}
		}

		if ($filter) {
			$_strip_search = array(
				"![\t ]+$|^[\t ]+!m", // remove leading/trailing space chars
				'%[\r\n]+%m', // remove CRs and newlines
			);
			$_strip_replace = array(
				'',
				'',
			);
			return preg_replace($_strip_search, $_strip_replace, $this->_smarty->fetch($temp));
		} else {
			return $this->_smarty->fetch($temp);
		}
	}

	private static $_instance = null;

	private function __clone() {
	}

	public static function getInstance() {
		if (self::$_instance === null) {
			self::$_instance = new self();
		}
		return self::$_instance;
	}

}

?>
