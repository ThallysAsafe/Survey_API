class Research < ApplicationRecord
  has_many :questions
  validates :title, presence: true
  # validate :validate_number_of_questions
  enum status: { open: 'open', closed: 'closed' }
  # def validate_number_of_questions
  #   if questions.length < 1 || questions.length > 10
  #     errors.add(:base, 'Uma pesquisa deve ter de 1 a 10 perguntas.')
  #   end
  # end
  has_many :answer

end
