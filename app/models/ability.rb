class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user || User.new

    if user
      user.admin? ? admin : auth_user
    else
      guest
    end

  end

  def admin
    can :manage, :all
  end

  def auth_user
    guest
    can :create, Ad
    can [:update, :destroy], Ad, { user_id: user.id }
    can :read, Kite, { user_id: user.id }
    can :create, Kite
    can :read, Account, { user_id: user.id }
    can :read, Brand
  end

  def guest
    can :read, Ad
  end
end
