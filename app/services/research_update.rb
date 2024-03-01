class ResearchUpdate < ApplicationService

  def initialize(arguments)
    @arguments = arguments[:input]
    @id = arguments[:id]

  end

  def call
    research_update
  end

  private

  def research_update
    research = ::Research.find(@id)
    if research
      update_params = {}
      update_params[:title] = @arguments[:title] if @arguments[:title]
      update_params[:status] = @arguments[:status] if @arguments[:status]
      research.update(update_params)
      { research: research, errors: [] }
    else
      { research: nil, errors: research.errors.full_messages }
    end
  end
end
