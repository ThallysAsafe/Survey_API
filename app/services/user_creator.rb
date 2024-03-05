class UserCreator < ApplicationService
  def initialize(arguments)
    @arguments = arguments[:input].to_hash

  end

  def call
    create_user
  end

  private

  def create_user
    @user = User.new(
      username: @arguments[:username],
      password: @arguments[:password],
      role: @arguments[:role]
      )

    if name_exist?()
      @user.save
      { user: @user }
    else
      { errors: "Nome de usuario ja existe, tente outro nome" }
    end
  end

  def name_exist?
    return User.find_by(username: @user.username) == nil
  end
end
