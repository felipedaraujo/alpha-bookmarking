require 'spec_helper'

describe "Static pages" do
  describe "Home page" do
    it "should have the content 'Alpha Bookmarking'" do
      visit '/static_pages/home'
      expect(page).to have_content('Alpha Bookmarking')
    end
  end

  describe "About page" do
    it "should have the content 'About'" do
      visit '/static_pages/about'
      expect(page).to have_content('About')
    end
  end

end
