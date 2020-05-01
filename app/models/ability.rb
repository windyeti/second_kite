# TODO Тесты класса ability
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

    can :show, Kite, { user_id: user.id }
    can :update, Kite, { user_id: user.id }
    can :destroy, Kite, { user_id: user.id }
    can :create, Kite

    can :show, Account, { user_id: user.id }

    can :read, Brand

    can :destroy, ActiveStorage::Attachment, record: { user_id: user.id }

    can :create, Board
    can :show, Board, { user_id: user.id }
    can :update, Board, { user_id: user.id }
    can :destroy, Board, { user_id: user.id }

    can :create, Bar
    can :show, Bar, { user_id: user.id }
    can :update, Bar, { user_id: user.id }
    can :destroy, Bar, { user_id: user.id }

    can :create, Stuff
    can :show, Stuff, { user_id: user.id }
    can :update, Stuff, { user_id: user.id }
    can :destroy, Stuff, { user_id: user.id }
  end

  def guest
    can :read, Ad
    can :kites, Ad
    can :boards, Ad
    can :bars, Ad
    can :stuffs, Ad
  end
end
