class CreatePickUps < ActiveRecord::Migration
  def self.up
    create_table :pick_ups do |t|
      t.integer :owner_account_id
      t.integer :owner_article_id
      t.integer :wire_article_id

      t.timestamps
    end
  end

  def self.down
    drop_table :pick_ups
  end
end
