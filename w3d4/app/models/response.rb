class Response < ActiveRecord::Base
  after_destroy :log_destroy_action
  validates :respondent_id, :answer_choice_id, presence: true

  validate :respondent_has_not_already_answered_question
  validate :respondent_cannot_be_the_author

  belongs_to(
    :respondent,
    class_name: 'User',
    foreign_key: :respondent_id,
    primary_key: :id
  )

  belongs_to(
    :answer_choice,
    class_name: 'AnswerChoice',
    foreign_key: :answer_choice_id,
    primary_key: :id
  )

  has_one :question, through: :answer_choice, source: :question

  def sibling_responses
    Response.joins('JOIN answer_choices a1 ON a1.id = responses.answer_choice_id')
            .joins('JOIN answer_choices a2 ON a2.question_id = a1.question_id')
            .joins('JOIN responses r2 ON a2.id = r2.answer_choice_id')
            .where(':id IS NULL OR r2.id != :id', id: id)
            .where('r2.respondent_id = :id',id: respondent_id)
  end

  def author_id
    polls = Poll.joins(:questions)
         .joins('JOIN answer_choices ON answer_choices.question_id = questions.id')
         .joins('JOIN responses ON responses.answer_choice_id = answer_choices.id')
         .where('responses.respondent_id = ?', respondent_id)

    polls.empty? ? nil : poll.first.author_id
  end


  private
    def respondent_has_not_already_answered_question
      if sibling_responses.any?
        errors[:base] << "Cannot answer the same question multiple times."
      end
    end

    def respondent_cannot_be_the_author

      if author_id == respondent_id
        errors[:base] << "The author cannot respond to their own poll."
      end
    end

    def log_destroy_action
      puts 'Response destroyed'
    end
end
