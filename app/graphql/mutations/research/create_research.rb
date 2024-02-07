module Mutations
  module Research
    class CreateResearch < BaseMutation
      argument :input, [Types::Inputs::ResearchInputType], required: true
      argument :confirm, String, required: true


      field :research, Types::ResearchType, null: true
      field :errors, String, null: true
      def resolve(input:, confirm:)
        validate_user(context[:current_user])
        research_input = input[0]
        title = research_input[:title]
        status = research_input[:status] || "open"
        
        if confirm == "true"
          research = ::Research.create(title: title, status: status)
          # falta colocar criação de uma questão por default
          { research: research }
        else
          { research: nil }
        end
      end
      private

      def validate_user(current_user)
        unless current_user && current_user['role'] == 'coordinators'
          return { research: nil, errors: ['Acesso não autorizado'] }
        end
      end
    end
  end
end
