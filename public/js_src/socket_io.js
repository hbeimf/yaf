//动态异步加载js


require([
    'base',
    'moment',
    'protobuf',
    'base64',
    'socket.io'
],function(){

    var userName = 'user' + Math.floor((Math.random()*1000)+1);

    var socket =  io.connect();

    socket.on('connect', function() {
        output('<span class="connect-msg">Client has connected to the server!</span>');
    });

    socket.on('message', function(data) {
        if (data instanceof Object) {
            if (data.userName == 'image') {
                // <img src="data:image/png;base64,这里放字符"/>
                var con = '<img src="data:image/'+data.type+';base64,'+data.message+'"/>';
                output('<span class="username-msg">' + data.userName + ':</span> ' + con + '<br /><br />');
            } else {
                var con = JSON.stringify(data);
                output(con);
            }

        } else {
            output(data);
        }
    });

    socket.on('disconnect', function() {
        output('<span class="disconnect-msg">The client has disconnected!</span>');
    });



    function output(message) {
        var currentTime = "<span class='time'>" +  moment().format('HH:mm:ss.SSS') + "</span>";
        var element = $("<div>" + currentTime + "<font style=\"color:red;\">=></font>  " + message + "</div>");
        $('#console').prepend(element);
    }

    function sendString() {
        var message = 'send string';
        socket.send(message);
    }

    function sendWork() {
        var jsonObject = {
                            cmd:'readMysql',
                            userName: userName,
                            message: '耗时任务'
                        };

        socket.json.send(jsonObject);
    }

    $(function () {






        console.log('socket io!');
        $('#request').click(function(){
            console.log('request');
            sendString();
            // SendWork();
        });

        $('#clearConsole').click(function (){
            $('#console').html('');
        });

    });
});






