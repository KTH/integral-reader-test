# camel-service-bus-reader

A Camel test route which reads data from a Service Bus Queue and outputs
log data on stdout. There is no code in this project at all, it uses only
standard Camel components.

## Configuration

The application starts with the class path `/run/secrets:/opt/data:/opt/camel`, and
looks for a file named camel.properties for configuration. This allows for a number
of options on how to configure the application.

1. You can use environment variables, which is used to create camel.properties in /opt/camel
   when the container starts. There is a sceleton file in environment.in.
1. You can instead choose to use properties in either /opt/data, which can be made a volume
   mount to some shared area. There is a sceleton file in camel.properties.in.
1. Or you can use properties files in /run/secrets, using the new mechanism for secrets in Docker
   1.13.

There are no defaults, all options must be set regardless of method. Methods cannot
be combined. Also see section "Running" below.

### Service Bus configuration variables

| Variable | Property | Description |
|----------|----------|-------------|
| SERVICE_BUS_URI | service_bus.url | URI to Service Bus instance, without protocol, e.g: kth-integral.servicebus.windows.net |
| SERVICE_BUS_QUEUE | service_bus.queue | The name of the Service Bus queue to read from. |
| SERVICE_BUS_USER | service_bus.user | The Service Bus principal ID, needs read access to queue |
| SERVICE_BUS_PASSWORD | service_bus.password | The Service Bus key for the principal ID |

### Using Topics

For a regular Service Bus queue, the SERVICE_BUS_QUEUE is just the string with the name
of the queue. However, you can just as easily use a topic and corresponding subscription instead.
The SERVICE_BUS_QUEUE would then be *topic*/subscriptions/*subscription* where *topic* and
*subscription* are the Service Bus name of the topic and name of the subscription designated
to your application. Straight forward, but note the static string '/subscriptions/'
included in the queue name to use for a topic.

## About the project

There are essentially three interesting bits in this project. The actual Camel route, 
the Docker image stuff, and the Maven build process for it all.

### The Camel route

The camel bits are found in `src/main/resources/META-INF/spring/camel-context.xml`.
The configuration uses the Spring (http://www.springframework.org) based flavour
for setting up Camel. There are comments in the file explaining the different parts.

There is a section to set up the Jolikia agent which makes it possible to use this
image with Hawtio monitoring as in Apache Service Mix. It requires additional
security considerations and is disabled by default.

### The Docker image

The Docker image bits are found in `docker`. There is not much there to discover, 
just the Dockerinfo file and a start script. The Docker image is based on the 
"trusted" Alpine OpenJDK image.

### The Maven build process

Dependencies for Apache Qpid are updated to latest versions for AMQP 1.0 support
in pom.xml.

The build process is entirely based on Maven. In order to simplify the other parts
the build output creates a "shaded" jar-file containing all the stuff needed to run
and Mainclass definition in jar manifest. The mainclass is just a pointer to the
Spring default main class. In order for the shading bits to work properly you should
mostly start a build with `maven clean`. E.g. `maven clean package`.

The docker image build uses the Spotify maven plugin for docker builds. It is not
much to it other than it copies the `docker` to the `target` folder, adds the
output from the Java build and runs docker build. I find it is the by far best method
to build Docker images in an otherwise Maven based build process.

## Building

Currently the build depends on libraries that are not available in typical
repositories.

The Java code and docker image is built with `mvn clean package docker:build`.
You must have Docker running on your host to build the Docker image as usual.

## Running

Given a file environment containing environment variables as mentioned above, 
the image can be run with docker run as in this example. There is an `evironment.in`
skeleton for your convenience.

```
docker run --env-file=environment kthse/integral-reader-test:latest
```

### Running with maven without docker

If creating a camel.properties from the template camel.properties.in and placing
the file appropriately somewhere in your class path, you can also run the application
standalone without docker using the target `mvn camel:run`, e.g. in development.