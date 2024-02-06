module Types::Inputs
  class QuestionInputType < Types::BaseInputObject
    description 'Attributes for creating or updating a question'

    argument :name, String, 'Name of the question', required: true
    argument :type_question, String, 'Type of the question (radio, checkbox, text)', required: true
    argument :options_answer, [String] , required: true

  end
end
