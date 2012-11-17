class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :stripe_token
      t.text :bio

      t.timestamps
    end
  end
end
