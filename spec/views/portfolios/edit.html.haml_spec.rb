require 'spec_helper'

describe 'portfolios/edit.html.haml' do
  before do
    @port = Factory :portfolio
    assign :page, @port

    render
  end

  it 'should render a form to edit a portfolio' do
    rendered.should have_selector('form', :action => portfolio_path(@port.url))
  end 
end
