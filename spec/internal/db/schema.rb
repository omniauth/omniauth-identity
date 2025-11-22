# frozen_string_literal: true

ActiveRecord::Schema.define do
  create_table :users, force: true do |t|
    t.string :name, null: false
    t.string :email, null: false
    t.string :password_digest, null: false
    t.timestamps null: false
  end

  add_index :users, :email, unique: true
end

