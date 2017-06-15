//动态异步加载js


require([
    'base',
    'moment',
    'protobuf'
],function(){

    var websocket;

    function init() {
        if(!("WebSocket" in window)){
            output('<span style="color: red;">Ws websockets are not supported </span>');

        } else {
            output('<span style="color: green;">WS websockets are supported </span>');
            connect();
        };
    };

    function connect()
    {
        var wsHost = "ws://" + window.location.host + "/ws";
        websocket = new WebSocket(wsHost);

        websocket.onopen = function(evt) { onOpen(evt) };
        websocket.onclose = function(evt) { onClose(evt) };
        websocket.onmessage = function(evt) { onMessage(evt) };
        websocket.onerror = function(evt) { onError(evt) };
    };

    function disconnect() {
        websocket.close();
    };

    function onOpen(evt) {
        output('<span style="color: green;">CONNECTED </span>');
    };

    function onClose(evt) {
        output('<span style="color: red;">DISCONNECTED </span>');
    };

    function onError(evt) {
        output('<span style="color: red;">ERROR: ' + evt.data+ '</span>');
    };


    function output(message) {
        var currentTime = "<span class='time'>" +  moment().format('HH:mm:ss.SSS') + "</span>";
        var element = $("<div>" + currentTime + "<font style=\"color:red;\">=></font>  " + message + "</div>");
        $('#console').prepend(element);
    };

    function onMessage(evt) {
        if( !(typeof(evt.data)=="string") ){
            // 接收二进制数据, protobuff 数据格式返回 demo
            var reader = new FileReader();
            reader.onload = function(evt){
                if(evt.target.readyState == FileReader.DONE){
                    var data = new Uint8Array(evt.target.result);
                    handler(data);
                }
            }
            reader.readAsArrayBuffer(evt.data);
        } else {
            // 接收字符串返回
            if (!evt.data.match("^\{(.+:.+,*){1,}\}$")){
                //普通字符串
                output('<span style="color: blue;">' + evt.data+ '</span>');
            } else {
                // json
                // console.log(typeof evt.data);
                var json = jQuery.parseJSON(evt.data);
                console.log(json);

                var str = '<a target="_blank" href="'+json.url+'">查看</a>';
                output('<span style="color: blue;">' + evt.data+ ' ' +str+ '</span>');
            }

        }
    };


    function encode(root, proto, payload) {
        var protocol = root.lookupType(proto);
        var errMsg = protocol.verify(payload);
        if (errMsg){
            throw Error(errMsg);
        }
        var message = protocol.fromObject(payload);
        return protocol.encode(message).finish();
    }

    function decode(root, proto, buffer) {
        var protocol = root.lookupType(proto);
        return protocol.decode(buffer);
    }





    function handler(data){
        var timestamp = Date.parse(new Date());
        protobuf.load("/protobuf/protocol.proto", function(err, root) {
            var base = decode(root, 'Base', data);

            console.log(base.id);

            if (base.id = 20000) {
                msg_obj = decode(root, 'Msg', base.data);
                output('<span style="color: blue;">' + msg_obj.msg + '</span>');
            } else {
                console.log(base.id);
            }
        });

    };

    // -------------------------------------------------------------------------------


    function SendWork(pid) {
        // DoSendWork(pid);
        websocket.send(pid);
    }

    function DoSendWork(pid) {
        var timestamp = Date.parse(new Date());
        protobuf.load("/protobuf/protocol.proto", function(err, root) {

            if (err){
                throw err;
            }

            var the_base = { id: pid, data: ""};
            var base_buffer = encode(root, 'Base', the_base);

            console.log(the_base);
            console.log(base_buffer);

            websocket.send(base_buffer);

        });
    }

    function SendProtobufDemo() {
        // var timestamp = Date.parse(new Date());

        protobuf.load("/protobuf/protocol.proto", function(err, root) {

            if (err){
                throw err;
            }

            var the_people = { name:'小明小强小红', id: 123, email: "123456@qq.com" };
            var people_buffer = encode(root, 'People', the_people);

            var the_base = { id: 10001, data: people_buffer };
            var base_buffer = encode(root, 'Base', the_base);

            console.log(people_buffer);
            console.log(base_buffer);

            websocket.send(base_buffer);

        });
    }



    $(function () {

        init();

        $('#request').click(function(){
            console.log('request');
            SendWork(20000);
        });

        $('#clearConsole').click(function (){
            $('#console').html('');
        });

    });
});






