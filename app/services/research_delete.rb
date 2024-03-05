class ResearchDelete < ApplicationService

  def initialize(arguments)
    @arguments = arguments
  end

  def call
    delete_research
  end

  private

  def delete_research
    research = ::Research.find_by(id: @arguments[:id])

    if research
      if research.destroy
        { research: nil, errors: [] }
      else
        { research: nil, errors: research.errors.full_messages }
      end
    else
      { research: nil, errors: ["Pergunta não encontrada"] }
    end
  end
end
