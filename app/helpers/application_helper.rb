module ApplicationHelper

  def pager(opts = {})    
    total = opts[:total] || 0      
    per_page = opts[:per_page] || 10
    page = opts[:page].try(:to_i) || 1
    range = opts[:range] || 2
    page_param = opts[:page_param] || :page
    optional_params = opts[:optional_params] || {}

    url_params = request.query_parameters.symbolize_keys
    url_params.merge!(request.path_parameters)
    url_params.merge!(optional_params.symbolize_keys)

    total_page = (total == 0) ? 1 : (total.to_f / per_page.to_f).ceil

    return '' if total_page == 1

    page_nav_range = Range.new(page - range, page + range)
    total_range = Range.new(1, total_page)
    page_nav_to_show = page_nav_range.to_a & total_range.to_a

    ret = []
    ret << '<div class="pager"><ul>'
    ret << "<li><a href='#{url_for(url_params.merge(page_param => (page - 1)))}'>&lt;上一页</a></li>" if page > 1
    ret << "<li><a href='#{url_for(url_params.merge(page_param => 1))}'>1</a></li><li>...</li>" if !page_nav_to_show.include? 1

    ret << '<li>'
    page_nav_to_show.to_a.each do |i|
      ret << "<a href='#{url_for(url_params.merge(page_param => i))}' #{page == i ? 'class="current"' : nil}>#{i}</a>"
    end
    ret << '</li>'

    ret << "<li>...</li><li><a href='#{url_for(url_params.merge(page_param => total_page))}'>#{total_page}</a></li>" if !page_nav_to_show.include? total_page
    ret << "<li><a href='#{url_for(url_params.merge(page_param => (page + 1)))}'>下一页&gt;</a></li>" if page < total_page
    ret << '</ul></div>'

    ret.join("\n").html_safe
  end

  
end
