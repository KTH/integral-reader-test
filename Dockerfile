FROM openjdk:8-jre-alpine
MAINTAINER Fredrik Jönsson <fjo@kth.se>

RUN apk --no-cache add bash

ENV SERVICE_BUS_URI the-service-bus-uri

# UG reader
ENV SERVICE_BUS_UG_USER the-service-bus-user
ENV SERVICE_BUS_UG_PASSWORD the-service-bus-password
ENV SERVICE_BUS_UG_QUEUE the-service-bus-queue

# Canvas writer
ENV SERVICE_BUS_CANVAS_USER the-service-bus-user
ENV SERVICE_BUS_CANVAS_PASSWORD the-service-bus-password
ENV SERVICE_BUS_CANVAS_QUEUE the-service-bus-queue

# Jolokia management and discovery
EXPOSE 8181 24884

ADD target/ug-multicast-*.jar /opt/camel/application.jar
ADD run.sh /opt/integral/run.sh
RUN chmod +x /opt/integral/run.sh

WORKDIR /opt/camel
ENTRYPOINT ["/opt/integral/run.sh"]
CMD ["start"]
