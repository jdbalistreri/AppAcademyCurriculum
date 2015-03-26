class Album < ActiveRecord::Base
  validates :name, :band_id, presence: true
  validate :valid_year

  belongs_to :band
  has_many :tracks, dependent: :destroy

  enum recording_type: [:studio, :live]
  after_initialize :ensure_recording_type

  def band_name
    band.name
  end

  private
    def ensure_recording_type
      self.recording_type ||= 0
    end

    def valid_year
      return if recording_year.nil?
      unless recording_year.to_i.between?(1000,2015)
        errors[:recording_year] << "invalid"
      end
    end
end
