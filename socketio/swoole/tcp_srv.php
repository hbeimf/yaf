<?php

$host = "127.0.0.1";
$port = 9517 ;
$serv = new swoole_server( $host , $port );
$serv->set(array(
    'worker_num' => 4,   //工作进程数量
    'daemonize' => true, //是否作为守护进程
));
$serv->on('connect', function ($serv, $fd){
    log_1( 'connect ') ;
    echo "Client:Connect.\n";
});
$serv->on('receive', function ($serv, $fd, $from_id, $data) {
    log_1( 'receive ') ;
    $serv->send($fd, 'Swoole: '.$data);
    $serv->close($fd);
});

$serv->on('Start', function($serv){
    log_1( 'Start ') ;
    echo $serv->master_pid . '------' . $serv->manager_pid;
    $serv_name = $serv->setting['process_name'] . '_Master';
    swoole_set_process_name( $serv_name );
});

$serv->on('ManagerStart', function($serv){
    log_1( 'onManagerStart ') ;
    echo "onManagerStart\n" ;
});

$serv->on('WorkerStart', function ($serv, $worker_id){
    log_1( 'WorkerStart ') ;
    global $argv;
    if($worker_id >= $serv->setting['worker_num']) {
        swoole_set_process_name("php {$argv[0]} task worker {$worker_id}");
    } else {
        swoole_set_process_name("php {$argv[0]} event worker");
    }
});

$serv->on('close', function ($serv, $fd) {
    echo "Client: Close.\n";

    log_1( 'onClose ') ;
});

$serv->start();



function log_1( $msg ) {
    file_put_contents('./tcp_srv.log_1', $msg . "\n", FILE_APPEND ) ;
}

