class Question < ApplicationRecord
  belongs_to :research, class_name: 'Research'
  enum type_question: { radio: "radio", checkbox: "checkbox", text: "text" }
  validates :type_question, presence: true
  validates :options_answer, presence: true
  has_many :answers, dependent: :destroy


end
