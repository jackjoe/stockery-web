require "spec_helper"

describe ReminderMailer, :type => :controller do
  include EmailSpec::Helpers
  include EmailSpec::Matchers

  before(:each) do
    @email = 'pieter@noort.be'
    @controller = ReminderController.new

    (1..5).each do
      Factory :portfolio, :email => @email
    end
  end
  
  it "should deliver email when asking to be reminded" do
    ports = Portfolio.find_all_by_email(@email)

    portfolios = []

    ports.each do |port|
      portfolios << {:name => port.name, :link => edit_portfolio_url(port.url, :host => request.host)} unless port.url.blank?
    end

    ReminderMailer.should_receive(:remind_portfolios).with(@email, portfolios)

    post :create, :email => @email
  end
end
