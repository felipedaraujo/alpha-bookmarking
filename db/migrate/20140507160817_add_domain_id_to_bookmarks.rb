class AddDomainIdToBookmarks < ActiveRecord::Migration
  def change
    add_column :bookmarks, :domain_id, :integer
  end
end
