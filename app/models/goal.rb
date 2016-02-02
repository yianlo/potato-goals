class Goal < ActiveRecord::Base
  validates :user_id, :content, presence: true

  belongs_to :user
end
