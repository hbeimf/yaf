<?php

use Illuminate\Database\Capsule\Manager as DB;

// use User;

// https://docs.golaravel.com/docs/5.0/eloquent/
// orm online doc
class SearchController extends AbstractController {

    // 默认Action
    // http://yaf.demo.com/search/index
    public function indexAction() {



        $this->search();


    }


    private function create() {
        $client = new Elasticsearch\Client();

        // http://www.cnblogs.com/amuge/p/6076232.html
        // $host = '127.0.0.1';
        $params = array(
                    'index' => 'website',
                    'type' => 'blog',
                    'id' => 7,
                    'body' => array(
                        'title' => 'ElasticSearch-PHP之使用二',
                        'content' => '有关于ElasticSearch在PHP下的扩展使用方法之谈',
                        'create_time' => '2016-11-18 08:00:00',
                    ),
                );
        $resp = $client->index($params);

        p($resp);
    }



    private function search() {
        $client = new Elasticsearch\Client();
         $params = array(
            'index' => 'website',
            'type' => 'blog',
            'body' => array(
                'query' => array(
                    'match' => array(
                        'title' => 'elasticsearch php extends'
                    ),
                ),
            ),
        );

        $resp = $client->search($params);

        p($resp);
    }





    // public function socketIOAction() {
    //     $data = [
    //         'js' => 'socket_io',
    //     ];


    //     $this->smarty->display('socket/socketio.tpl', $data);
    // }


    // public function wsAction(){
    //     $data = [
    //         'js' => 'socket_ws',
    //     ];


    //     $this->smarty->display('socket/ws.tpl', $data);
    // }



}
