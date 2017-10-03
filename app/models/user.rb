class User < ApplicationRecord
  has_many :reservations
  has_many :items
  has_many :rented_items, {:class_name => "Item", :foreign_key => "renter_id"}
  has_many :reviews

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: ""
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  geocoded_by :location
  after_validation :geocode

  def average_rating
    if reviews.count == 0
      0
    else
      reviews.sum(:rating)/reviews.count
    end
  end

end
