module ApplicationHelper
  def title
    base_title = "Tutorial"

    base_title if @title.nil?
    "#{base_title} | #{@title}"
  end
end
