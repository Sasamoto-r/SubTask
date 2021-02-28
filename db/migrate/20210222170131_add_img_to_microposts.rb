class AddImgToMicroposts < ActiveRecord::Migration[6.0]
  def change
    add_column :microposts, :img, :string
  end
end
