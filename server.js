var express = require("express");
var app = express();

app.get('/', function(req, res) {
  res.sendfile("index.html");
});

app.get('/script.js', function(req, res) {
  res.sendfile("./dist/bundle.js");
});



app.listen(3000, function() {
  console.log("Working on port 3000");
});
