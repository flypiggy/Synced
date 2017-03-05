FactoryGirl.define do
  factory :image do
    file { Rack::Test::UploadedFile.new(Rails.root.join('app', 'assets', 'images', 'admin', 'user-bg.jpg')) }
  end
end
