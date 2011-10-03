require 'spec_helper'

describe 'pages/home.html.haml' do
  before do
    render
  end

  it 'should render a form to create a portfolio' do
    rendered.should have_selector('form', :action => portfolios_path)
  end 
end
