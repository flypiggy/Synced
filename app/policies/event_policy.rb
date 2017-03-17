class EventPolicy < ApplicationPolicy
  def index?
    user.roles.include?('organizer') || admin?
  end

  alias create? index?
  alias update? index?
  alias destroy? index?
end
