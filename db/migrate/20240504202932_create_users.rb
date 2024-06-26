class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email,  null: false, default: ""
      t.string :password
      t.string :username
      t.string :role

      t.timestamps
    end
  end
end
