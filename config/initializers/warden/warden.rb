Rails.application.config.middleware.insert_after ActionDispatch::Flash, Warden::Manager do |manager|
  manager.scope_defaults :user, strategies: [:password]
  manager.failure_app   = UnauthorizedController
  manager.default_scope = :user
end

Warden::Strategies.add(:password, PasswordStrategy)

Warden::Manager.serialize_into_session(&:id)

Warden::Manager.serialize_from_session do |id|
  User.find_by(id: id)
end
