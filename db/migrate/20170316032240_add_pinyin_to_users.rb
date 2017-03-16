class AddPinyinToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name, :string
    add_column :users, :pinyin, :string
    add_column :users, :pinyin_abbr, :string

    add_index :users, :username
    add_index :users, :pinyin
    add_index :users, :pinyin_abbr
  end

end
