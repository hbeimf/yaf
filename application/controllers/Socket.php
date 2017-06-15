<?php

use Illuminate\Database\Capsule\Manager as DB;

// use User;

// https://docs.golaravel.com/docs/5.0/eloquent/
// orm online doc
class SocketController extends AbstractController {

    // 默认Action
    // http://yaf.demo.com/demo/index
    public function indexAction() {
        $data = [
            'js' => 'socket_index',
        ];


        $this->smarty->display('socket/index.tpl', $data);
    }

    public function socketIOAction() {
        $data = [
            'js' => 'socket_io',
        ];


        $this->smarty->display('socket/socketio.tpl', $data);
    }


    public function wsAction(){
        $data = [
            'js' => 'socket_ws',
        ];


        $this->smarty->display('socket/ws.tpl', $data);
    }



}
