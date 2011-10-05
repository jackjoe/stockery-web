unless Rails.env == 'production'
  db_config = YAML::load(File.read("#{Rails.root}/config/database.yml"))[Rails.env]

  conn = Mongo::Connection.new(db_config['host'], db_config['port'])
  conn.add_auth(db_config['database'], db_config['user'], db_config['password'])

  MongoMapper.connection = conn
  MongoMapper.database = db_config['database']
else
  MongoMapper.config = {:production => {:uri => ENV['MONGOHQ_URL']}}
  MongoMapper.connect(:production)
end

if defined?(PhusionPassenger)
   PhusionPassenger.on_event(:starting_worker_process) do |forked|
     MongoMapper.connection.connect if forked
   end
end
