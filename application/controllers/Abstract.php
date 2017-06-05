<?php

/**
 * Class AbstractController
 */
abstract class AbstractController extends Yaf_Controller_Abstract {

	/**
	 * 登录、权限判断、初始化
	 */
	public function init() {
		// header("Content-Type:text/html;charset=utf-8");
		// session_start();

		$this->_init_request_and_smarty();

		$menu = Table_System_Menu::all()->toArray();
		$this->smarty->assign('system_menu', $this->parse_menu($menu));
		$this->smarty->assign('current_menu', $this->current_menu($menu));
	}

	protected function current_menu($menu) {
		$controller_name = strtolower($this->request->getControllerName());
		$action_name = strtolower($this->request->getActionName());


		foreach ($menu as $m) {
			$arr = explode("/",  trim($m['link'], '/'));

			$ctrl = isset($arr[0]) ? strtolower($arr[0]) : 'index';
			$action = isset($arr[1]) ? strtolower($arr[1]) : 'index';

			if ($ctrl == $controller_name && $action == $action_name) {
				return $m;
			}
		}

		return ['id'=>0, 'parent_id'=>0];
	}

	protected function parse_menu($menu) {
		$list = [];
		foreach ($menu as $m) {
			$m['child'] = [];
			if ($m['parent_id'] == 0) {
				foreach ($menu as $mm) {
					if ($m['id'] == $mm['parent_id']) {
						$m['child'][] = $mm;
					}
				}
				$list[] = $m;
			}
		}
		return $list;
	}

	protected function _init_request_and_smarty() {
		$this->request = Yaf_Dispatcher::getInstance()->getRequest();
		$this->smarty = View::getInstance();
	}

	/**
	 * 上传
	 * @param $allowType
	 * @param $savePath
	 * @param bool|false $thumb
	 * @param string $width
	 * @param string $height
	 * @param string $prefix
	 * @param string $maxSize
	 * @param bool|false $remove
	 * @return mixed
	 */
	public function upload($allowType, $savePath, $thumb = false, $width = '', $height = '', $prefix = '', $maxSize = '', $remove = false) {

		$upload = new Upload_Upload();

		// 设置上传文件大小
		$upload->maxSize = empty($maxSize) ? getConfig('upload', 'max_size') : $maxSize;

		if ($thumb) {
			$upload->thumb = $thumb;
			$upload->thumbPrefix = $prefix;
			$upload->thumbMaxWidth = $width;
			$upload->thumbMaxHeight = $height;
			$upload->thumbRemoveOrigin = $remove;
		}

		// 设置上传文件类型
		$upload->allowExts = $allowType;

		// 设置附件上传目录
		$upload->savePath = $savePath;

		// 设置上传文件规则
		$upload->saveRule = 'uniqid';

		if (!$upload->upload()) {
			return ['status' => 0, 'msg' => $upload->getErrorMsg()];
		} else {

			// 取得成功上传的文件信息
			$info = $upload->getUploadFileInfo();
			return ['status' => 1, 'msg' => $info[0]['savename']];
		}
	}

}
