class ShortenedUrl < ActiveRecord::Base

  validates :submitter_id, :long_url, :short_url,
    :presence => true

  validates :short_url, :uniqueness => true

  def self.random_code
    loop do
      code = SecureRandom::urlsafe_base64
      return code unless self.exists?(:short_url => code)
    end
  end

  def self.create_for_user_and_long_url!(user, long_url)
    raise 'Not a user object.' unless user.is_a?(User)
    self.create!(:long_url => long_url,
                  :short_url => random_code,
                  :submitter_id => user.id)
  end

  belongs_to(
  :submitter,
  :class_name => 'User',
  :foreign_key => :submitter_id,
  :primary_key => :id
  )

  has_many(
  :visits,
  :class_name => 'Visit',
  :foreign_key => :url_id,
  :primary_key => :id
  )

  has_many :visitors, through: :visits, source: :visitor

  def num_clicks
    Visit.where(url_id: id).count
  end

  def num_uniques
    Visit.where(url_id: id).distinct.count(:visitor_id)
  end

  def num_recent_uniques
    Visit.where(
    "url_id = :id AND updated_at > :time",
    {id: id, time: 10.minutes.ago}).distinct.count(:visitor_id)
  end
end
