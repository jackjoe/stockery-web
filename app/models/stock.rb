class Stock
  include MongoMapper::EmbeddedDocument

  key :symbol, String, :require => true
  key :name, String
end
