class ShortenedUrl < ActiveRecord::Base

  validates :submitter_id, :long_url, :short_url,
    :presence => true

  validates :short_url, :uniqueness => true

end
