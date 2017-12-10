## Example of Event-Driven microservices with Apacke Kafka

### Requirements

This implementation uses Kafka.
Kafka can be installed using the following command in Mac OS:

```
brew install kafka
```

After that we're ready to run all required services.

1. Run Zookeeper using command:

```
zookeeper-server-start /usr/local/etc/zookeeper/zoo.cfg
```

2. Once Zookeeper is running we're ready to run Kafka (default configs work):

```
kafka-server-start /usr/local/etc/kafka/server.properties
```

### Running code

Run `bundle install` first and make sure you have `ruby-kafka` gem installed.

After that run listener:

```
ruby calendar.rb
```

Then you can start publishing events from different "microservices":

```
ruby microservice_b.rb
ruby microservice_a.rb
ruby omega.rb
```

Order doesn't matter. Event listener should receive and display events.
Because it's a proof of concept, I didn't cover this functionality by specs.
