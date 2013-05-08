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
end