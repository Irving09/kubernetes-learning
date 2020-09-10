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
  response.writeHead(200);
  response.write(`hostname: ${os.hostname()}\n`);
  response.write(`client ip: ${clientIp}\n`);
  response.write(`app version: ${appVersion}`);
  response.end('\n');
}

const server = http.createServer(handler);
server.listen(listenerPort);