class CreateShifts < ActiveRecord::Migration[5.2]
  def change
    create_table :shifts do |t|
      t.references :staff
      t.integer :content_of_work
   	  t.date :date
      t.datetime :start
      t.datetime :end
      t.timestamps
    end
  end
end
