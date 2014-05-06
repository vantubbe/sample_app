class UserPost < ActiveRecord::Base
  validates :message, length: {minimum: 1, maximum: 150}

end
