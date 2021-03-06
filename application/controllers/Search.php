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

        $this->test();
        // $this->demo1();
    }


    private function test() {
        // $es = new Elastic_Search();
        $es = new Elastic_Mapping();
        $es->demo();
    }





    private function demo1(){

        // $this->create1();
        // $this->search2();
        // $this->update1();
        // $this->search2();

        // $this->delete();
        $this->search0();


    }

    private function update1() {
        // $client = new Elasticsearch\Client();
        $client =  Elasticsearch\ClientBuilder::create()->setHosts(['127.0.0.1'])->build();


        $params = [
            'index' => 'website',
            'type' => 'blog',
            // 'id' => '7',
            // 'refresh' => true,
            'body' => [
                'query' => array(
                    'match' => array(
                        '_id' => "7",
                    ),
                ),
                'script' => [
                    'inline' => "ctx._source.content = 'XXX'",
                ],
            ]
        ];

        // Update doc at /my_index/my_type/my_id
        $response = $client->updateByQuery($params);
    }



    private function update() {
        // $client = new Elasticsearch\Client();
        $client =  Elasticsearch\ClientBuilder::create()->setHosts(['127.0.0.1'])->build();


        $params = [
            'index' => 'website',
            'type' => 'blog',
            'id' => '7',
            'refresh' => true,
            'body' => [
                'doc' => [
                    'content' => 'abcabcabcabc'
                ]
            ]
        ];

        // Update doc at /my_index/my_type/my_id
        $response = $client->update($params);
    }


    private function delete() {
        // $client = new Elasticsearch\Client();
        $client =  Elasticsearch\ClientBuilder::create()->setHosts(['127.0.0.1'])->build();

        // http://www.cnblogs.com/amuge/p/6076232.html
        // http://www.cnblogs.com/life_lt/p/6122767.html
        $params = array(
                    'index' => 'website',
                    'type' => 'blog',
                    'id'=>'AVzjFvqryEaANjW4vehL',
                );
        $resp = $client->delete($params);

        p($resp);
    }


    private function create() {
        // $client = new Elasticsearch\Client();
        $client =  Elasticsearch\ClientBuilder::create()->setHosts(['127.0.0.1'])->build();

        // http://www.cnblogs.com/amuge/p/6076232.html
        // http://www.cnblogs.com/life_lt/p/6122767.html
        $params = array(
                    'index' => 'website',
                    'type' => 'blog',
                    // 'id' => 7,
                    'body' => array(
                        'the_id' => 100,
                        'title' => 'ElasticSearch-PHP之使用二',
                        'content' => '有关于ElasticSearch在PHP下的扩展使用方法之谈',
                        'create_time' => '2016-11-18 08:00:00',
                    )
                );
        $resp = $client->index($params);

        p($resp);
    }

    private function create1() {
        // $client = new Elasticsearch\Client();
        $client =  Elasticsearch\ClientBuilder::create()->setHosts(['127.0.0.1'])->build();

        // http://www.cnblogs.com/amuge/p/6076232.html
        // http://www.cnblogs.com/life_lt/p/6122767.html
        $params = array(
                    'index' => 'website',
                    'type' => 'blog',
                    // 'id' => 7,
                    'body' => array(
                        'the_id' => 100,
                        'title' => '它提供了一个分布式多用户能力的全文搜索引擎',
                        'content' => 'ElasticSearch是一个基于Lucene的搜索服务器。它提供了一个分布式多用户能力的全文搜索引擎，基于RESTful web接口。Elasticsearch是用Java开发的',
                        'create_time' => '2016-11-18 08:00:00',
                    )
                );
        $resp = $client->index($params);

        p($resp);
    }


    private function search2() {
        // $client = new Elasticsearch\Client();

        // $hosts = ;
        $client =  Elasticsearch\ClientBuilder::create()->setHosts(['127.0.0.1'])->build();
         $params = array(
            'index' => 'website',
            'type' => 'blog',
            'body' => array(
                'query' => array(
                    'match' => array(
                        '_id' => "7",
                    ),
                ),
            ),
            // 'from' => 3,
            // 'size'=> 2,
        );

        $resp = $client->search($params);

        p($resp);
    }




    private function search1() {
        // $client = new Elasticsearch\Client();
        $client =  Elasticsearch\ClientBuilder::create()->setHosts(['127.0.0.1'])->build();
         $params = array(
            'index' => 'website',
            'type' => 'blog',
            'body' => array(
                'query' => array(
                    'match' => array(
                        'the_id' => 100,
                    ),
                ),
            ),
            // 'from' => 3,
            // 'size'=> 2,
        );

        $resp = $client->search($params);

        p($resp);
    }



    private function search() {
        // $client = new Elasticsearch\Client();
        $client =  Elasticsearch\ClientBuilder::create()->setHosts(['127.0.0.1'])->build();
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


     private function search0() {
        // $client = new Elasticsearch\Client();
        $client =  Elasticsearch\ClientBuilder::create()->setHosts(['127.0.0.1'])->build();
         $params = array(
            'index' => 'website',
            'type' => 'blog',
            'body' => array(
                'query' => array(
                    // 'bool'=> [
                        'match' => array(
                            'title' => '搜索引擎',
                             // "analyzer" => "ik"
                        ),
                    // ],
                ),
            ),
            'from' => 1,
            'size'=> 200,
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

    // curl -XPOST '127.0.0.1:9200/website/_analyze?analyzer=ik'

    // curl -XPOST '127.0.0.1:9200/website/_analyze?analyzer=standard' -d '{text:"分布式"}'

}
