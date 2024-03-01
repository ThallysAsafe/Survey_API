class QuestionUpdate < ApplicationService
  def initialize(arguments)
    @arguments = arguments


  end

  def call
    question_update
  end

  private

  def question_update
    question = Question.find_by(id: @arguments[:id])
    if question
      if question.update(@arguments[:update].to_h)
        { question: question, errors: [] }
      else
        { question: nil, errors: question.errors.full_messages }
      end
    else
      { question: nil, errors: ["Pergunta não encontrada"] }
    end
  end
end
