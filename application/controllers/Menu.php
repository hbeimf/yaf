<?php

use Illuminate\Database\Capsule\Manager as DB;

class SystemController extends AbstractController {


    public function indexAction() {
        $menu = [
            [
                'id' => 1,
                'menu_name' => '系统管理',
                'parent_id' => 0,
                'link' => '',
                'icon' => '',
                'status' => 1,
                'note' => ''
            ],
            [
                'id' => 2,
                'menu_name' => '导航管理',
                'parent_id' => 1,
                'link' => '/system/index/',
                'icon' => '',
                'status' => 1,
                'note' => '',
            ],
            [
                'id' => 3,
                'menu_name' => '账号管理',
                'parent_id' => 1,
                'link' => '/system/account/',
                'icon' => '',
                'status' => 1,
                'note' => '',
            ],
            [
                'id' => 4,
                'menu_name' => '权限管理',
                'parent_id' => 1,
                'link' => '/system/role/',
                'icon' => '',
                'status' => 1,
                'note' => '',
            ],
        ];

        DB::table('system_menu')->insert($menu);

        p($menu);
    }

}
