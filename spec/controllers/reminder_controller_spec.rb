require 'spec_helper'

describe ReminderController do
  render_views

  describe "POST 'create'" do
    describe "failure" do
      before(:each) do
        @attr = {:email => ''}
      end

      it "can not send to an blank e-mail" do
        post :create, @attr

        response.should redirect_to(root_path)
      end
    end

    describe "success" do
      before(:each) do
        @portfolios = []
        @email = "pieter@noort.be"

        (1..5).each do
          Factory :portfolio, :email => @email
        end

        ports = Portfolio.find_all_by_email(@email)

        ports.each do |port|
          @portfolios << {:name => port.name, :link => edit_portfolio_url(port.url, :host => request.host)} unless port.url.blank?
        end
      end

      it "redirects to thanks page when sending existing e-mail address" do
        post :create, :email => @email

        response.should redirect_to reminder_thanks_path(@email)
      end

      it "sends out an email" do
        mailer = mock
        mailer.should_receive(:deliver)
        ReminderMailer.should_receive(:remind_portfolios).and_return(mailer)

        post :create, :email => @email
      end
    end
  end

end
