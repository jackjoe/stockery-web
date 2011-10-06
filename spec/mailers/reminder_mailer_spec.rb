require "spec_helper"

describe ReminderMailer do
  before(:each) do
    @email = 'pieter@noort.be'

    (1..5).each do
      Factory :portfolio, :email => @email
    end
  end

  it "renders without errors" do
    lambda do
      @portfolios = Portfolio.find_by_email(@email)

      ReminderMailer.remind_portfolios(@email, @portfolios, 'localhost')
    end.should_not raise_error
  end

  # describe "remind_portfolios" do
  #   let(:mail) { ReminderMailer.remind_portfolios }

  #   it "renders the headers" do
  #     mail.subject.should eq("Remind portfolios")
  #     mail.to.should eq(["to@example.org"])
  #     mail.from.should eq(["from@example.com"])
  #   end

  #   it "renders the body" do
  #     mail.body.encoded.should match("Hi")
  #   end
  # end
end
