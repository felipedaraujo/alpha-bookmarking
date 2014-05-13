class RenameTaggingsToBookmarksTags < ActiveRecord::Migration
  def change
    rename_table :taggings, :bookmarks_tags
  end
end
