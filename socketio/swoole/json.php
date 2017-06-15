<?php

$result = file_get_contents('/tmp/banner.data');
// var_dump( $result ) ;
$result = json_decode( $result , true ) ;
$hits = $result['hits']['hits'] ;


foreach( $hits as $val ) {
  print_r( $val ) ;
}

print_r( $hits ) ;