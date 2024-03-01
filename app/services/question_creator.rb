class QuestionCreator < ApplicationService

  def initialize(arguments)
    @arguments = arguments
    @research_id = arguments[:research_id]

  end

  def call
    create_question
  end

  private

  def create_question
    params_question()
    research = ::Research.find(@research_id)
    if research
      question = ::Question.create(
        name: @arguments[:input][:name],
        type_question: @arguments[:input][:type_question],
        research_id: @research_id,
        options_answer: @arguments[:input][:options_answer] )
      { question: question }
    else
      { question: nil }
    end
  end

  def params_question
    unless (1 <= @arguments[:input][:options_answer].length && @arguments[:input][:options_answer].length <= 5) || @arguments[:type_question][0] == "text"
      raise GraphQL::ExecutionError, 'As opções de resposta tem que ser entre 1 a 5 opções'
    end
    if @arguments[:input][:type_question] == "text"
      unless @arguments[:input][:options_answer].length == 1 && (@arguments[:input][:options_answer][0] == "single-line" || @arguments[:input][:options_answer][0] == "mult-line")
        raise GraphQL::ExecutionError, 'Esse tipo de questão só permite single-line ou mult-line no campo optionsAnswer'
      end
    end
  end
end
0
