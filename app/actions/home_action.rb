class HomeAction < Cramp::Action
  def start

    render Slim::Template.new('app/views/home.slim').render

    # port = Portfolio.new(:name => 'pieter')
    # port.stocks.build(:symbol => 'AAPL', :name => 'Apple')
    # 
    # port.save!

    finish
  end
end
