class Tagging < ActiveRecord::Base

  validates :tag_id, :url_id, :presence => true

end
