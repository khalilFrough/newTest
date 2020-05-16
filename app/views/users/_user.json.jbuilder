json.extract! user, :id, :username, :email, :mobile, :city, :personal_information, :avater, :password, :type_of_card, :card_number, :id_card, :created_at, :updated_at
json.url user_url(user, format: :json)
