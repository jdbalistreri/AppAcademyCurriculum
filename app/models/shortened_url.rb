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

end
