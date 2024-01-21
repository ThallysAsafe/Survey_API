class Types::UserType < Types::BaseObject
  description 'A user'

  field :id, ID, null: false
  field :username, String, null: false
  field :password_digest, String, null: false

  field :token, String, null: false
end
