class User < ApplicationRecord
  has_secure_password
  enum role: {coordinators: 'coordinator', responders: 'responder' }
  

end
