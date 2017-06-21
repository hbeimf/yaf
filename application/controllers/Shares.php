<?php

use Illuminate\Database\Capsule\Manager as DB;

// https://docs.golaravel.com/docs/5.0/eloquent/
class SharesController extends AbstractController {

    public function indexAction() {
        $params = [
            'name' => $this->request->getQuery('name'),
            'page' => (!is_null($this->request->getQuery('page'))) ? $this->request->getQuery('page') : 1,
            'page_size' => (!is_null($this->request->getQuery('page_size'))) ? $this->request->getQuery('page_size') : 3,
        ];

        $skip = ($params['page'] - 1) * $params['page_size'];


  //         `openPrice` float(9,3) DEFAULT '0.000' COMMENT '开盘价',
  // `closePrice` float(9,3) DEFAULT '0.000' COMMENT '收盘价',
  // `highPrice` float(9,3) DEFAULT '0.000' COMMENT '当天最高价',
  // `lowerPrice` float(9,3) DEFAULT '0.000' COMMENT '当天最低价',
  // `time` int(11) DEFAULT '0' COMMENT '时间',
  // `str_time` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'str_time',
  // `code` var

        $select = 'id, openPrice, closePrice, highPrice, lowerPrice, str_time, code';
        $account_obj = Table_Gp_History::selectRaw($select);
        if (trim($params['name']) != '') {
            $account_obj->where('code', 'like', "%{$params['name']}%");
        }

        $count = $account_obj->count();
        $users = $account_obj->skip($skip)
                            ->limit($params['page_size'])
                            ->get();

        $totalPage = ceil($count / $params['page_size']);

        $data = [
            // 'js' => 'system_role',
            'rand' => time(),
            'users' => $users->toArray(), // 当前页记录
            'count' => $count, // 记录条数
            'page' => $params['page'], // 当前页
            'totalPage' => $totalPage, // 总页数
            'params' => $params,
        ];

        // $data['roles'] = Table_System_Role::all()->toArray();

        // $this->smarty->getSmarty()->registerPlugin("function", "role_name", "role_name");
        // $this->smarty->getSmarty()->registerPlugin("function", "acount_menu", "acount_menu");

        $this->smarty->display('shares/index.tpl', $data);

    }


}
