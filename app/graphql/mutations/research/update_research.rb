module Mutations
  module Research
    class UpdateResearch < Mutations::BaseMutation
      argument :id, ID, required: true
      argument :title, String, required: true
      argument :status, String, required: true

      field :research, Types::ResearchType, null: true
      field :errors, [String], null: false

      def resolve(id:, title:, status:)
        research = ::Research.find(id)
        if research.update(title: title, status: status)
          { research: research, errors: [] }
        else
          { research: nil, errors: research.errors.full_messages }
        end
      end
    end
  end
end
