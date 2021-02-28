class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :user_name
      t.string :website
      t.string :self_introduction
      t.string :email
      t.integer :number
      t.integer :gender

      t.timestamps
    end
  end
end
