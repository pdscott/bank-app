class UserPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def index?
    @current_user.admin? or @current_user.superadmin? or @current_user == @user
  end

  def show?
    @current_user.admin? or @current_user.superadmin? or @current_user == @user
  end

  def update?
    @current_user.admin? or @current_user.superadmin?
  end

  def edit?
    @current_user.admin? or @current_user.superadmin?
  end

  def destroy?
    @current_user == @user or @current_user.admin? or @current_user.superadmin?
  end

  def new?
    @current_user.admin? or @current_user.superadmin? or @current_user == @user
  end

  def create?
    @current_user.admin? or @current_user.superadmin? or @current_user == @user
  end

end
