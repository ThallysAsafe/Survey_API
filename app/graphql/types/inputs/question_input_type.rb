module Types::Inputs
  class QuestionInputType < Types::BaseInputObject
    description 'Attributes for creating or updating a question'

    argument :name, String, 'Name of the question', required: true
    argument :type_question, String, 'Type of the question (radio, multi_line, single_line)', required: true
    argument :research_id, ID, 'ID of the associated research', required: true
  end
end
