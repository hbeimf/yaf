var express = require('express');
var router = express.Router();

var util = require('util');

// var expressWs = require('express-ws')(router);
var index = require('express-ws')(router);


/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});


// https://github.com/websockets/ws/issues/560
// https://github.com/HenningM/express-ws
router.ws('/ws', function(ws, req) {
  ws.on('message', function(msg) {
    ws.send(msg);
  });
});


module.exports = router;
