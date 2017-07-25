var express = require('express');
var router = express.Router();

var util = require('util');

// var expressWs = require('express-ws')(router);
var expressWs = require('express-ws')(router);


/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});



router.get('/ws', function(req, res, next){
  console.log('get route');
  res.end();
});

// https://github.com/HenningM/express-ws
router.ws('/ws', function(ws, req) {
    util.inspect(ws);
  ws.on('message', function(msg) {
    ws.send(msg);
  });

  // ws.on('connection', function connection(ws) {
  //     ws.on('message', function incoming(message) {
  //       console.log('received: %s', message);
  //     });

  //     ws.send('something');
  // });

});


module.exports = router;
