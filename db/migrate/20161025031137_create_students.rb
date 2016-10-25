class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :sname
      t.string :sex
      t.integer :age

      t.timestamps null: false
    end
  end
end
