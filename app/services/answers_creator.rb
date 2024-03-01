class AnswersCreator < ApplicationService

  def initialize(user,response)
    @data = []
    @research_id = response[0][:research_id]
    response.each do |answer|
      params_answer(answer,user)
    end
  end

  def call
    answer_create
  end

  private

  def answer_create
    if check_research_completion()
      created_answer = ::Answer.create!(@data)
      { answers: created_answer, errors: nil }
    else
      { answers: nil, errors: ['A pesquisa ainda não foi concluída. Responda às outras questões pendentes.'] }
    end
  end

  def params_answer(answer,user)
    question = ::Question.find_by(id: answer.question_id)

    if question && (question.type_question == "text" && (question.options_answer[0] == "single-line" || question.options_answer[0] == "mult-line")) || ((question.type_question == "radio" && answer.answer.length == 1)) || (question.type_question == "checkbox" && (answer.answer.length >= 1 && answer.answer.length <= 5))
      if question.type_question == "text" &&  question.options_answer[0] == "single-line" && answer.answer[0].length >= 120
        raise GraphQL::ExecutionError, "Tamanho da resposta acima do esperado, resposta aceita só abaixo de 80 caracteres."
      end

      @data.append({research_id: answer.research_id, question_id: answer.question_id, answer: answer.answer, user_id: user})
    else
      raise GraphQL::ExecutionError,"Resposta Inválida, porfavor revise as respostas se está dentro dos parametros"
    end
  end

  def check_research_completion
    research = Research.find(@research_id)
    total_questions = research.questions.count
    tamanho_data = @data.length
    if research.status == 'open'
      return total_questions == tamanho_data
    else
      raise GraphQL::ExecutionError,"A pesquisa selecionada está fechada."
    end
    return false
  end
end
