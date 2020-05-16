class Blog < ApplicationRecord
  has_many :comments
  belongs_to :user
  validates :title, :body, :topic, presence: true

  TOPICS = [
      'News', 'A.I.', 'V.R', 'RMIT', 'Game', 'Rails', 'Go', 'Web', 'M.L.', 'Joke', 'Reat', 'Vue', 'Node', 'iOS', 'AWS'
  ]

end
