module Mutations
  module Answer
    class CreateAnswer < BaseMutation

      argument :response, [Types::Inputs::AnswerInputType], required: true
      argument :confirm, Boolean, required: true
      field :answers, [Types::AnswerType], null: true
      field :errors, [String], null: true

      def resolve(confirm:,response:)
        validate_user(context[:current_user],'responders')
        if confirm
          AnswersCreator.new(context[:current_user].id, response).call
        end
      end
    end
  end
end
