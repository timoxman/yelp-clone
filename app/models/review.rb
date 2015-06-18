class Review < ActiveRecord::Base

  belongs_to :restaurant
  belongs_to :user

  validates :rating, inclusion: (1..5)

  validates :user_id, uniqueness: {scope: :restaurant_id, message: "You can't slag off a restaurant more than once" }

  def can_you_delete?(user)
    self.user == user
  end

end
