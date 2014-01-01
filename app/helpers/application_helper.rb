module ApplicationHelper
  # shamelessly stolen from http://railsapps.github.io/twitter-bootstrap-rails.html
  def display_base_errors(resource)
    return '' if (resource.errors.empty?) or (resource.errors[:messages].empty?)
    messages = resource.errors[:messages].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  def page_title
    [t("titles.#{controller.controller_path.gsub('/', '.')}.#{controller.action_name}", :title_parameter => @title_parameter), Setting.page_title].reject{|item| item.blank?}.join(' - ')
  end

  def active_class(nav_item)
    case nav_item
      when :root
        current_page?(root_path)
      when :home
        current_page?(posts_path)
      when /portfolio:(.*)/
        current_page?(portfolio_path(:id => $1))
      when /page:(.*)/
        current_page?(page_path(:id => $1))
      else
        false
    end ? 'active' : ''
  end
end