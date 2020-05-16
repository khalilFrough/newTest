class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :mobile
      t.string :city
      t.text :personal_information
      t.string :avater
      t.string :password_digest
      t.string :type_of_card
      t.string :card_number
      t.string :id_card

      t.timestamps
    end
  end
end
