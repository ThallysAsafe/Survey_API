class QuestionDelete < ApplicationService

  def initialize(arguments)
    @arguments = arguments


  end

  def call
    delete_question
  end

  private

  def delete_question
    question = ::Question.find_by(id: @arguments[:id])

    if question
      if question.destroy
        { question: nil, errors: [] }
      else
        { question: nil, errors: question.errors.full_messages }
      end
    else
      { question: nil, errors: ["Pergunta não encontrada"] }
    end
  end
end
