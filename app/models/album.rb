class Album < ActiveRecord::Base
  validates :name, :band_id, presence: true

  belongs_to :band
  has_many :tracks, dependent: :destroy

  enum recording_type: [:studio, :live]
  after_initialize :ensure_recording_type


  private
    def ensure_recording_type
      self.recording_type ||= 0
    end
end
