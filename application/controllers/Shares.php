<?php

// use Illuminate\Database\Capsule\Manager as DB;

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
            'category' => (!is_null($this->request->getQuery('category'))) ? $this->request->getQuery('category') : '',
        ];

        $skip = ($params['page'] - 1) * $params['page_size'];


        $select = 'm_gp_list.id, m_gp_list.code, m_gp_list.name,m_gp_list.category,
                    b.last_time, b.last_price, b.last_yid, b.all_years';

        $account_obj = Table_Gp_List::selectRaw($select);
        if (trim($params['name']) != '') {
            $account_obj->where('m_gp_list.name', 'like', "%{$params['name']}%");
        }

        if (trim($params['category']) != '') {
            // $account_obj->where("FIND_IN_SET('{$params['category']}', m_gp_list.category)");
            $account_obj->where("m_gp_list.category", 'like', "%{$params['category']}%");
        }

        $count = $account_obj->count();
        $users = $account_obj
                            // ->leftJoin('m_gp_list as b', 'b.code', '=', 'gp_history.code')
                            ->leftJoin('parse_status as b', 'b.code', '=', 'm_gp_list.code')
                            ->skip($skip)
                            ->limit($params['page_size'])
                            ->orderBy('b.last_yid', 'asc')
                            ->orderBy('b.last_price', 'asc')

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

        $this->smarty->getSmarty()->registerPlugin("function", "category_name", "category_name");
        $this->smarty->display('shares/list.tpl', $data);
    }


    public function addAction() {
        $code = trim($this->request->getQuery('code'));

        if ($this->request->isPost()) {
            $id =  trim($this->request->getPost('id'));

            $data = [
                'code' => trim($this->request->getPost('code')),
                'name' => trim($this->request->getPost('name')),
                'category' => $this->request->getPost('category'),
            ];

            if ($data['code'] == '') {
                return $this->ajax_error('code不能为空');
            }

            if ($data['name'] == '') {
                return $this->ajax_error('名称不能为空');
            }

            if (empty($data['category'])) {
                return $this->ajax_error('分类不能为空');
            } else {
                $data['category'] = implode(",", $data['category']);
            }

            if ($id != '') {
                Table_Gp_List::where('id', '=', $id)->update($data);
                return $this->ajax_success('更新成功！');
            } else {
                Table_Gp_List::forceCreate($data);
                return $this->ajax_success('添加成功！');
            }


        }

        $data = [];
        if ($code != '') {
            $gp = new Table_Gp_List();
            $row = $gp->findByCode($code);
            $row['category'] = explode(",", $row['category']);
            $data['row'] = $row;
        }

        $this->smarty->display('shares/add.tpl', $data);
    }


    public function heapAction() {
        $code = trim($this->request->getQuery('code'));

        $data = [
            'code' => $code,
        ];
        $this->smarty->display('shares/heap.tpl', $data);
    }

    public function detailAction() {
        $code = trim($this->request->getQuery('code'));

        $data = [
            'code' => $code,
        ];
        $this->smarty->display('shares/detail.tpl', $data);
    }


    public function hjAction() {
        $code = trim($this->request->getQuery('code'));
        $row = Table_Gp_Json::selectRaw('*')->where('code', '=', $code)->get()->toArray();
        // print_r($row);exit;

        // $d = json_decode($row[0]['data'], true);

        // print_r($d);exit;

        echo $row[0]['data'];exit;
    }



    public function jsonAction() {
        $code = trim($this->request->getQuery('code'));

        $select = 'closePrice, time';
        $obj = Table_Gp_History::selectRaw($select);
        $obj->where('code', '=', $code);


        // $count = $account_obj->count();
        $history = $obj->orderBy('time', 'desc')->get();

        $data = [];

        foreach($history as $h) {
            $data[] = [
                'name'=> '',
                'value' => [
                    date("Y/m/d", $h['time']),
                    $h['closePrice']
                ],
            ];
        }

        $table = new Table_Gp_List();
        $row = $table->findByCode($code);


        $reply = [
            'name' => $row['name'],
            'code' => $code,
            'data' => $data,
        ];

        echo json_encode($reply);

        exit;

    }





}
