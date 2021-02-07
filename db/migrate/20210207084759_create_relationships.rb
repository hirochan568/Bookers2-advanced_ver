class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.references :followed, foreign_key: true
      t.references :follower, foreign_key: { to_table: :users }
      
      t.timestamps
      t.index [:followed_id, :follower_id], unique: true
      
    end
  end
end
