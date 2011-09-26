class PortfolioAction < Cramp::Action

  def start
    symbols = StockeryArduino::Application.portfolios[params[:id]]

    unless symbols.nil?
      quotes = Stockery::Quote.new
      
      result = {:avg => 0, :symbols => []}

      symbols.each do |symbol|
        quote_data = quotes.get_status(symbol)

        result[:avg] += quote_data[:change_procent].to_f
        result[:symbols] << quote_data.delete(:timestamp)
      end
      
      render result.to_json
    end

    finish
  end

end
