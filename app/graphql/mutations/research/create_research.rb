module Mutations
  module Research
    class CreateResearch < BaseMutation
      argument :title, String, required: true
      argument :confirm, String, required: true

      field :research, Types::ResearchType, null: true

      def resolve(title:, confirm:)
        current_user = context.current_user

        unless current_user && current_user['user_role'] == 'coordinator'
          return { research: nil, errors: ['Acesso não autorizado'] }
        end
        if confirm == "true"
          research = ::Research.create(title: title)
          { research: research }
        else
          { research: nil }
        end
      end
    end
  end
end
