module UsersHelper
  def handle_admin(user)
    return '' unless admin_signed_in?

    return become_admin_link(user.id) unless user.admin?
    return revoke_admin_link(user.id)
  end

  private

  def revoke_admin_link(id)
    text = t(:revoke_admin)
    link_to(text, revoke_admin_path(id), { method: :patch, class: "btn btn-danger"})
  end

  def become_admin_link(id)
    text = t(:become_admin)
    link_to(text, become_admin_path(id), {method: :patch, class: "btn btn-info"})
  end
end
