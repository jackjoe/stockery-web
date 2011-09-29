class Portfolio
  include MongoMapper::Document

  key :name, String, :required => true, :unique => true

  many :stocks
end
