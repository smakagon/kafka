require 'kafka'
require 'json'

kafka = Kafka.new(seed_brokers: ['localhost:9092'], client_id: 'omega')

movie_id = 1

# Omega microservice is responsible for calculating forecast_launch_date
payload = { movie_id: movie_id, forecast_launch_date: '12/10/2017' }.to_json

producer = kafka.producer
producer.produce(payload, topic: 'movie_update', key: "movie_#{movie_id}")

producer.deliver_messages
