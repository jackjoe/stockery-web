p Rails
p ::Rails.env
p Rails.env.production?
p ::Rails.env.production?

if Rails.env.production?
  MongoMapper.config = {Rails.env => {:uri => ENV['MONGOHQ_URL']}}
  MongoMapper.connect(Rails.env)

  puts "mongomapper"
  p MongoMapper
else
  db_config = YAML::load(File.read("#{Rails.root}/config/database.yml"))[::Rails.env]
  
  puts "db-config"
  p db_config

  MongoMapper.connection = Mongo::Connection.new(db_config['host'], db_config['port'])
  MongoMapper.connection.add_auth(db_config['database'], db_config['user'], db_config['password'])

  MongoMapper.database = db_config['database']
end

if defined?(PhusionPassenger)
   PhusionPassenger.on_event(:starting_worker_process) do |forked|
     MongoMapper.connection.connect if forked
   end
end
