module ApplicationHelper
  def title
    base_title = "Tutorial"

    base_title if @title.nil?
    "#{base_title} | #{@title}"
  end

  def logo
    image_tag("logo.png", :alt => "Sample App", :class => "round")
  end
end
