var websocket;

$(document).ready(init);

function init() {
    if(!("WebSocket" in window)){
        output('<span style="color: red;">websockets are not supported </span>');

    } else {
        // output('<span style="color: green;">websockets are supported </span>');
        connect();
    };
};

function connect()
{
    var wsHost = "ws://" + window.location.host + "/websocket";

    websocket = new WebSocket(wsHost);

    websocket.onopen = function(evt) { onOpen(evt) };
    websocket.onclose = function(evt) { onClose(evt) };
    websocket.onmessage = function(evt) { onMessage(evt) };
    websocket.onerror = function(evt) { onError(evt) };
};

function ConnectServer(){
    connect();
}

function DisconnectServer() {
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
    if( ! (typeof(evt.data)=="string") ){
        // 接收二进制数据, protobuff 数据格式返回
        var reader = new FileReader();
        reader.onload = function(evt){
            if(evt.target.readyState == FileReader.DONE){
                var data = new Uint8Array(evt.target.result);
                handler(data);
            }
        }
        reader.readAsArrayBuffer(evt.data);
    }
};

function handler(data){
    protobuf.load("/protocol.proto", function(err, root) {
    // 开发的时候建议加个时间，不然会从缓存里取数据
        if (err){
            throw err;
        }

        function encode(proto, payload) {
            var protocol = root.lookupType(proto);
            var errMsg = protocol.verify(payload);
            if (errMsg){
                throw Error(errMsg);
            }
            var message = protocol.fromObject(payload);
            return protocol.encode(message).finish();
        }

        function decode(proto, buffer) {
            var protocol = root.lookupType(proto);
            return protocol.decode(buffer);
        }

        var base = decode('Base', data);
        chat_msg = decode('ChatMsg', base.data);

        output('<span style="color: blue;">'+ chat_msg.msg + '</span>');
    });

};

// -------------------------------------------------------------------------------

function sendMsg() {
    var msg_string = $('#msg_string').val();
    protobuf.load("/protocol.proto", function(err, root) {
        // 开发的时候建议加个时间，不然会从缓存里取数据
        if (err){
            throw err;
        }

        function encode(proto, payload) {
            var protocol = root.lookupType(proto);
            var errMsg = protocol.verify(payload);
            if (errMsg){
                throw Error(errMsg);
            }
            var message = protocol.fromObject(payload);
            return protocol.encode(message).finish();
        }

        function decode(proto, buffer) {
            var protocol = root.lookupType(proto);
            return protocol.decode(buffer);
        }

        var chat_msg = { msg : msg_string};

        var people_buffer = encode('ChatMsg', chat_msg);

        var the_base = { id: 10000, data: people_buffer };
        var base_buffer = encode('Base', the_base);

        console.log(base_buffer);
        websocket.send(base_buffer);

    });
}

function clearConsole() {
    $('#console').html('');
}

