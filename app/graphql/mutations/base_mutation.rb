# frozen_string_literal: true

module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject

    private # continuar aqui

    def authorize
      render json: {message: 'Você precisa fazer o login'},status: :unauthorized unless authorized_user
    end
  end
end
