# integral-ug-propagator

## Configuration

### Service Bus configuration variables

| Variable | Description |
|---------------------|---------------------|
| SERVICE_BUS_URI | URI to Service Bus instance, without protocol, e.g: kth-integral.servicebus.windows.net?amqp.idleTimeout=120000 |
| SERVICE_BUS_USER | The Service Bus principal ID, needs write access to queue |
| SERVICE_BUS_PASSWORD | The Service Bus key for the principal ID |
| SERVICE_BUS_QUEUE | The name of the Service Bus queue |

### UG Server configuration variables

| Variable | Description |
|---------------------|---------------------|
| UG_SERVER | The UG server host name |
| UG_SYSTEM | The UG system user for the service |
| UG_PASSWORD | The password for the UG system user |
| UG_VERSION | UG database revision to start from. If not specified |
| UG_USER_ATTRIBUTES | A comma separated list of UG user attributes, e.g: kthid,affiliation,alias,email_address |
| UG_GROUP_ATTRIBUTES | A comma separated list of UG group attributes, e.g: kthid,ug1name,email_alias,name_en,name_sv,member |

## Building

Currently the build depends on libraries that are not available in typical
repositories.

Java code must be build with `mvn package`.
After wich the docker image is built with `docker build`.

## Running

Given a file environment containing environment variables as mentioned above, the image can be run with docker run as in this example.

```
docker run --name=integral-ug-propagator \
    --hostname=integral-ug-propagator \
    --network=integral_isolated_nw \
    --env-file=environment \
    -v /opt/camel \
    integral-ug-propagator:1
```
