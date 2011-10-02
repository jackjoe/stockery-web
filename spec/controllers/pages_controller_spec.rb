require 'spec_helper'

describe PagesController do
  render_views

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'

      response.should be_success
    end

    it "should have the right title" do
      get 'home'

      response.should have_selector('title', :content => 'Home | Stockery - Arduino Portfolio Manager')
    end

    # it "should contain portfolio form" do
    #   get 'home'

    #   response.should have_selector('form')
    # end
  end

end
