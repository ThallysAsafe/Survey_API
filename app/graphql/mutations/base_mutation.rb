# frozen_string_literal: true

module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject

    def validate_user(current_user,role)
      if role
        unless current_user && current_user['role'] == role
          raise GraphQL::ExecutionError, 'Acesso não autorizado'
        end
      else
        unless current_user && (current_user['role'] == 'coordinators' || current_user['role'] == 'responders')
          raise GraphQL::ExecutionError, 'Acesso não autorizado'
        end
      end
    end
  end
end
