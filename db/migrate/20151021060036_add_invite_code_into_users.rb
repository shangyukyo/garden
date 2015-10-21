class AddInviteCodeIntoUsers < ActiveRecord::Migration
  def change
    add_column :users, :used_invite_code, :boolean, null: false, default: false, after: :private_token 
     
  end
end
