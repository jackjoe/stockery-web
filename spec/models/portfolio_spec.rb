require 'spec_helper'

describe Portfolio do
  before(:each) do
    @port = Portfolio.new
    @attr = {:name => "Pieter", :email => "pieter@noort.be"}
  end

  it "should create an instance given valid attributes" do
    Portfolio.create!(@attr)
  end

  it "should require a non-empty key 'name'" do
    port = Portfolio.new(@attr.merge(:name => ''))

    port.should_not be_valid
  end

  it "should require a non-empty key 'email'" do
    port = Portfolio.new(@attr.merge(:email => ''))

    port.should_not be_valid
  end

  it "should require a unique name" do
    Portfolio.create!(@attr)

    port = Portfolio.new(@attr.merge(:email => "test@valid.com"))
    port.should_not be_valid
  end

  it "should require a valid e-mail address" do
    addresses = %w[pieter@noort pieter pieter$$noort]
    addresses.each do |email|
      port = Portfolio.new(@attr.merge(:email => email))
      port.should_not be_valid
    end
  end

end
