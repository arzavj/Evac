class AddDeviseToUsers < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
       # t.string "encrypted_password",  :default => "", :null => false 
       # t.string "password_salt",  :default => "", :null => false
    
    ## Recoverable
    t.string   :reset_password_token
    t.datetime :reset_password_sent_at
    ## Rememberable
    t.datetime :remember_created_at
    
    ## Trackable
    t.integer  :sign_in_count, :default => 0
    t.datetime :current_sign_in_at
    t.datetime :last_sign_in_at
    t.string   :current_sign_in_ip
    t.string   :last_sign_in_ip
    
    ## Confirmable
     t.string   :confirmation_token
     t.datetime :confirmed_at
     t.datetime :confirmation_sent_at
     t.string   :unconfirmed_email # Only if using reconfirmable

    end
        add_index :users, :email,                :unique => true
        add_index :users, :reset_password_token, :unique => true
        add_index :users, :confirmation_token,   :unique => true
  end

  def self.down
   remove_index :users, :email
   remove_index :users, :reset_password_token
   remove_index :users, :confirmation_token
   remove_column :users,  :confirmation_token
   remove_column :users, :confirmed_at
   remove_column :users, :confirmation_sent_at
   remove_column :users, :encrypted_password
   remove_column :users, :password_salt
   remove_column :users, :reset_password_token
   remove_column :users, :reset_password_sent_at
   remove_column :users, :remember_created_at
   remove_column :users, :sign_in_count
   remove_column :users, :current_sign_in_at
   remove_column :users, :last_sign_in_at
   remove_column :users, :current_sign_in_ip
   remove_column :users, :last_sign_in_ip
  end
end
