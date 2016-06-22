var express = require('express'),
    yaml    = require('js-yaml'),
    path    = require('path'),
    fs      = require('fs');

function loadConfig(configPath) {
  if (!configPath) {
    return {};
  }
  
  var fileStats = fs.statSync(configPath);
  if (!fileStats.isFile()) {
    return {};
  }

  return yaml.safeLoad(fs.readFileSync(configPath, 'utf8')) || {};
}

function verify(varName) {
  return typeof process.env[varName] === 'undefined' ?
    varName + ' does not exist in the environment!\n' : 
    varName + ' exists in the environment!\n';
}

(function initialize() {
  var app = express();
  var config = loadConfig(path.join(__dirname, '../config.yml'));

  app.get('/', function(req, res) {
    res.send(verify(config.mongoUsername)  +
             verify(config.mongoPassword)  +
             verify(config.sslCertificate) +
             verify(config.sslPrivateKey));
  });

  app.listen(config.port || 8080, function() {
    console.log('Demo app running on port ' + (config.port || 8080));
  });
}());
