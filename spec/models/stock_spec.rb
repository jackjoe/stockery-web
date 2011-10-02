require 'spec_helper'

describe Stock do
  before(:each) do
    @attr = {:symbol => 'AAPL', :name => 'Apple'}
  end

  it "should belong to a portfolio" do
    port_stocks = Portfolio.new.stocks
    port_stocks << Stock.new
    port_stocks.should_not be_empty
  end 

  it "should require a symbol" do
    stock = Stock.new(@attr.merge(:symbol => ''))
    stock.should_not be_valid
  end
end
