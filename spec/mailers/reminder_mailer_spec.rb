require "spec_helper"

describe ReminderMailer do
  # include EmailSpec::Helpers
  # include EmailSpec::Matchers

  before(:each) do
    @email = 'pieter@noort.be'
    @portfolios = []
    @controller = ReminderController.new
    @request_host = 'test.host' # request.host

    (1..5).each do
      Factory :portfolio, :email => @email
    end

    ports = Portfolio.find_all_by_email(@email)

    ports.each do |port|
      @portfolios << {:name => port.name, :link => edit_portfolio_url(port.url, :host => @request_host)} unless port.url.blank?
    end
  end

  it "renders without errors" do
    lambda do
      ReminderMailer.remind_portfolios(@email, @portfolios)
    end.should_not raise_error
  end

  it "should deliver email when asking to be reminded" do
    ReminderMailer.should_receive(:remind_portfolios).with(@email, @portfolios)
    
    ReminderMailer.remind_portfolios(@email, @portfolios)
  end
end
