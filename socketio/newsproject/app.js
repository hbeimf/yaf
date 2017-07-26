var express = require('express');
var path = require('path');

// var express = require('express');
var expressWs = require('express-ws')(express());

// var expressWs = expressWs(express());
var app = expressWs.app;

// app.use(function (req, res, next) {
//   console.log('middleware');
//   req.testing = 'testing';
//   return next();
// });

// app.get('/', function(req, res, next){
//   console.log('get route', req.testing);
//   res.end();
// });

// app.ws('/', function(ws, req) {
//   ws.on('message', function(msg) {
//     console.log(msg);
//     ws.send(msg);
//   });
//   // console.log('socket', req.testing);
// });

// app.listen(3000)


// var favicon = require('serve-favicon');
// var logger = require('morgan');
// var cookieParser = require('cookie-parser');
// var bodyParser = require('body-parser');

// var index = require('./routes/index');
// var users = require('./routes/users');

// var app = express();
//
//

// var expressWs = require('express-ws');

// var expressWs = expressWs(express());
// var app = expressWs.app;


// var expressWs = require('express-ws')(express());

// var app = expressWs.app;




// var index = require('./routes/index');
var users = require('./routes/users')(app);


// var expressWs = require('express-ws')(app);

// view engine setup
app.set('views', path.join(__dirname, 'views'));
// app.set('view engine', 'jade');
// 修改模板引擎， 作为一名菜鸟，还是从简单通用的入手
app.set('view engine', 'ejs');


// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
// app.use(logger('dev'));
// app.use(bodyParser.json());
// app.use(bodyParser.urlencoded({ extended: false }));
// app.use(cookieParser());
// app.use(express.static(path.join(__dirname, 'public')));

// app.use('/', index);
app.use('/users', users);

// app.ws('/', function(ws, req) {
//   // util.inspect(ws);
//   ws.on('message', function(msg) {
//     console.log('_message');
//     console.log(msg);
//     ws.send('echo:' + msg);

//   });
// })


// app.get('/', function(req, res, next){
//   console.log('get route', req.testing);
//   res.end();
// });
// app.ws('/ws', function(ws, req) {
//   ws.on('message', function(msg) {
//     console.log(msg);
//   });
//   // console.log('socket', req.testing);
// });


// // catch 404 and forward to error handler
// app.use(function(req, res, next) {
//   var err = new Error('Not Found');
//   err.status = 404;
//   next(err);
// });

// // error handler
// app.use(function(err, req, res, next) {
//   // set locals, only providing error in development
//   res.locals.message = err.message;
//   res.locals.error = req.app.get('env') === 'development' ? err : {};

//   // render the error page
//   res.status(err.status || 500);
//   res.render('error');
// });

// module.exports = app;


app.listen(3000);
