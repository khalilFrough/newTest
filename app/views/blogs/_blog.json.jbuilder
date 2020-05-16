json.extract! blog, :id, :title, :body, :user_id, :view_count, :topic, :created_at, :updated_at
json.url blog_url(blog, format: :json)
