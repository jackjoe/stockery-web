class Portfolio
  include MongoMapper::Document

  many :stocks 

  key :name, String, :required => true, :unique => true
  key :email, String, :required => true, :format => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validate :ensure_same_name, :on => :update
  validates_associated :stocks

  def average
    average = 0

    unless stocks.nil?
      quote_fetcher = Stockery::Quote.new

      stocks.each do |stock|
        quote_data = quote_fetcher.get_status(stock.symbol)

        average += quote_data[:change_procent].to_f unless quote_data.nil?
      end

      sprintf("%0.02f", average)
    else
      -9999
    end
  end

  private

    def ensure_same_name
      if !name_was.nil? && name_was != name
        errors.add(:name, "You can't change the name of the portfolio")

        false
      end
    end
end
