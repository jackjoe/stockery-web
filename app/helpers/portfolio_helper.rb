module PortfolioHelper

  def add_extra_stock_link(name, html_options = {})
    link_to_function name, "$('#stocks').append('#{escape_javascript render(:partial => 'stock', :object => Stock.new)}')", html_options
  end

end
