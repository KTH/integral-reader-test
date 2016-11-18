#!/bin/sh

cat << eof > camel.properties
service_bus.uri=${SERVICE_BUS_URI:?}
# UG propagator input queue - reader
service_bus.user=${SERVICE_BUS_USER:?}
service_bus.password=${SERVICE_BUS_PASSWORD:?}
service_bus.ug.queue=${SERVICE_BUS_UG_QUEUE:?}
eof

if [ "$*" = "start" ]; then
    exec java -jar application.jar
fi

exec $*
