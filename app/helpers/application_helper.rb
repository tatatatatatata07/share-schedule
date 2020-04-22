module ApplicationHelper
  
  def title_name(title_page)
    base = "シェアスケジュール"
    if title_page.empty?
      base
    else
      title_page + " | " + base
    end
  end
end
