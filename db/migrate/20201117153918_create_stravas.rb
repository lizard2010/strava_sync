class CreateStravas < ActiveRecord::Migration[6.0]
  def change
    create_table :stravas do |t|
      t.string :code
      t.string :scope
      t.string :state
      t.integer :expires_at
      t.integer :expires_in
      t.string :refresh_token 
      t.string :access_token
      t.timestamps
    end
  end
end
