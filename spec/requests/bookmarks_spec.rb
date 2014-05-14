require 'spec_helper'

describe "Bookmark pages" do
  let(:bookmark) { FactoryGirl.create(:bookmark) }

  describe "create" do

    before { visit new_bookmark_path } 

    let(:add_link) { "Add link" }
    let(:submit)   { "Save link" }

    describe "with valid information" do
      fill_in 'Url', with: "#{bookmark.url}"
      click_button add_link
      it { should have_content("Example Domain") }
    end
  end
end
