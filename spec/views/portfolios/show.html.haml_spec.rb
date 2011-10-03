require 'spec_helper'

describe 'portfolios/show.html.haml' do
  before do
    @port = Factory :portfolio
    assign :page, @port

    render
  end

  it 'should have a link to a json path' do
    rendered.should have_selector('a#json-link', :href => "#{portfolio_url(@port.name)}.json")
  end 
end
