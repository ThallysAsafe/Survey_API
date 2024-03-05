class Research < ApplicationRecord
  has_many :questions, dependent: :destroy
  validates :title, presence: true
  validates :status, presence: true
  enum status: { open: 'open', closed: 'closed' }
  has_many :answer

end
