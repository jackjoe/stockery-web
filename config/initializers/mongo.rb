if Rails.env.production? && ENV['MONGOHQ_URL'] # heroku
  puts "Production mode with #{ENV['MONGOHQ_URL']}"

  MongoMapper.connection = Mongo::Connection.new('staff.mongohq.com', 10093)
  MongoMapper.connection.add_auth('app1387310', 'heroku', 'ea7a9be90fe03c77afdb016efa753d25')

  MongoMapper.database = 'app1387310'
  
  # MongoMapper.config = {Rails.env => {:uri => ENV['MONGOHQ_URL']}}
  # MongoMapper.connect(Rails.env)
else
  db_config = YAML::load(File.read("#{Rails.root}/config/database.yml"))[::Rails.env]

  MongoMapper.connection = Mongo::Connection.new(db_config['host'], db_config['port'])
  MongoMapper.connection.add_auth(db_config['database'], db_config['user'], db_config['password'])

  MongoMapper.database = db_config['database']
end
