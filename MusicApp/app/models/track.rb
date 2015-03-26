class Track < ActiveRecord::Base
  validates :name, :album_id, presence: true

  belongs_to :album
  has_one :band, through: :album, source: :band
  has_many :notes


  enum track_type: [:regular, :bonus]
  after_initialize :ensure_track_type


  def album_name
    album.name
  end

  def band_name
    album.band_name
  end

  private
    def ensure_track_type
      self.track_type ||= 0
    end
end
