class AddStateToCookies < ActiveRecord::Migration[5.1]
  def change
    add_column :cookies, :state, :string
  end
end
