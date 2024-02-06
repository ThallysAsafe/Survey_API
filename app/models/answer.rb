class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :research
  belongs_to :user
end
