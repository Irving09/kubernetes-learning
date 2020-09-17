const express = require('express');
const app = express();
const router = express.Router();
const os = require('os');
const appVersion = 'green';
const listenerPort = 8081;

console.log('Inno\'s app server is starting...');
console.log('hostname', os.hostname());
console.log(('port', listenerPort));

router.get('/hello', helloHandler);
router.get('/hi', hiHandler);

app.use('/nodejs', router);
app.use('/other', router);

app.listen(listenerPort);

function helloHandler(request, response) {
  const clientIp = request.connection.remoteAddress;
  console.log('/nodejs/hello received request for', request.url, 'from', clientIp);

  const primes = calculatePrimes(300, 100000000);

  response.send(JSON.stringify({
    hostname: os.hostname(),
    clientIp: clientIp,
    appVersion: appVersion,
    app: 'NodeJS',
    message: 'hello response'
  }, null, 2));
}

function hiHandler(request, response) {
  const clientIp = request.connection.remoteAddress;
  console.log('/other/hi received request for', request.url, 'from', clientIp);

  const primes = calculatePrimes(300, 100000000);

  response.send(JSON.stringify({
    hostname: os.hostname(),
    clientIp: clientIp,
    appVersion: appVersion,
    app: 'NodeJS',
    message: 'hi response'
  }, null, 2));
}

function calculatePrimes(iterations, multiplier) {
  var primes = [];
  for (var i = 0; i < iterations; i++) {
    var candidate = i * (multiplier * Math.random());
    var isPrime = true;
    for (var c = 2; c <= Math.sqrt(candidate); ++c) {
      if (candidate % c === 0) {
          // not prime
          isPrime = false;
          break;
       }
    }
    if (isPrime) {
      primes.push(candidate);
    }
  }
  return primes;
}
