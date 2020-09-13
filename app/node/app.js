const http = require('http');
const os = require('os');
const appVersion = 5;

const listenerPort = 8080;
console.log('Inno\'s app server is starting...');
console.log('hostname', os.hostname());
console.log(('port', listenerPort));

const handler = (request, response) => {
  const clientIp = request.connection.remoteAddress;
  console.log('Received request for', request.url, 'from', clientIp);

  const primes = calculatePrimes(50, 100000);

  response.writeHead(200);
  response.write(JSON.stringify({
    hostname: os.hostname(),
    clientIp: clientIp,
    appVersion: appVersion,
    message: 'NodeJS'
  }, null, 2));
  response.end('\n');
}

const server = http.createServer(handler);
server.listen(listenerPort);

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
