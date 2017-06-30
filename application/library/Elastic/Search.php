<?php

class Elastic_Search{

    public function demo() {
        $this->update_mapping();
        // $this->create_mapping_001();
    }


    // http://localhost:9200/db_001/table_001/_mapping?pretty
    // http://blog.csdn.net/zpf336/article/details/49619601
    // 更新mapping
    // 注意只能新增加字段，已经存在的字段是不允许修改的，
    public function update_mapping() {
        // Set the index and type
        $params['index'] = 'db_001';
        $params['type']  = 'table_001';

        // Adding a new type to an existing index
        $myTypeMapping2 = array(
            '_source' => array(
                'enabled' => true
            ),
            'properties' => array(
                'first_name' => array(
                    'type' => 'string',
                    'analyzer' => 'standard'
                ),
                'age' => array(
                    'type' => 'integer'
                )
            )
        );
        $params['body'][$params['type']] = $myTypeMapping2;

        // Update the index mapping
        $this->_client->indices()->putMapping($params);
    }









    // http://blog.csdn.net/zhuzhenyu307/article/details/37908357
    // index为db,type为table
    // mapp就相当与给table分配字段以及属性

    // http://blog.csdn.net/yw5201314/article/details/52856387
    // 查看mapping
    // localhost:9200/db_001/table_001/_mapping?pretty
    // localhost:9200/website/blog/_mapping?pretty
    //
    // {
    //   "test_index" : {
    //     "mappings" : {
    //       "ad_type_test" : {
    //         "properties" : {
    //           "content" : {
    //             "type" : "string",
    //             "analyzer" : "ik"
    //           },
    //           "tags" : {
    //             "type" : "string",
    //             "analyzer" : "ik"
    //           }
    //         }
    //       }
    //     }
    //   }
    // }
    // 创建及查看mapping
    public function create_maping(){
        $index_params=[
            'index'=>'db_001',//需要被设置的索引名
            'body'=>[
                // 'settings'=>[
                //     'analysis'=>[
                //         'analyzer'=>[
                //             'my_analyzer'=>[
                //                 'tokenizer'=>'my_tokenizer'
                //             ]
                //         ],
                //         'tokenizer'=>[//定义分词规则
                //             'my_tokenizer'=>[
                //                 'type'=>'pattern',
                //                 'pattern'=>'&' //按照指定的符号分词
                //             ]
                //         ],
                //     ]
                // ],
                'mappings'=>[
                    'table_001'=>[ //被设置的索引的TYPE
                        'properties'=>[
                            'tags'=>[ //被设置的索引中_source中的字段
                                'type' =>"string",
                                'analyzer'=>'ik',//设置创建索引的时候按照定义的分析格式分词
                                'search_analyzer'=>'ik'//设置查询的条件也按照定义的分词格式分词
                            ],
                            'content'=>[ //被设置的索引中_source中的字段
                                'type' =>"string",
                                'analyzer'=>'ik',//设置创建索引的时候按照定义的分析格式分词
                                'search_analyzer'=>'ik'//设置查询的条件也按照定义的分词格式分词
                            ],

                        ]
                    ]
                ]
            ]
        ];

        $this->_client->indices()->create($index_params);//执行创建
    }






    public function __construct() {
        //连接elasticsearch 实例
        $this->_client =  Elasticsearch\ClientBuilder::create()->setHosts(['127.0.0.1'])->build();
    }

    private $_client = null;

}
