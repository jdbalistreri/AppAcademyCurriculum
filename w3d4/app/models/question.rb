class Question < ActiveRecord::Base
  after_destroy :log_destroy_action
  validates :body, :poll_id, presence: true

  belongs_to(
    :poll,
    class_name: 'Poll',
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :answer_choices, dependent: :destroy,
    class_name: 'AnswerChoice',
    foreign_key: :question_id,
    primary_key: :id
  )

  has_many :responses, through: :answer_choices, source: :responses

  def results
    results = {}
    answers_with_count.each do |answer_choice|
      results[answer_choice.body] = answer_choice.count
    end
    results
  end

  # def results2
  #   AnswerChoice.find_by_sql([<<-SQL, id])
  #     SELECT
  #       answer_choices.*, count(responses.*) AS count
  #     FROM
  #       answer_choices
  #     LEFT OUTER JOIN
  #       responses ON answer_choices.id = responses.answer_choice_id
  #     WHERE
  #       answer_choices.question_id = ?
  #     GROUP BY
  #       answer_choices.id
  #   SQL
  # end

  def answers_with_count
    answer_choices
      .select('answer_choices.*, count(responses.*) AS count')
      .joins("LEFT OUTER JOIN responses ON answer_choices.id = responses.answer_choice_id")
      .where('answer_choices.question_id = ?', id)
      .group('answer_choices.id')

  end

  def log_destroy_action
    puts 'Question destroyed'
  end
end
