const http = require('http');
var expess = require("express");
var bodyParser = require("body-parser");
var fs = require("fs");
var app = expess();
const mymodule = require("./mynodemailer");
const myPushalertModule = require("./mypushalert");
//첫번째 미들웨어 시작, extened : true -> 중첩된 객체표현 허용결정


console.log('서버가동중...');

app.use(bodyParser.urlencoded({ extended: true, limit: "50mb" }));
app.use(bodyParser.json({ type: 'application/json' }));

app.post("/image", function(req, res) {

  var name = req.body.name;
  var img = req.body.image;

  console.log(name);
  var realFile = new Buffer(img, "base64");
      // we need rotate Function having a rotation as 90

 
    fs.writeFile('data/' + name, realFile,function(err){
 
    const exec = require('child_process').exec;
    const child = exec('darknet/darknet detector test darknet/cfg/obj.data darknet/cfg/yolov3customtest.cfg darknet/data/yolov3custom_18000.weights data/'+name, (err, stdout, stderr) => {
  if (err) {
    throw err;
  }

    //console.log("stdout : " + stdout);
  
    result=stdout;    
        
    console.log(55555555);
    console.log(result);
    
    //var res=execSync('data/' + name).toString();
    //console.log(res);
        
    var arr_result=result.split('\n');
    console.log('arr_result : ' + arr_result);
    var ret='';
        
    /*
    json 형태로 가공
    for (i=8;i<arr_result.length -1;i++) {
      console.log(arr_result[i]);
      let tmp=arr_result[i].split(':',1);
      ret+='"'+tmp+'": ,';
    }
    ret+='"'+arr_result[i].split(':',1)+'": ';
    */
    var len=arr_result.length;
  for (i=1;i<len-2 ;i++) {
    console.log(arr_result[i]);
    var tmp=arr_result[i].split(':',1);
    ret+=tmp+',';
  }
  if(len<3){
     ret='noDetected';
      
       ret+=',';
  }
      else{
  ret+=arr_result[i].split(':',1);
      
       ret+=',';
  }
  console.log(ret);
  console.log('딥러닝종료 값 전달');
  res.send(ret);

     });    
    });
                
});

app.post("/create-mailer", async function (req, res) {
  console.log('app.get() called');

  await mymodule(req.body.code,req.body.email) ;

  res.writeHead(201);
  res.end("Emailer Module Done.");

});
app.post("/create-pushalert", async function(req, res){
  console.log('app.get() -> /create-pushalert called');
  console.log(req.body.clientToken);
  await myPushalertModule(req.body.clientToken);

  res.writeHead(201);
  res.end("PushAlert Module Done.");
});

app.listen(3000);


/*const http = require('http');
const hostname = '127.0.0.1';
const port = 3000;
const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('good testing \n');
});
server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});

function run_cmd(cmd, args, cb, end) {
  var spawn = require('child_process').spawn,
      child = spawn(cmd, args),
      me = this;
  child.stdout.on('data', function (buffer) { cb(me, buffer) });
  child.stdout.on('end', end);
}

// Run C:\Windows\System32\netstat.exe -an
var foo = new run_cmd(
    'darknet_no_gpu', ['detector test'],
    function (me, buffer) { me.stdout += buffer.toString() },
    function () { console.log(foo.stdout) }
);

/*
var exec = require('child_process').exec;
exec('./darknet_no_gpu', function callback(err, stdout, stderr){
  if (err){
    console.error(err);
  }
  //stdout 응답 : { success : true/false, data : .. }
  var result = JSON.parse(stdout);
  if(result.success){

  }
});
*/

/*
var express = require('express');
var http = require('http');
var bodyParser= require('body-parser');
var app = express();



app.set('port',process.env.PORT || 3000);
app.use(bodyParser.urlencoded({extended:false}));
app.use(bodyParser.json());

//module.exports = app;

//첫 번째 미들웨어
app.use(function(req, res, next) {

  console.log('첫 번째 미들웨어 호출 됨');
  var approve ={'approve_id':'NO','approve_pw':'NO'};


  var paramId = req.body.id;
  var paramPassword = req.body.password;
  console.log('id : '+paramId+'  pw : '+paramPassword);

  //아이디 일치여부 flag json 데이터입니다.
  if(paramId == 'test01') approve.approve_id = 'OK';
  if(paramPassword == '123') approve.approve_pw = 'OK';

  res.send(approve);

});

var server = http.createServer(app).listen(app.get('port'),function(){
  console.log("익스프레스로 웹 서버를 실행함 : "+ app.get('port'));
});

//module.exports = app;
*/
