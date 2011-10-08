if Rails.env.production? && ENV['MONGOHQ_URL'] # heroku
  puts "Production mode with #{ENV['MONGOHQ_URL']}"

  MongoMapper.connection = Mongo::Connection.new('staff.mongohq.com', 10093)
  MongoMapper.connection.add_auth('app1214616', 'heroku', '0d5b490776402b4ca42a79174e9b5e66')

  MongoMapper.database = 'app1214616'
  
  # MongoMapper.config = {Rails.env => {:uri => ENV['MONGOHQ_URL']}}
  # MongoMapper.connect(Rails.env)
else
  db_config = YAML::load(File.read("#{Rails.root}/config/database.yml"))[::Rails.env]

  MongoMapper.connection = Mongo::Connection.new(db_config['host'], db_config['port'])
  MongoMapper.connection.add_auth(db_config['database'], db_config['user'], db_config['password'])

  MongoMapper.database = db_config['database']
end
