require "spec_helper"

describe PortfolioMailer do
  before(:each) do
    @attr = {:name => 'Pieter', :email => 'pieter@noort.be'}
    @port = Portfolio.create(@attr)
  end

  it "renders without errors" do
    lambda do
      PortfolioMailer.notify_creator(@port, edit_portfolio_url(@port.url, :host => 'localhost'))
    end.should_not raise_error
  end
end
