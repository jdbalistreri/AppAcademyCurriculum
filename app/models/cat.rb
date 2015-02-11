class Cat < ActiveRecord::Base
  include ActionView::Helpers::DateHelper

  validates :name, :birth_date,
            :color, :sex, :description, :user_id,
            presence: true
  validates :color, inclusion:
            { in: %w(black grey brown yellow),
            message: "%{value} is not a valid color"}
  validates :sex, inclusion:
            { in: %w(M F),
            message: "%{value} is not a valid sex"}


  has_many :cat_rental_requests, :dependent => :destroy
  
  belongs_to(
    :owner,
    :foreign_key => :user_id,
    :primary_key => :id,
    :class_name => 'User'
  )

  def age
    "#{time_ago_in_words(birth_date.to_datetime)} old"
  end
end
