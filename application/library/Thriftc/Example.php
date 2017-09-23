<?php
use Thrift\Protocol\TBinaryProtocol;
use Thrift\Protocol\TMultiplexedProtocol;
use Thrift\Transport\TSocket;
use Thrift\Transport\THttpClient;
use Thrift\Transport\TBufferedTransport;
use Thrift\Exception\TException;
use com\penngo\RegisterServiceClient;
use com\penngo\LoginServiceClient;

class Thriftc_Example {


	function demo() {
		try {
		    // if (array_search('--http', $argv)) {
		    //     //$socket = new THttpClient('localhost', 8080, '/php/PhpServer.php');
		    // } else {
		    //     $socket = new TSocket('localhost', 7911);
		    // }

		    $socket = new TSocket('localhost', 7911);
		    // $transport = new TBufferedTransport($socket, 1024, 1024);
		    // $protocol = new TBinaryProtocol($transport);
		    // $loginProtocol = new TMultiplexedProtocol($protocol, "LoginService");
		    // $registerProtocol = new TMultiplexedProtocol($protocol, "RegisterService");
		    // $loginClient = new LoginServiceClient($loginProtocol);
		    // $registerClient = new RegisterServiceClient($registerProtocol);
		    // $transport->open();
		    // $user = $loginClient->login('penngo', '123');
		    // print "user===={$user->id} {$user->name} \n";
		    
		    // $user = $registerClient->createUser('test', '123456');
		    // print "user===={$user->id} {$user->name} \n";
		    
		    $transport->close();
		} catch (TException $tx) {
		    print 'TException: '.$tx->getMessage()."\n";
		    print 'TException: '.$tx->getTraceAsString()."\n";
		}
	}




}

?>