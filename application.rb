require "rubygems"
require "bundler"

module StockeryArduino
  class Application

    def self.portfolios
      @_portfolios ||= YAML.load(File.read('./config/portfolios.yml'))
    end

    def self.root(path = nil)
      @_root ||= File.expand_path(File.dirname(__FILE__))
      path ? File.join(@_root, path.to_s) : @_root
    end

    def self.env
      @_env ||= ENV['RACK_ENV'] || 'development'
    end

    def self.routes
      @_routes ||= eval(File.read('./config/routes.rb'))
    end

    # Initialize the application
    def self.initialize!
      conn = Mongo::Connection.new('staff.mongohq.com', 10052)
      auth = conn.add_auth('stockery-arduino', 'user', 'user')

      MongoMapper.connection = conn
      MongoMapper.database = 'stockery-arduino'
    end

  end
end

Bundler.require(:default, StockeryArduino::Application.env)

Dir['./app/**/*.rb'].each {|f| require f}
