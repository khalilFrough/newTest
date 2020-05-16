class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :blog
  has_many :comments, foreign_key: :comment_id
  belongs_to :comment, foreign_key: :comment_id, optional: true
end
