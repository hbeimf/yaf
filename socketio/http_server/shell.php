<?php

// 验证用php启动erl项目　^_^


function start() {
    $shell =  dirname(__FILE__)."/_build/default/rel/http_server/bin/http_server start";
    if (function_exists('exec')) {
        exec($shell);
        echo $shell."\n";
        echo "started ...\n";

    } else {
        echo "function exec not exists !! \n";
    }
}


function stop() {
    $shell =  dirname(__FILE__)."/_build/default/rel/http_server/bin/http_server stop";
    if (function_exists('exec')) {
        exec($shell);
        echo $shell."\n";
        echo "stoped ...\n";

    } else {
        echo "function exec not exists !! \n";
    }
}



if (isset($argv[1]) && $argv[1] == 'start') {
    start();
} elseif (isset($argv[1]) && $argv[1] == 'stop') {
    stop();
}

?>
