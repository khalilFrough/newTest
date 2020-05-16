module UsersHelper
  def user_avater(user)
    if user.avater.present?
      avater = user.avater_url
    else
      avater = 'avater.png'
    end
    avater
  end

  def selected_topic(topic)
    if params[:selected_topic].present?
      params[:selected_topic].each do |key, value|
        if key == topic
          return 'checked'
        end
      end
    end
  end
end
