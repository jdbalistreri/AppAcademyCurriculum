class AnswerChoice < ActiveRecord::Base
  after_destroy :log_destroy_action
  validates :body, :question_id, presence: true

  belongs_to(
    :question,
    class_name: 'Question',
    foreign_key: :question_id,
    primary_key: :id
  )

  has_many(
    :responses, dependent: :destroy,
    class_name: 'Response',
    foreign_key: :answer_choice_id,
    primary_key: :id
  )

  private
  def log_destroy_action
    puts 'AnswerChoice destroyed'
  end
end
