require 'kafka'
require 'json'

kafka = Kafka.new(seed_brokers: ['localhost:9092'], client_id: 'calendar')

consumer = kafka.consumer(group_id: 'calendar')
consumer.subscribe('movie_update')

trap("TERM") { consumer.stop }

def process_movie_update(movie)
  required_attributes = ['movie_id', 'title', 'description', 'forecast_launch_date']
  missing_attributes = required_attributes - movie.keys

  if missing_attributes.empty?
    # here should be actual logic we want to have
    puts "Done! We're ready to create event for movie: #{movie}"
  else
    puts "We do not have all data to process this movie yet. Missing attribute(s): #{missing_attributes}"
  end
end

# This should live in local database (it can be MongoDB for example)
movies = {}

# This will loop indefinitely, yielding each message in turn.
consumer.each_message do |message|
  puts "Received movie_update with payload: #{message.value}"

  # Create placeholder in DB for movie
  puts "Storing movie updates into database"
  movies[message.key] = {} unless movies[message.key]

  # Here we merge received attributes with existing (if any)
  movies[message.key].merge!(JSON.parse(message.value))

  # This logic should decide if saga has ended and if we should create event
  process_movie_update(movies[message.key])
  puts '-'*20
end
