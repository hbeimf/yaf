<?php
$s_time = strtotime('-100 day') ;
$e_time = strtotime('today') ;
$target_cgi = 'http://10.1.1.113:9200/information/news_statis_report/_search?pretty=true' ;
$ch = curl_init();
$post_data = [
    'filter' => [
        'range' => [
            'timestamp' => [
                'from'  => $s_time,
                'to'    => $e_time
            ]
        ]
    ]
] ;
$post_data = json_encode($post_data) ;
curl_setopt($ch, CURLOPT_URL, $target_cgi ) ;
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
$ret = curl_exec($ch);

var_dump($ret ) ;


// curl -XGET 'http://10.1.1.113:9200/information/news_statis_report/_search?pretty=true' -d '{
//     "query" : { "timestamp" : {"from" : "0","to"   : "1"}}}'




// curl -XGET 'http://10.1.1.113:9200/information/news_statis_report/_search?pretty=true' -d '{"query":{"match":{"actionId":300}}}'

// curl -XGET 'http://10.1.1.113:9200/information/news_statis_report/_search?pretty=true' -d '{"filter":{"range":{"timestamp":{"from":0,"to":1452562234}}}}'