require 'kafka'
require 'json'

kafka = Kafka.new(seed_brokers: ['localhost:9092'], client_id: 'microservice_b')

movie_id = 1

# Microservice B is responsible for updating descrption
payload = { movie_id: movie_id, description: "Description of #{movie_id}" }.to_json

producer = kafka.producer
producer.produce(payload, topic: 'movie_update', key: "movie_#{movie_id}")

producer.deliver_messages
