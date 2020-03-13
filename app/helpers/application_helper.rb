module ApplicationHelper
  
  def title_name(title_page)
    base = "シェアカレンダー"
    if title_page.empty?
      base
    else
      title_page + " | " + base
    end
  end
end
