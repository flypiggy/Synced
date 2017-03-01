class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.string :email,           unique: true, index: true
      t.string :password_digest, null: false, default: ""

      t.string :username
      t.string :mobile,          unique: true, index: true
      t.string :roles,           array: true, default: []

      t.string :city
      t.string :company
      t.string :title
      t.string :avatar
      t.string :bio
    end
  end
end
