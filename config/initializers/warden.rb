Rails.application.config.middleware.insert_after ActionDispatch::Flash, Warden::Manager do |manager|
   
end
