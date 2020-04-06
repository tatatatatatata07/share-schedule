class CreateMeetings < ActiveRecord::Migration[5.1]
  def change
    create_table :meetings do |t|
      t.text :title
      t.references :user, foreign_key: true
      t.datetime :start_time
      t.text :content

      t.timestamps
    end
  end
end
