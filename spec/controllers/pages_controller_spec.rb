require 'spec_helper'

describe PagesController do
  render_views

  describe "GET 'home'" do
    it "be successful" do
      get 'home'

      response.should be_success
    end

    it "have the right title" do
      get 'home'

      response.should have_selector('title', :content => 'Home | Stockery - Arduino Portfolio Manager')
    end

    # it "contain portfolio form" do
    #   get 'home'

    #   response.should have_selector('form')
    # end
  end

end
