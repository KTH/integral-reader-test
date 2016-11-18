# integral-reader-test

A Camel test route which reads data from a Service Bus Queue and outputs
log data on stdout.

## Configuration

### Service Bus configuration variables

| Variable | Description |
|---------------------|---------------------|
| SERVICE_BUS_URI | URI to Service Bus instance, without protocol, e.g: kth-integral.servicebus.windows.net?amqp.idleTimeout=120000 |
| SERVICE_BUS_USER | The Service Bus principal ID, needs listen access to queue |
| SERVICE_BUS_PASSWORD | The Service Bus key for the principal ID |
| SERVICE_BUS_QUEUE | The name of the Service Bus queue |

## Building

Currently the build depends on libraries that are not available in typical
repositories.

Java code must be build with `mvn package`.
After wich the docker image is built with `docker build`.

## Running

Given a file environment containing environment variables as mentioned above, the image can be run with docker run as in this example.

```
docker run --name=integral-reader-test \
    --hostname=integral-ug-propagator \
    --network=integral_isolated_nw \
    --env-file=environment \
    integral-reader-test:latest
```
