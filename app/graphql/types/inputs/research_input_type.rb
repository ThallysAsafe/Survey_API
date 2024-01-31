module Types::Inputs
  class ResearchInputType < Types::BaseInputObject
    description 'Attributes for creating or updating a question'
    
    argument :title, String, 'Title of the research', required: true
    argument :status, String, 'Status the research', required: false
  end
end
