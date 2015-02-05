class Poll < ActiveRecord::Base
  after_destroy :log_destroy_action
  validates :title, :author_id, presence: true


  belongs_to(
    :author,
    :class_name => 'User',
    :foreign_key => :author_id,
    :primary_key => :id
  )

  has_many(
    :questions, dependent: :destroy,
    class_name: 'Question',
    foreign_key: :poll_id,
    primary_key: :id
  )

  def log_destroy_action
    puts 'Poll destroyed'
  end
end
