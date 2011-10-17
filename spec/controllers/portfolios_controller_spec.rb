require 'spec_helper'

describe PortfoliosController do
  render_views

  describe "POST 'create'" do
    describe "failure" do
      before(:each) do
        @attr = {:name => '', :email => ''}
      end

      it "can not create an empty portfolio" do
        lambda do
          post :create, :portfolio => @attr
        end.should_not change(Portfolio, :count)
      end
    end

    describe "success" do
      before(:each) do
        @attr = {:name => 'pieter', :email => 'pieter@noort.be'}
      end

      it "adds a portfolio which is valid" do
        lambda do
          post :create, :portfolio => @attr
        end.should change(Portfolio, :count)
      end

      it "redirects to edit page when creating valid portfolio" do
        name = 'pieter new'

        post :create, :portfolio => @attr.merge(:name => name)

        response.should redirect_to(edit_portfolio_path('pieter-new'))
      end
    end
  end

  describe "PUT 'update'" do
    describe "failure" do
      before(:each) do
        @port_ori_attr = {:name => 'pieter', :email => 'pieter@noort.be'}
        @port = Portfolio.create(@port_ori_attr) 
        @port_attr = {:name => '', :email => ''}
        @stocks = [{name: 'Apple', symbol: 'AAPL'}, {name: 'KBC', symbol: 'BR.KBC'}]
      end

      it "renders and edit page when given empty portfolio" do
        put :update, :id => @port.name, :portfolio => @port_attr.merge(:stocks => @stocks)

        response.should render_template('edit') 
      end

      it "doesn't allow change of portfolio name" do
        put :update, :id => @port.name, :portfolio => @port_attr.merge(:name => 'nieuw', :email => 'pieter@noort.be', :stocks => @stocks)

        response.should render_template('edit')
      end

      it "requires at least 1 stock when given valid portfolio" do
        put :update, :id => @port.name, :portfolio => @port_attr.merge(:name => @port.name, :email => @port.email)

        response.should render_template('edit')
      end
      
      it "requires a valid stock" do
        put :update, :id => @port.name, :portfolio => @port_ori_attr.merge(:stocks => [{name: '', symbol: ''}])
        
        response.should render_template('edit')  
      end
    end

    describe "success" do
      before(:each) do
        @port = Portfolio.create({:name => 'pieter', :email => 'pieter@noort.be'}) 
        @port_attr = {:name => 'pieter', :email => 'pieters@noort.be'}
        @stocks = [{name: 'Apple', symbol: 'AAPL'}, {name: 'KBC', symbol: 'BR.KBC'}]
      end

      it "changes portfolio email" do
        put :update, :id => @port.url, :portfolio => @port_attr.merge(:stocks => @stocks)

        port = Portfolio.find_by_url(@port.url)

        port.name.should == @port_attr[:name]
        port.email.should == @port_attr[:email]
      end

      it "renders show page" do
        put :update, :id => @port.url, :portfolio => @port_attr.merge(:stocks => @stocks)

        response.should redirect_to portfolio_path(@port.url)
      end

      it "adds all stocks" do
        put :update, :id => @port.url, :portfolio => @port_attr.merge(:stocks => @stocks)
        
        port = Portfolio.find_by_url(@port.url)

        port.stocks.size == @stocks.size
      end
    end
  end

  describe "GET 'edit'" do
    before(:each) do
      @port = Factory :portfolio
    end

    it "is successful" do
      get 'edit', :id => @port.url

      response.should be_success
    end
  end

  describe "GET 'show'" do
    before(:each) do
      @port = Portfolio.create({:name => 'pieter', :email => 'pieter@noort.be'}) 
    end

    it "is successful" do
      get 'show', :id => @port.url

      response.should be_success
    end

    it "redirects to root when no or empty portfolio name is given" do
      get 'show', :id => @port.url + "-"

      response.should redirect_to(root_path)
    end
  end

end
