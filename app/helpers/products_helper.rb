# frozen_string_literal: true

module ProductsHelper
  def get_owner(owner_id)
    User.find_by(id: owner_id).email
  end
end
