require 'kafka'
require 'json'

kafka = Kafka.new(seed_brokers: ['localhost:9092'], client_id: 'microservice_a')

movie_id = 1

# Microservice A is responsible for updating title
payload = { movie_id: movie_id, title: "Title of #{movie_id}" }.to_json

producer = kafka.producer
producer.produce(payload, topic: 'movie_update', key: "movie_#{movie_id}")

producer.deliver_messages
