class PortfolioAction < Cramp::Action

  def start
    stocks = Portfolio.where(:name => params[:id]).stocks

    result = {:avg => 0, :symbols => ""}
    symbols_ticker = []

    unless stocks.nil?
      quotes = Stockery::Quote.new

      stocks.each do |stock|
        quote_data = quotes.get_status(stock.symbol)

        result[:avg] += quote_data[:change_procent].to_f
        symbols_ticker << "#{quote_data[:name]} #{quote_data[:change_procent]}%" #.delete(:timestamp)
      end

      result[:symbols] = symbols_ticker.join(" - ")
      result[:avg] = sprintf("%0.02f", result[:avg])
    end
   
    render result.to_json

    finish
  end

end
