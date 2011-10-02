class Stock
  include MongoMapper::EmbeddedDocument

  belongs_to :portfolio

  key :symbol, String, :required => true
  key :name, String

  validates_length_of :symbol, :minimum => 1
end
