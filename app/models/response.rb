class Response < ActiveRecord::Base

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
    self.question.responses
      .where(':id IS NULL OR responses.id != :id', id: id)
      .where('responses.respondent_id = :id',id: respondent_id)
  end

  def author_id
    self.question.poll.author.id
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

end
