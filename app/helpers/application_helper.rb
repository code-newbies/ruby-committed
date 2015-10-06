module ApplicationHelper
  # Return full page title to the view
  def full_page_title(page_title = "")
    base_title = "Commited"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end
end
