class Track < ActiveRecord::Base
  validates :name, :album_id, presence: true

  belongs_to :album
  has_one :band, through: :album, source: :band

  enum track_type: [:regular, :bonus]
  after_initialize :ensure_track_type


  private
    def ensure_track_type
      self.track_type ||= 0
    end
end
