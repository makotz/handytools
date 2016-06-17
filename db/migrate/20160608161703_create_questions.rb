#Migration are used to change teh structure of the database.
#For exg:
#- Creating/deleting tables
#- adding/removing columns from tables
#- adding/removing indexes


class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.text :body
      #
      t.timestamps null: false
    end
  end
end
