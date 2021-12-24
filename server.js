const axios = require('axios');
const express = require('express');
const app = express();
const mysql = require('mysql');
const bodyParser = require('body-parser');
let options = require('./sql.config')
let openUrl = require('./openUrl')

app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());
app.use(express.static('www'));

// 设置跨域
app.all('*', function(req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "*");
  res.header("Access-Control-Allow-Methods","PUT,POST,GET,DELETE,OPTIONS");
  res.header("X-Powered-By",' 3.2.1')
  res.header("Content-Type", "application/json;charset=utf-8");
  next();
});


// sql单参数 查询 sql和valueArr同时传入 插入
// 要传入cb只能传入三个参数
function useSql(sql, obj, cb, res) {
  let connection = mysql.createConnection(options);

  connection.connect();
  
  if(obj) {
    connection.query(sql, obj, function(err, data, fields) {
      if (err) {
        console.log(err);
        // todo
        // 如何在這裏告知請求端錯誤了呢?
        // int到bigint
        // 異步函數導致的拿不到值
        // 由於外鍵和索引導致的建表錯誤
        // elementui el-row裏面塊級元素不能隔行顯示 改爲el-card解決
        // 使用vue-router不能顯示樣式,外層包裹button標簽
        // 發生邏輯錯誤 儅請求失敗的時候應該返回錯誤信息 而不是什麽都不做 由此引發了業務的錯誤 本來應該判斷不是200狀態立即響應彈出錯誤窗格 錯誤的變成了查詢錯誤服務器沒有響應,而儅設定的2000ms到了之後觸發錯誤從而彈出錯誤窗格,這時應該彈出的應該是超時窗格(服務器未響應)
        // 成功后的数据有可能需要在处理，定义到useSql函数里就丧失了灵活性，所以传入一个回调函数，在具体函数中定义对拿到数据的操作
        // 而失败后返回的数据是相同的，可以复用，此时不需要再次新传入一个errorcb，只需要传入一个res用来返回错误信息即可
        let resJson = {
          code: 400,
          success: false,
          data: data
        }
        res.json(resJson);
        // res.status(400).json({ err }); // 值为400 返回为错误
        return; //此处没有return就会报错 是因为失败之后browser会接着等待数据连接不关闭嘛（成功返回数据直接断开连接？）
        // https://stackoverflow.com/questions/52122272/err-http-headers-sent-cannot-set-headers-after-they-are-sent-to-the-client
      };

      console.log('向数据库中插入数据成功');
      console.log('返回数据如下:');
      console.log(data);

      cb(data);
    });
  }else{
    connection.query(sql, function(err, data, fields) {
      if (err) {
        console.log(err);
        let resJson = {
          code: 400,
          success: false,
          data: data
        }
        res.json(resJson);
        // res.statuscode(400).json({ err });
        return;
      };
     
      console.log('从数据库中查找数据成功');
      console.log('返回数据如下:');
      console.log(data);
      // 回调函数固定，可以全部写在这里，从而调用不需要传递cb 这里为了表现还有这种用法暂时不改动
      cb(data);
    });
  }
  connection.end();
}

function insert(sql,req,res) {
  let obj = req.body
  console.log('接收到数据如下:')
  console.log(obj)
  useSql(sql, obj, (data)=>{
    let resJson = {
      code: 200,
      success: true,
      data: data
    }
    res.json(resJson);
  }, res)
}

// app.get('/', function (req, res) {
//   res.send('Hello World!');
// });

// 录入司机基本信息
app.post('/insertdriverinfo', function (req, res) {
  let sql = 'INSERT INTO driver SET ?'
  insert(sql,req,res)
});

// 录入汽车基本信息
app.post('/insertbusinfo', function (req, res) {
  let sql = 'INSERT INTO bus SET ?'
  insert(sql,req,res)
});

// 录入司机违章信息
app.post('/insertbrinfo', function (req, res) {
  let sql = 'INSERT INTO break_rule SET ?'
  insert(sql,req,res)
});

// 查询某个车队下的司机信息 传入motorcadeID
app.get('/selectdriverinfoinsomemotercade/:id', function (req, res) {
  let sql = `select * from driver where motorcadeID = ${req.params.id}`
  useSql(sql, undefined, (data)=>{
    let resJson = {
      code: 200,
      success: true,
      data: data
    }
    res.json(resJson);
  }, res)
});

// 查询某名司机记载某个时间段的违章详细信息 输入name，可能有重名 所以要输入唯一标识 如身份证 通过身份证寻找ID
app.post('/selectbrinfoatsometimebydriver', function (req, res) {
  // 根据idCard寻找dID
  let idCard = req.body.idCard
  console.log(req.body.idCard)
  let sql_finddID = `select dID from driver where idCard='${idCard}'`
  let dID = ''
  useSql(sql_finddID, undefined, (data)=>{
    // todo 不判断的话可能会给dID赋值undifined从而导致程序退出
    if (data.length !== 0) {
      dID = data[0].dID
    }
    // 下段代码需要定义到回调函数里面，否则会因为数据库查询是异步的从而导致dID未查询到结果还是空的状况下就被使用
    // let begin = req.body.begin
    // let end = req.body.end
    let begin = req.body.begin
    // todo 数据格式是yy--mm--dd查询不出数据 改为yymmdd后请求成功 但是插入数据的时候采用这个数据格式可以插入 原因？
    let end = req.body.end
    let sql = `select * from break_rule where (brTime between ${begin} and ${end}) and (dID = ${dID})`
    useSql(sql, undefined, (data)=>{
      let resJson = {
        code: 200,
        success: true,
        data: data
      }
      res.json(resJson);
    }, res)
  }, res)
});

// 查询某个车队在某个时间段的违章统计信息 由车队ID从driver表中获取车队成员的dID数组 然后从break_rule中查询这些ID进行的总的违规情况
// motorcadeID begin end
app.post('/selectbrinfoatsometimebymotercade', function (req, res) {
  // 根据idCard寻找dID
  let motorcadeID = req.body.motorcadeID
  console.log(req.body.motorcadeID)
  let sql_finddID = `select dID from driver where motorcadeID ='${motorcadeID}'`
  let dIDArr = []
  useSql(sql_finddID, undefined, (data)=>{
    data.forEach(obj => {
      dIDArr.push(obj.dID)
    })
    // 下段代码需要定义到回调函数里面，否则会因为数据库查询是异步的从而导致dID未查询到结果还是空的状况下就被使用
    let begin = req.body.begin
    let end = req.body.end

    let sql = `select count(brID) as times, brName from break_rule where (brTime between ${begin} and ${end}) and (dID in (${dIDArr})) group by brName`
    useSql(sql, undefined, (data)=>{
      let resJson = {
        code: 200,
        success: true,
        data: data
      }
      res.json(resJson);
    }, res)
  }, res) 
});

let server = app.listen(3000, function () {
  let port = server.address().port;

  console. log('Listening at http://localhost:%s', port);
  openUrl('http://localhost:3000');
}); 