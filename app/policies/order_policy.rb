class OrderPolicy < ApplicationPolicy

  def index
    true
  end

  def set_orders?
    record.user_id == user.id
  end

end
