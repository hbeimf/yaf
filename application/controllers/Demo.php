<?php

use Illuminate\Database\Capsule\Manager as DB;
// use User;

// https://docs.golaravel.com/docs/5.0/eloquent/
// orm online doc
class DemoController extends AbstractController
{

    // 默认Action
    // http://yaf.demo.com/demo/index
    public function indexAction()
    {
        $this->getView()->assign("content", "Hello World");
        $this->getView()->display('index/index.html');
    }


    // http://yaf.demo.com/demo/insert
    public function insertAction() {

        $name = 'xiaomin'.time();
        $email = 'xiaomin@foxmail.com'.time();

        DB::table('users')->insert([
           array('username' => $name,
            'email' => $email,
            'created_at'=>date("Y-m-d H:i:s", time()),
            'updated_at'=>date("Y-m-d H:i:s", time()))
        ]);

        var_dump('insert');
        exit;
    }

    // http://yaf.demo.com/demo/delete
    public function deleteAction() {
        if ($user = User::find(2)) {
            var_dump($user->delete());
        } else {
            echo "xx <br /> ";
        }


        $affectedRows = User::where('id', '<=', 4)->delete();
        var_dump($affectedRows);
        exit;
    }

    // http://yaf.demo.com/demo/update
    public function updateAction(){
        $user = User::find(6);

        $user->email = 'john@foo.com';

        var_dump($user->save());

        exit;
    }

    // http://yaf.demo.com/demo/select
    public function selectAction(){
        $user = DB::table('users')->where('username', 'xxx')->first();
        p($user);


        DB::table('users')->chunk(100, function($users)
        {

           foreach ($users as $user)
           {
               echo $user['username']."<br />";
           }
           return false;
        });

        $name = DB::table('users')->lists('username', 'email');
        p($name);

        $users = DB::table('users')->select('username as name', 'email')->get();
        p($users);

        $admin = DB::table('users')
               ->whereIdAndEmail(1, 'xxx@foxmail.com')
               ->first();
        p($admin);

        try {
           DB::beginTransaction();
           $users = DB::table('users')
                       ->select('username as name', 'email')
                       ->where('username', 'xxx')
                       ->orwhere('username', 'overtrue')
                       ->get();
           DB::commit();
           p($users);
        } catch (Exception $e) {
           echo $e->getMessage();
        }

        exit;
    }

    // http://www.cnblogs.com/brudeke/p/4227711.html
    // http://yaf.demo.com/demo/page
    // SELECT
    //  users.sNmame,
    //  users.iCreateTime,
    //  users_ext.iAge,
    //  users_ext.sSex
    // FROM
    //  users
    // LEFT JOIN users_ext ON users.iAutoId = users_ext.iUserID
    // WHERE
    //   users.iStatus = 1
    // AND users_ext.sSex = 0
    // ORDER BY
    //   users.iCreateTime
    // LIMIT 0,1
    public function pageAction() {
         // $select = 'users.sNmame,users.iCreateTime,users_ext.iAge,users_ext.sSex';
         // $resData = User::selectRaw($select)
         //            ->leftJoin('users_ext','users.iAutoId','=','users_ext.iUserID')
         //            ->where('users.iStatus','=',1)
         //            ->where('users_ext.sSex','=',0)
         //            ->skip(0)
         //            ->limit(1)
         //            ->get();
         // var_dump($resData->toArray());

        $page = 5;
        $pageSize = 3;

        $skip = ($page - 1) * $pageSize;

        $select = 'id,username, email';
         $resData = User::selectRaw($select)
                    // ->leftJoin('users_ext','users.iAutoId','=','users_ext.iUserID')
                    // ->where('users.iStatus','=',1)
                    // ->where('users_ext.sSex','=',0)
                    ->skip($skip)
                    ->limit($pageSize)
                    ->get();

         p($resData->toArray());


         exit();
    }



}
