var websocket;

$(document).ready(init);

function init() {
    if(!("WebSocket" in window)){
        output('<span style="color: red;">websockets are not supported </span>');

    } else {
        output('<span style="color: green;">websockets are supported </span>');
        connect();
    };
};

function connect()
{
    var wsHost = "ws://" + window.location.host + "/websocket";

    websocket = new WebSocket(wsHost);
    // websocket.binaryType = "arraybuffer";
    // websocket.binaryType = "blob";

    // showScreen('<b>Connecting to: ' +  wsHost + '</b>');

    websocket.onopen = function(evt) { onOpen(evt) };
    websocket.onclose = function(evt) { onClose(evt) };
    websocket.onmessage = function(evt) { onMessage(evt) };
    websocket.onerror = function(evt) { onError(evt) };
};

function disconnect() {
    websocket.close();
};

function onOpen(evt) {
    showScreen('<span style="color: green;">CONNECTED </span>');
};

function onClose(evt) {
    showScreen('<span style="color: red;">DISCONNECTED </span>');
};

function onError(evt) {
    showScreen('<span style="color: red;">ERROR: ' + evt.data+ '</span>');
};

function showScreen(txt) {
    output(txt);
};


function output(message) {
    var currentTime = "<span class='time'>" +  moment().format('HH:mm:ss.SSS') + "</span>";
    var element = $("<div>" + currentTime + "<font style=\"color:red;\">=></font>  " + message + "</div>");
    $('#console').prepend(element);
};

function onMessage(evt) {
    if(typeof(evt.data)=="string"){
        try {
           //在此运行代码
           var obj = $.parseJSON(evt.data);

            if (obj instanceof Object) {
                if (obj.userName == 'image') {
                    // <img src="data:image/png;base64,这里放字符"/>
                    var con = '<img src="data:image/'+obj.type+';base64,'+obj.message+'"/>';
                    output('<span class="username-msg">' + obj.userName + ':</span> ' + con + '<br /><br />');
                } else {
                    showScreen('<span style="color: blue;">' + evt.data+ '</span>');
                }
            } else {
                showScreen('<span style="color: blue;">' + evt.data+ '</span>');
            }
        } catch(err) {
           //在此处理错误
           showScreen('<span style="color: blue;">' + evt.data+ '</span>');
        }

    }else{
        // 接收二进制数据, protobuff 数据格式返回 demo
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
    // protobuf.load("/protocol.proto?t="+timestamp, function(err, root) {

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
        people = JSON.stringify(decode('People', base.data));
        delete base.data;
        // console.log(base);
        // console.log(people);

        console.log(base);
        showScreen('<span style="color: blue;">' + JSON.stringify(base) + ' - ' + people + '</span>');
    });

};

// -------------------------------------------------------------------------------
function sendJson() {
                var message = '汉字发送测试';
                var jsonObject = {
                                  cmd: "sendJson",
                                  userName: "userName",
                                  message: message};

                var json_to_str = JSON.stringify(jsonObject);
                websocket.send(json_to_str);
}

function sendString() {
    var message = '发汉字';
    websocket.send(message);
}

function sendImage() {
    var message = $('#file_base64').val();

    // var base64 = BASE64.encoder(str);//返回编码后的字符

    // var unicode= Base64.decode(message);//返回会解码后的unicode码数组。
    // console.log(unicode);

    var arr = message.split('base64,');
    // console.log(arr);

    var jsonObject = {cmd:'uploadImage',
                      userName: "userName",
                      type: arr[0],
                      message: arr[1]};

    // console.log(jsonObject);

    var json_to_str = JSON.stringify(jsonObject);
    websocket.send(json_to_str);
}

$(function(){
    $("#fileup").change(function(){
        var v = $(this).val();
        var reader = new FileReader();
        reader.readAsDataURL(this.files[0]);
        reader.onload = function(e){
            console.log(e.target.result);
            $('#file_base64').val(e.target.result);

            sendImage();
        };
    });
});



function SendProtobufDemo() {
    var timestamp = Date.parse(new Date());

    // protobuf.load("/static/protocol.proto", function(err, root) {
    protobuf.load("/protocol.proto", function(err, root) {
    // 开发的时候建议加个时间，不然会从缓存里取数据
    // protobuf.load("/protocol.proto?t="+timestamp, function(err, root) {

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

        var the_people = { name:'小明小强小红', id: 123, email: "123456@qq.com" };
        var people_buffer = encode('People', the_people);

        var the_base = { id: 10001, data: people_buffer };
        var base_buffer = encode('Base', the_base);

        // console.log(people_buffer);
        console.log(base_buffer);

        websocket.send(base_buffer);

    });
}


function clearConsole() {
    $('#console').html('');
}


function sendWork() {
    var jsonObject = {
                        cmd:'readMysql',
                        userName: "userName",
                        message: 'long time task!'
                    };

    var json_to_str = JSON.stringify(jsonObject);
    websocket.send(json_to_str);
}

function fetchWeb() {
    var jsonObject = {
                        cmd:'fetchWeb',
                        userName: "userName",
                        message: 'fetch web demo...'
                    };

    var json_to_str = JSON.stringify(jsonObject);

    websocket.send(json_to_str);
}


