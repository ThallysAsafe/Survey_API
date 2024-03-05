module Resolvers
  class BaseResolver < GraphQL::Schema::Resolver
    def validate_user(current_user,role=false)
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
