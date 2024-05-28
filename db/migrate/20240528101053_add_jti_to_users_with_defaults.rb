class AddJtiToUsersWithDefaults < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :jti, :string

    User.reset_column_information
    User.find_each do |user|
      user.update_column(:jti, SecureRandom.uuid)
    end

    change_column_null :users, :jti, false
    add_index :users, :jti, unique: true
  end
end
