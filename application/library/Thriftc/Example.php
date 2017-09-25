<?php

use Thrift\Protocol\TBinaryProtocol;
use Thrift\Transport\TSocket;
use Thrift\Transport\THttpClient;
use Thrift\Transport\TBufferedTransport;
use Thrift\Exception\TException;


use example\ExampleServiceClient;

// http://thrift.apache.org/tutorial/php

class Thriftc_Example {


	function demo() {
		try {
			  // if (array_search('--http', $argv)) {
			  //   $socket = new THttpClient('localhost', 8080, '/php/PhpServer.php');
			  // } else {
			    $socket = new TSocket('localhost', 9009);
			  // }
			  $transport = new TBufferedTransport($socket, 1024, 1024);
			  $protocol = new TBinaryProtocol($transport);
			  // $client = new \tutorial\CalculatorClient($protocol);
			  $client = new \example\ExampleServiceClient($protocol);

			  $transport->open();



			  // $client->ping();
			  $msg = new \example\Message(['id'=> 1, 'text'=>"mike"]);
			  $reply = $client->hello($msg);
			  print_r($reply);
			

			  $transport->close();

			} catch (TException $tx) {
			  print 'TException: '.$tx->getMessage()."\n";
			}
	}




}

?>