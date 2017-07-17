<?php


class ZtreeController extends AbstractController {


    public function indexAction() {
        $data = ['js' => 'ztree_index'];
        $this->smarty->display('ztree/index.tpl', $data);
    }


    public function treeAction() {
        $tree = [];

        $tree[] = [
            'id' => 1,
            'pId' => 0,
            'name' => "xxxx",
            'open' => false,
            'isParent' => true, // 控制图标是文件夹
        ];




        $tree[] = [
            'id' => 3,
            'name' => '<small class="zz">zzzz</small>',
            'pId' => 0,
            'open' => false,
        ];

        // $tree[] = [
        //     'id' => 4,
        //     'name' => '<small class="zz">zzzz</small>',
        //     'leader' => 1,
        //     'open' => 0,
        // ];

        // $tree[] = [
        //     'id' => 5,
        //     'name' => '<small class="zz">zzzz</small>',
        //     'leader' => 2,
        //     'open' => 0,
        // ];

        // $tree[] = [
        //     'id' => 6,
        //     'name' => '<small class="zz">zzzz</small>',
        //     'leader' => 3,
        //     'open' => 0,
        // ];

        echo json_encode($tree);exit;

    }


}

