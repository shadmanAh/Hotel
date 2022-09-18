class RoomPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

	def show?
		@user.has_role?(:admin) || @record.hostel.user_id == @user.id
	end

  def edit?
    @user.present? && @record.hostel.user_id == @user.id
  end

  def update?
		@record.hostel.user_id == @user.id
	end

  def new?
    # @record.hostel.user_id == @user.id
  end

  def create?
    @record.hostel.user_id == @user.id
  end

  def destroy?
    @record.hostel.user_id == @user.id
  end
end
