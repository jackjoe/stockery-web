if Rails.env.production? && ENV['MONGOHQ_URL'] # heroku
  MongoMapper.config = {Rails.env => {:uri => ENV['MONGOHQ_URL']}}
  MongoMapper.connect(Rails.env)
else
  db_config = YAML::load(File.read("#{Rails.root}/config/database.yml"))[::Rails.env]

  MongoMapper.connection = Mongo::Connection.new(db_config['host'], db_config['port'])
  MongoMapper.connection.add_auth(db_config['database'], db_config['user'], db_config['password'])

  MongoMapper.database = db_config['database']
end
