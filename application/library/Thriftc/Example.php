<?php

use Thrift\Protocol\TBinaryProtocol;
use Thrift\Transport\TSocket;
use Thrift\Transport\THttpClient;
use Thrift\Transport\TBufferedTransport;
use Thrift\Exception\TException;


// use example\ExampleServiceClient;

// http://thrift.apache.org/tutorial/php
// http://thrift.apache.org/tutorial/go

class Thriftc_Example {

	// http://yaf.demo.com/demo/index
	function demo() {
			  $msg = new \example\Message(['id'=> 1, 'text'=>"mike"]);
			  $reply = $this->client->hello($msg);
			  print_r($reply);
	}

	function __construct() {
		$socket = new TSocket($this->_host, $this->_port);
		$this->transport = new TBufferedTransport($socket, 1024, 1024);
		$protocol = new TBinaryProtocol($this->transport);
		$this->client = new \example\ExampleServiceClient($protocol);

		$this->transport->open();
	}

	function __destruct() {
		$this->transport->close();
	}

	public $transport = null;
	public $client = null;

	private $_host = "localhost";
	private $_port = 9009;
}

?>