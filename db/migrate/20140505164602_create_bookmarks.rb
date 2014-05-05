class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.string :title
      t.string :url
      t.string :short_url

      t.timestamps
    end
  end
end
