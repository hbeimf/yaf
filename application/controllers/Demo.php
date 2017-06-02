<?php

use Illuminate\Database\Capsule\Manager as DB;

class DemoController extends AbstractController
{

    // 默认Action
    // http://yaf.demo.com/demo/index
    public function indexAction()
    {

        $user = DB::table('users')->where('username', 'molaifeng1')->first();
        var_dump($user);exit;







//        $test = new UserModel();
//        $data = $test->getInfo();
//        print_r($data);
//exit;
//        $this->getView()->assign("content", "Hello World");
        $this->getView()->display('layout/index.html');
    }

    // http://yaf.demo.com/demo/test
    public function testAction() {
        var_dump("test action");exit;
    }


    // http://yaf.demo.com/demo/select
    public function selectAction(){
        $user = DB::table('users')->where('username', 'molaifeng1')->first();
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
               ->whereIdAndEmail(1, 'molaifeng1@foxmail.com')
               ->first();
        p($admin);

        try {
           DB::beginTransaction();
           $users = DB::table('users')
                       ->select('username as name', 'email')
                       ->where('username', 'molaifeng1')
                       ->orwhere('username', 'overtrue')
                       ->get();
           DB::commit();
           p($users);
        } catch (Exception $e) {
           echo $e->getMessage();
        }

        exit;
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

}
