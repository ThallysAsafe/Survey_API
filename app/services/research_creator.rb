class ResearchCreator < ApplicationService
  def initialize(arguments)
    @arguments = arguments[:input]
    @title = @arguments[:title]
    @status = @arguments[:status]
  end

  def call
    create_research
  end

  private

  def create_research
    research = ::Research.create(title: @title, status: @status)
    {  research: research }
  end
end
