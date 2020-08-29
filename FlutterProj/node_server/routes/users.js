var a='clock: 80%';
var b='meeting_table: 70%';
a=a.split(':',1);
b=b.split(':',1);
var c;
c= '"'+a+'": ,'+'"'+b+'":.';
console.log(c);
//'{"result":, "count":}'
/*
var express = require('express');
var router = express.Router();

router.get('/', function(req, res, next) {
  res.send('respond with a resource');
});

module.exports = router;
*/