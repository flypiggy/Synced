class PasswordStrategy < ::Warden::Strategies::Base
  def valid?
    params['login_name'].present? && params['password'].present?
  end

  def authenticate!
    user = User.search_by_login_name(params['login_name'])
    if user&.authenticate(params['password'])
      success!(user)
    else
      fail!(params['login_name'])
    end
  end
end
