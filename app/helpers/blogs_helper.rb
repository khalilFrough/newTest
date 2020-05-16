module BlogsHelper
  def active_blog
    if params[:keyword].present?
      return 'post-button-active'
    end
  end

  def active_recent_blog
    unless params[:keyword].present?
      return 'post-button-active'
    end
  end
end
