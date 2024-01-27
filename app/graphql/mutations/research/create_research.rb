module Mutations
  module Research
    class CreateResearch < BaseMutation
      argument :title, String, required: true
      argument :confirm, String, required: true

      field :research, Types::ResearchType, null: true

      def resolve(title:, confirm:)

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
