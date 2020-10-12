const express = require('express');
const app = express();
const router = express.Router();
const os = require('os');
const appVersion = 'green';
const listenerPort = 8081;
const tracer = require('jaeger-client').initTracer({
    serviceName: 'hello-nodejs',
    sampler: { 
      type: 'const', 
      param: 1 // Only for DEV the sampler will report every span
               // DONT DO THIS IN PRODUCTION
    }
});
const opentracing = require('opentracing');

// to work with istio we need to handle b3/zipkin header format
const ZipkinB3TextMapCodec = require('jaeger-client').ZipkinB3TextMapCodec
let codec = new ZipkinB3TextMapCodec({ urlEncoding: true });
tracer.registerInjector(opentracing.FORMAT_HTTP_HEADERS, codec);
tracer.registerExtractor(opentracing.FORMAT_HTTP_HEADERS, codec);
opentracing.initGlobalTracer(tracer);

console.log('Inno\'s app server is starting...');
console.log('hostname', os.hostname());
console.log(('port', listenerPort));

router.get('/hello', helloHandler);
router.get('/hi', mockRetryHandler);

app.use('/', router);
app.use('/nodejs', router);

app.listen(listenerPort);

function startSpan(tracer, request) {
  const wireCtx = tracer.extract(opentracing.FORMAT_HTTP_HEADERS, request.headers);
  const span = tracer.startSpan(request.path, { childOf: wireCtx });
  // Use the log api to capture a log
  span.log({ event: 'request_received' });

  // Use the setTag api to capture standard span tags for http traces
  span.setTag(opentracing.Tags.HTTP_METHOD, request.method);
  span.setTag(opentracing.Tags.SPAN_KIND, opentracing.Tags.SPAN_KIND_RPC_SERVER);
  span.setTag(opentracing.Tags.HTTP_URL, request.path);
  return span;
}

function helloHandler(request, response) {
  const tracer = opentracing.globalTracer();
  const span = startSpan(tracer, request);

  const clientIp = request.connection.remoteAddress;
  console.log('/hello received request for', request.url, 'from', clientIp);

  const primes = calculatePrimes(300, 100000000);

  const result = {
    hostname: os.hostname(),
    clientIp: clientIp,
    appVersion: appVersion,
    app: 'NodeJS',
    message: 'hello response'
  };

  tracer.inject(span, opentracing.FORMAT_HTTP_HEADERS, result);
  span.finish();
  response.send(JSON.stringify(result, null, 2));
}

let nextRetryHappens = 1;
function mockRetryHandler(request, response) {
  const tracer = opentracing.globalTracer();
  const span = startSpan(tracer, request);

  nextRetryHappens = (nextRetryHappens + 1) % 4;

  const clientIp = request.connection.remoteAddress;
  console.log('/hi received request for', request.url, 'from', clientIp);

  const primes = calculatePrimes(300, 100000000);
  if (nextRetryHappens === 0) {
    const result = {
      hostname: os.hostname(),
      clientIp: clientIp,
      appVersion: appVersion,
      message: 'NodeJS - hi response 503 retry'
    };
    tracer.inject(span, opentracing.FORMAT_HTTP_HEADERS, result);
    span.finish();
    response
      .status(503)
      .send(JSON.stringify(result, null, 2));
  } else {
    const result = {
      hostname: os.hostname(),
      clientIp: clientIp,
      appVersion: appVersion,
      app: 'NodeJS',
      message: 'hi response',
      nextRetryHappens: nextRetryHappens
    };
    tracer.inject(span, opentracing.FORMAT_HTTP_HEADERS, result);
    span.finish();
    response.send(JSON.stringify(result, null, 2));
  }
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
