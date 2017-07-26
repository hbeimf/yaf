var express = require('express');
var router = express.Router();

// var index = require('express-ws')(router);

/* GET users listing. */
// router.get('/', function(req, res, next) {
//   res.send('respond with a resource XXX');
// });






var returnUserRouter = function(app) {
    // var expressWs = require('express-ws')(app);

    router.get('/', function(req, res, next) {
      res.render('users', { title: 'Express' });
    });

    router.ws('/ws', function(ws, req) {
      ws.on('message', function(msg) {
        console.log(msg);
        ws.send(msg);
      });
    });

    return router;

}



module.exports = returnUserRouter;
