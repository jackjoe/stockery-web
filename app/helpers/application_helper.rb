module ApplicationHelper

  def title
    @title ||= "Home"

    "#{@title} | Stockery - Arduino Portfolio Manager"
  end

end
