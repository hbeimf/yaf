<?php

use Illuminate\Database\Capsule\Manager as DB;

// https://docs.golaravel.com/docs/5.0/eloquent/
class SharesController extends AbstractController {

    // 历史数据
    public function indexAction() {
        $params = [
            'name' => $this->request->getQuery('name'),
            'page' => (!is_null($this->request->getQuery('page'))) ? $this->request->getQuery('page') : 1,
            'page_size' => (!is_null($this->request->getQuery('page_size'))) ? $this->request->getQuery('page_size') : 3,
        ];

        $skip = ($params['page'] - 1) * $params['page_size'];


        $select = 'gp_history.id, openPrice, closePrice, highPrice, lowerPrice, str_time, b.code, b.name';
        $account_obj = Table_Gp_History::selectRaw($select);
        if (trim($params['name']) != '') {
            $account_obj->where('code', 'like', "%{$params['name']}%");
        }

        $count = $account_obj->count();
        $users = $account_obj
                            ->leftJoin('m_gp_list as b', 'b.code', '=', 'gp_history.code')
                            ->skip($skip)
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


    //列表
    public function listAction() {
        $params = [
            'name' => trim($this->request->getQuery('name')),
            'page' => (!is_null($this->request->getQuery('page'))) ? $this->request->getQuery('page') : 1,
            'page_size' => (!is_null($this->request->getQuery('page_size'))) ? $this->request->getQuery('page_size') : 10,
        ];

        $skip = ($params['page'] - 1) * $params['page_size'];


        $select = 'id, code, name';

        $account_obj = Table_Gp_List::selectRaw($select);
        if (trim($params['name']) != '') {
            $account_obj->where('name', 'like', "%{$params['name']}%");
        }

        $count = $account_obj->count();
        $users = $account_obj
                            // ->leftJoin('m_gp_list as b', 'b.code', '=', 'gp_history.code')
                            ->skip($skip)
                            ->limit($params['page_size'])
                            ->get();

        $totalPage = ceil($count / $params['page_size']);

        $data = [
            // 'js' => 'system_role',
            'js' => 'shares_detail',
            'rand' => time(),
            'users' => $users->toArray(), // 当前页记录
            'count' => $count, // 记录条数
            'page' => $params['page'], // 当前页
            'totalPage' => $totalPage, // 总页数
            'params' => $params,
        ];

        $this->smarty->display('shares/list.tpl', $data);




    }

    public function detailAction() {
        $code = trim($this->request->getQuery('code'));


        $data = [

        ];
        $this->smarty->display('shares/detail.tpl', $data);
    }


}
