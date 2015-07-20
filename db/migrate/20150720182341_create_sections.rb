class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :title
      t.references :user
      t.timestamps
    end
  end
end
