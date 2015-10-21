class AddInviteIntoUsers < ActiveRecord::Migration
  def change
    add_column :users, :invite_code, :string, after: :private_token     
  end
end
