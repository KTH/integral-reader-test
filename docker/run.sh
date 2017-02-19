#!/bin/sh

cat << eof > camel.properties
service_bus.uri=${SERVICE_BUS_URI:?}
service_bus.user=${SERVICE_BUS_USER:?}
service_bus.password=${SERVICE_BUS_PASSWORD:?}
service_bus.queue=${SERVICE_BUS_QUEUE:?}
eof

if [ "$*" = "start" ]; then
    exec java -cp /run/secrets:/opt/data:.:application.jar org.apache.camel.spring.Main
fi

exec $*
