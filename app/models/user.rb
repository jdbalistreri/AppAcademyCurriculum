class User < ActiveRecord::Base

  validates :name, presence: true

  has_many(
    :authored_polls, dependent: :destroy,
    :class_name => 'Poll',
    :foreign_key => :author_id,
    :primary_key => :id
  )

  has_many(
    :responses, dependent: :destroy,
    class_name: 'Response',
    foreign_key: :respondent_id,
    primary_key: :id
  )

  has_many :answered_questions, through: :responses, source: :question

  def completed_polls_sql
    Poll.find_by_sql([<<-SQL, id])
      SELECT
        p1.*
      FROM
        polls p1
      LEFT OUTER JOIN
        questions ON p1.id = questions.poll_id
      LEFT OUTER JOIN
        answer_choices ON answer_choices.question_id = questions.id
      LEFT OUTER JOIN
        (SELECT
           *
         FROM
           responses
         WHERE
           respondent_id = ?
         ) AS user_responses ON user_responses.answer_choice_id = answer_choices.id
      GROUP BY
        p1.id
      HAVING
        COUNT(DISTINCT questions.id) = COUNT(DISTINCT user_responses.id )
    SQL
  end

  def completed_polls
    # polls = Poll.select('polls.*, COUNT(questions.id) AS count')
    #     .joins('LEFT OUTER JOIN questions ON polls.id = questions.poll_id')
    #     .group('polls.id')
    #     .having
    #
    # # number of questions answered each poll
    # polls_with_num_user_answers = Poll.select('polls.*, COUNT(questions.id) AS num_answers')
    # .joins('LEFT OUTER JOIN questions ON polls.id = questions.poll_id')
    # .group('polls.id')
    #
    # Poll.select("polls.*").joins('LEFT OUTER JOIN questions ON polls.id = questions.poll_id')
    #     .joins('LEFT OUTER JOIN answer_choices ON answer_choices.question_id = questions.id')
    #     .joins("LEFT OUTER JOIN (#{self.responses.where(user_id: 1).to_sql}) AS user_responses ON user_responses.answer_choice_id = answer_choices.id")
    #     .group("polls.id")
    #     .having('COUNT(DISTINCT questions.id) = COUNT(DISTINCT user_responses.id )')

  end

end
