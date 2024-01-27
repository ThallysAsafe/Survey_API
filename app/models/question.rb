class Question < ApplicationRecord
  belongs_to :research, class_name: 'Research'
  enum type_question: { radio: "radio", multi_line: "multi_line", single_line: "single_line" }
  validates :type_question, presence: true
end
