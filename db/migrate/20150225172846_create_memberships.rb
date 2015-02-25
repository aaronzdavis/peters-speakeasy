class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.string :email
      t.string :name

      t.timestamps null: false
    end
  end
end
