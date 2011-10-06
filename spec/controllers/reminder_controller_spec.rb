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
        Factory :portfolio, :email => 'pieter@noort.be'

        @attr = {:email => 'pieter@noort.be'}
      end

      it "redirects to thanks page when sending existing e-mail address" do
        post :create, @attr

        response.should redirect_to reminder_thanks_path(@attr[:email])
      end
    end
  end

end
