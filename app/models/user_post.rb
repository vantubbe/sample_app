class UserPost < ActiveRecord::Base
  validates :message, presence: true, length: {maximum: 140}
  validates :user_id, presence: true
  default_scope -> {order('created_at desc')}
  belongs_to :user
end
