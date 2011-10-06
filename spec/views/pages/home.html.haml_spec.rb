require 'spec_helper'

describe 'pages/home.html.haml' do
  before do
    render
  end

  it 'renders a form to create a portfolio' do
    rendered.should have_selector('form', :action => portfolios_path)
  end 

  it 'renders a form to reminder me of my portfolios' do
    rendered.should have_selector('form', :action => reminder_create_path)
  end
end
