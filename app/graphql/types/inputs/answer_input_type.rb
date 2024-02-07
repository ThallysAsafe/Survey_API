module Types::Inputs
  class AnswerInputType < Types::BaseInputObject
    description 'Attributes for creating or updating a question'

    argument :answer, [String], 'Name of the question', required: true
    argument :research_id, ID, 'ID of the associated research', required: true
    argument :question_id, ID, 'ID of the associated question', required: true
  end
end
