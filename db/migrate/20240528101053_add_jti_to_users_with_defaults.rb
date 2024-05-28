class AddJtiToUsersWithDefaults < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :jti, :string

    # Заполняем jti для существующих пользователей
    User.reset_column_information
    User.find_each do |user|
      user.update_column(:jti, SecureRandom.uuid)
    end

    # Устанавливаем jti как не null и добавляем уникальный индекс
    change_column_null :users, :jti, false
    add_index :users, :jti, unique: true
  end
end
