# == Schema Information
#
# Table name: responses
#
#  id               :bigint(8)        not null, primary key
#  question_id      :integer          not null
#  author_id        :integer          not null
#  answer_choice_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Response < ApplicationRecord
    validates :question_id, :answer_choice_id, :author_id, presence: true
    validate :not_duplicate_responses

    belongs_to :answer_choice,
        primary_key: :id,
        foreign_key: :answer_choice_id,
        class_name: :AnswerChoice
    
    belongs_to :respondent,
        primary_key: :id,
        foreign_key: :author_id,
        class_name: :User

    has_one :question,
        through: :answer_choice,
        source: :question


    def sibling_responses
        question.responses
    end 

    def respondent_already_answered?
        sibling_responses.exists?(self.id)
    end 

    def not_duplicate_responses
        if self.respondent_already_answered?
            errors[:duplicate] << "can't respond more than once to the same question"
        end 
    end 
end
