class Cat < ActiveRecord::Base
  include ActionView::Helpers::DateHelper

  validates :name, :birth_date,
            :color, :sex, :description,
            presence: true
  validates :color, inclusion:
            { in: %w(black grey brown yellow),
            message: "%{value} is not a valid color"}
  validates :sex, inclusion:
            { in: %w(M F),
            message: "%{value} is not a valid sex"}

  def age
    "#{time_ago_in_words(birth_date.to_datetime)} old"
  end
end
