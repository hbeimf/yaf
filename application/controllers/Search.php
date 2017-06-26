<?php

use Illuminate\Database\Capsule\Manager as DB;

// use User;

// https://docs.golaravel.com/docs/5.0/eloquent/
// orm online doc
// http://localhost:9200/_plugin/head/
class SearchController extends AbstractController {

    // 默认Action
    // http://yaf.demo.com/search/index
    public function indexAction() {


        // $this->create();
        $this->search();


    }


    private function create() {
        $client = new Elasticsearch\Client();

        // http://www.cnblogs.com/amuge/p/6076232.html
        // http://www.cnblogs.com/life_lt/p/6122767.html
        $params = array(
                    'index' => 'website',
                    'type' => 'blog',
                    // 'id' => 7,
                    'body' => array(
                        'title' => 'ElasticSearch-PHP之使用二',
                        'content' => '有关于ElasticSearch在PHP下的扩展使用方法之谈',
                        'create_time' => '2016-11-18 08:00:00',
                    )
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
                        'title' => 'elasticsearch php extends',
                    ),
                ),
            ),
            'from' => 3,
            'size'=> 2,
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
