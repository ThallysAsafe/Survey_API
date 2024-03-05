# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    field :node, Types::NodeType, null: true do
      argument :id, ID, required: true
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true do
      argument :ids, [ID], required: true
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    field :openResearch, [Types::ResearchType], null: false
    def openResearch
      validate_user(context[:current_user])
      Research.where(status: 'open')
    end

    field :findResearch, Types::ResearchType, null: true do
      argument :id, ID, required: true
    end

    def findResearch(id:)
      validate_user(context[:current_user])
      Research.where(status: 'closed').find_by(id: id)
    end

    field :closedResearch, [Types::ResearchType], null: false
    def closedResearch
      validate_user(context[:current_user])
      Research.where(status: 'closed')
    end

    field :researchResults, resolver: Resolvers::ResearchResults

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
