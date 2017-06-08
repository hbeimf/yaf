var userName = 'user' + Math.floor((Math.random()*1000)+1);

var socket =  io.connect(':8080');

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


// function ConnectServer(){
//     connect();
// }

// function DisconnectServer() {
//     websocket.close();
// };

function DisconnectServer() {
        socket.disconnect();
}

// function sendJson() {
//                 var message = 'send json ...';
//                 var jsonObject = {
//                                   cmd: "sendJson",
//                                   userName: userName,
//                                   message: message};
//                 socket.json.send(jsonObject);
// }

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

function fetchWeb() {
    var jsonObject = {
                        cmd:'fetchWeb',
                        userName: userName,
                        message: 'fetch web demo...'
                    };

    socket.json.send(jsonObject);
}

// function protobufDemo() {
//     protobuf.load("/static/awesome.proto", function(err, root) {
//         if (err)
//             throw err;

//         // Obtain a message type
//         var AwesomeMessage = root.lookupType("awesomepackage.AwesomeMessage");
//         // console.log(AwesomeMessage);

//         // Exemplary payload
//         var payload = { awesomeField: "AwesomeString" };

//         // Verify the payload if necessary (i.e. when possibly incomplete or invalid)
//         var errMsg = AwesomeMessage.verify(payload);
//         if (errMsg)
//             throw Error(errMsg);

//         // Create a new message
//         var message = AwesomeMessage.fromObject(payload); // or use .create if payload is already known to be valid

//         // Encode a message to an Uint8Array (browser) or Buffer (node)
//         var buffer = AwesomeMessage.encode(message).finish();
//         // ... do something with buffer
//         console.log(buffer);

//         // Decode an Uint8Array (browser) or Buffer (node) to a message
//         var message = AwesomeMessage.decode(buffer);
//         // ... do something with message
//         console.log(message);
//         // If the application uses length-delimited buffers, there is also encodeDelimited and decodeDelimited.

//         // Maybe convert the message back to a plain object
//         var object = AwesomeMessage.toObject(message, {
//             longs: String,
//             enums: String,
//             bytes: String,
//             // see ConversionOptions
//         });

//         console.log(object);
//     });
// }



// function SendProtobufDemo() {
//     protobuf.load("/protocol.proto", function(err, root) {

//         if (err){
//             throw err;
//         }

//         function encode(proto, payload) {
//             var protocol = root.lookupType(proto);
//             var errMsg = protocol.verify(payload);
//             if (errMsg){
//                 throw Error(errMsg);
//             }
//             var message = protocol.fromObject(payload);
//             return protocol.encode(message).finish();
//         }

//         function decode(proto, buffer) {
//             var protocol = root.lookupType(proto);
//             return protocol.decode(buffer);
//         }

//         var the_people = { name:'xiao ming', id: 123, email: "123456@qq.com" };
//         var people_buffer = encode('People', the_people);

//         var the_base = { id: 345, data: people_buffer };
//         var base_buffer = encode('Base', the_base);

//         // console.log(people_buffer);
//         console.log(base_buffer);
//         // console.log(decode('People', people_buffer) );

//         socket.send(base_buffer);
//     });
// }

// function sendImage() {
//     var message = $('#file_base64').val();
//     var arr = message.split('base64,');
//     console.log(arr);

//     var jsonObject = {cmd:'uploadImage',
//                       userName: userName,
//                       type: arr[0],
//                       message: arr[1]};

//     console.log(jsonObject);


//         socket.json.send(jsonObject);
// }

// // http://www.bicky.me/blog/archive/uploading-files-with-ajax-based-on-base64-text-encoding/
// $(function(){
//     $("#fileup").change(function(){
//         var v = $(this).val();
//         var reader = new FileReader();
//         reader.readAsDataURL(this.files[0]);
//         reader.onload = function(e){
//             console.log(e.target.result);
//             $('#file_base64').val(e.target.result);

//             sendImage();
//         };
//     });
// });




function output(message) {
    var currentTime = "<span class='time'>" +  moment().format('HH:mm:ss.SSS') + "</span>";
    var element = $("<div>" + currentTime + "<font style=\"color:red;\">=></font>  " + message + "</div>");
    $('#console').prepend(element);
}


function clearConsole() {
    $('#console').html('');
}
