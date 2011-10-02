require 'spec_helper'

describe PortfoliosController do

  describe "POST 'create'" do
    describe "failure" do
      before(:each) do
        @attr = {:name => '', :email => ''}
      end

      it "should not create an empty portfolio" do
        lambda do
          post :create, :portfolio => @attr
        end.should_not change(Portfolio, :count)
      end
    end

    describe "success" do
      before(:each) do
        @attr = {:name => 'pieter', :email => 'pieter@noort.be'}
      end

      it "should a  portfolio" do
        lambda do
          post :create, :portfolio => @attr
        end.should change(Portfolio, :count)
      end

      it "should redirect to edit page" do
        post :create, :portfolio => @attr
        response.should redirect_to(edit_portfolio_path(@attr[:name]))
      end
    end
  end

  describe "PUT 'update'" do
    describe "failure" do
      before(:each) do
        @port_ori_attr = {:name => 'pieter', :email => 'pieter@noort.be'}
        @port = Portfolio.create!(@port_ori_attr) 
        @port_attr = {:name => '', :email => ''}
        @stocks = [{name: 'Apple', symbol: 'AAPL'}, {name: 'KBC', symbol: 'BR.KBC'}]
      end

      it "should render edit page when given empty portfolio" do
        put :update, :id => @port.name, :portfolio => @port_attr.merge(:stocks => @stocks)

        response.should render_template('edit') 
      end

      it "should not allow change of portfolio name" do
        put :update, :id => @port.name, :portfolio => @port_attr.merge(:name => 'nieuw', :email => 'pieter@noort.be', :stocks => @stocks)

        response.should render_template('edit')
      end

      it "should require at least 1 stock when given valid portfolio" do
        put :update, :id => @port.name, :portfolio => @port_attr.merge(:name => @port.name, :email => @port.email)

        response.should render_template('edit')
      end
      
      it "should require a valid stock" do
        put :update, :id => @port.name, :portfolio => @port_ori_attr.merge(:stocks => [{name: '', symbol: ''}])
        
        response.should render_template('edit')  
      end
    end

    describe "success" do
      before(:each) do
        @port = Portfolio.create!({:name => 'pieter', :email => 'pieter@noort.be'}) 
        @port_attr = {:name => 'pieter', :email => 'pieters@noort.be'}
        @stocks = [{name: 'Apple', symbol: 'AAPL'}, {name: 'KBC', symbol: 'BR.KBC'}]
      end

      it "should change portfolio email" do
        put :update, :id => @port.name, :portfolio => @port_attr.merge(:stocks => @stocks)

        @port.reload
        @port.name.should == @port_attr[:name]
        @port.email.should == @port_attr[:email]
      end

      it "should render show page" do
        put :update, :id => @port.name, :portfolio => @port_attr.merge(:stocks => @stocks)

        response.should redirect_to portfolio_path(@port.name)
      end

      it "should add all stocks" do
        put :update, :id => @port.name, :portfolio => @port_attr.merge(:stocks => @stocks)
        
        @port.reload
        @port.stocks.size == @stocks.size
      end
    end
  end

  describe "GET 'edit'" do
    before(:each) do
      @port = Portfolio.create!({:name => 'pieter', :email => 'pieter@noort.be'}) 
    end

    it "should be successful" do
      get 'edit', :id => @port.name

      response.should be_success
    end
  end

  describe "GET 'show'" do
    before(:each) do
      @port = Portfolio.create!({:name => 'pieter', :email => 'pieter@noort.be'}) 
    end

    it "should be successful" do
      get 'show', :id => @port.name

      response.should be_success
    end

    it "should redirect to root when no or empty portfolio name is given" do
      get 'show', :id => @port.name + "-"

      response.should redirect_to(root_path)
    end
  end

end
