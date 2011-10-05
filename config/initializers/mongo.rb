if Rails.env.production? && ENV['MONGOHQ_URL']
  MongoMapper.config = {RAILS_ENV => {:uri => ENV['MONGOHQ_URL']}}
  p MongoMapper.config
  MongoMapper.connect(RAILS_ENV)
else
  db_config = YAML::load(File.read("#{Rails.root}/config/database.yml"))[::Rails.env]

  MongoMapper.connection = Mongo::Connection.new(db_config['host'], db_config['port'])
  MongoMapper.connection.add_auth(db_config['database'], db_config['user'], db_config['password'])

  MongoMapper.database = db_config['database']
end

if defined?(PhusionPassenger)
   PhusionPassenger.on_event(:starting_worker_process) do |forked|
     MongoMapper.connection.connect if forked
   end
end
