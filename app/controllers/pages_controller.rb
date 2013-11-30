class PagesController < PostsController

  def new
    post.is_page = true
  end

  def create
    post.is_page = true
    if post.save
      flash[:notice] = I18n.t('notices.page.created')
      redirect_to root_path
    else
      flash[:error] = I18n.t('notices.page.invalid')
      render 'new'
    end
  end

  def update
    post.is_page = true
    if post.update_attributes(post_params)
      flash[:notice] = I18n.t('notices.page.updated')
      redirect_to page_path(:id => post.shorthand)
    end
  end

end
