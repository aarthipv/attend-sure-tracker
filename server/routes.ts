import Router = require('koa-router');
import { collectDefaultMetrics, register, Counter, Gauge } from 'prom-client';

const yourRouter = new Router();

// Expose metrics endpoint
yourRouter.get('/metrics', (ctx) => {
  ctx.headers['content-type'] = register.contentType;
  ctx.body = register.metrics();
});

// Customized Http Metrics (Optional)
const httpMetricsLabelNames = ['method', 'path'];
const totalHttpRequestCount = new Counter({
  name: 'nodejs_http_total_count',
  help: 'total request number',
  labelNames: httpMetricsLabelNames
});
const totalHttpRequestDuration = new Gauge({
  name: 'nodejs_http_total_duration',
  help: 'the last duration or response time of last request',
  labelNames: httpMetricsLabelNames
});

function initMetrics4EachRoute(layer: Router.Layer) {
  layer.stack.unshift(async (ctx, next) => {
    await next();
    totalHttpRequestCount.labels(ctx.method, layer.path).inc();
    // start time symbol defined in pino-http
    totalHttpRequestDuration
      .labels(ctx.method, layer.path)
      .inc(new Date().valueOf() - (ctx.res as any)[startTime]);
  });
}

// call this function to intercept ALL routes with detailed HTTP metrics (Optional)
export function initRoutingMetrics() {
  yourRouter.stack.forEach(initMetrics4EachRoute);
}

export { yourRouter }; 