require 'jwt'

FactoryBot.define do
  factory :user do
    username { Faker::Internet.username }
    password { Faker::Internet.password }
    role { %w[coordinators responders].sample }

    # Gera um token JWT com um payload fictício automaticamente ao criar um usuário
    after(:create) do |user|
      payload = { user_id: user.id, username: user.username, role: user.role }
      secret_key = 'your_secret_key'  # Substitua pelo segredo real que você usaria em sua aplicação
      user.update(token: JWT.encode(payload, secret_key, 'HS256'))
    end
  end
end
