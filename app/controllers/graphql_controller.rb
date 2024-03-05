# frozen_string_literal: true

class GraphqlController < ApplicationController
  before_action :authorize, only: [Mutations::LoginUser, Mutations::CreateUser]
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session

  def execute
    variables = prepare_variables(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      # Query context goes here, for example:
      current_user: authorized_user
    }
    result = SurveyApiSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  rescue StandardError => e
    raise e unless Rails.env.development?
    handle_error_in_development(e)
  end

  def authorized_user
    decoded_token = decode_token()
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
    end
  end

  private

  def decode_token
    auth_header = request.headers['Authorization']
    if auth_header
      token = auth_header.split(' ').last
      begin
        decoded_token = JWT.decode(token, 'secret', true, algorithm: 'HS256')
        logger.debug "Decoded Token: #{decoded_token}"
        decoded_token
      rescue JWT::DecodeError => e
        logger.error "JWT Decode Error: #{e.message}"
        nil
      end
    end
  end


  # Handle variables in form data, JSON body, or a blank value
  def prepare_variables(variables_param)
    case variables_param
    when String
      if variables_param.present?
        JSON.parse(variables_param) || {}
      else
        {}
      end
    when Hash
      variables_param
    when ActionController::Parameters
      variables_param.to_unsafe_hash
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end

  def authorize
    unless user_authenticated?
      render json: { errors: [{ message: 'Unauthorized', data: {} }], status: 401 }
    end
  end

  def user_authenticated?
    decode_token.present? && authorized_user.present?
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { errors: [{ message: e.message, backtrace: e.backtrace }], data: {} }, status: 500
  end
end
