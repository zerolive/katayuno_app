module ApplicationHelper
  NO_LINK = ''

  def session_actions
    return log_out_link if user_signed_in?

    log_in_link
  end

  def logged_user
    return current_user.email if user_signed_in?

    ''
  end

  def admin_users
    text = t(:admin_users)
    return link_to(text, users_path, { class: "nav-link" }) if admin_signed_in?

    NO_LINK
  end

  private

  def user_owns?(example_id)
    return false unless current_user

    example = Example.find(example_id)

    current_user.id == example.user
  end

  def log_out_link
    text = t(:log_out)
    link_to(text, destroy_user_session_path, { method: :delete, class: "nav-link" })
  end

  def log_in_link
    text = t(:log_in)
    link_to(text, new_user_session_path, { class: "nav-link" })
  end

  def admin_signed_in?
    return false unless user_signed_in?

    current_user.admin?
  end
end
