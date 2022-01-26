class CommentPolicy < ApplicationPolicy

  def index?
    true
  end

  def create?
    owner?
  end

  def edit?
    owner?
  end

  def update?
    owner?
  end

  def destroy?
    owner?
  end

  private

  def owner?
    record.user_id == user.id
  end
end
