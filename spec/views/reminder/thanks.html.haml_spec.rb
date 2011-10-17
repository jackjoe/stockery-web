require 'spec_helper'

describe "reminder/thanks.html.haml" do
  before do
    render
  end

  it 'should have a link to a json path' do
    rendered.should have_selector('a', :href => root_path)
  end 
end
