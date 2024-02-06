module Mutations
  module Research
    class UpdateResearch < Mutations::BaseMutation

      argument :id, ID, required: true
      argument :input, [Types::Inputs::ResearchInputType], required: true

      field :research, Types::ResearchType, null: true
      field :errors, [String], null: false

      def resolve(id:, input:)
        current_user = context[:current_user]

        title = input[0][:title]
        status = input[0][:status]
        unless current_user && current_user['role'] == 'coordinators'
          return { research: nil, errors: ['Acesso não autorizado'] }
        end
        research = ::Research.find(id)
        if research
          research.update(title: title, status: status)
          { research: research, errors: [] }
        else
          { research: nil, errors: research.errors.full_messages }
        end
      end
    end
  end
end
