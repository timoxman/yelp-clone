class Restaurant < ActiveRecord::Base

  belongs_to :user

  has_many :reviews, dependent: :destroy

  validates :name, length: {minimum: 3}, uniqueness: true

  def already_Reviewed?(user)
    return Review.where(user: user, restaurant: self).first
  end

  def average_rating
    return 'N/A' if reviews.none?
    reviews.average(:rating)
  end

end
