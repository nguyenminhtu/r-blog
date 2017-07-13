class CreatePost < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
        t.string :title
        t.string :slug, uniq: true
        t.text :description
        t.text :body
        t.integer :author_id
    end
  end
end
