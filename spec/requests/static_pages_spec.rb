require 'spec_helper'

describe "static pages" do
  
  let(:base_title) { "Ruby on Rails Tutorial Sample App"}
  
  describe "home page" do
    
    it "should have the content 'sample app'" do
      visit '/static_pages/home'
      page.should have_selector('h1', text: 'Sample App')
    end
    
    it "should have the base title" do
      visit '/static_pages/home'
      page.should have_selector('title',
                                  text: "#{base_title}")
      
    end
    
    it "should have a custom title" do
      visit '/static_pages/home'
      page.should have_selector('title', text: ' | Home', )
    end
  end
  
  describe "help page" do
    it "should have the content 'help'" do
      visit '/static_pages/help'
      page.should have_selector('h1', text: 'Help')
    end
    
    it "should have the base title" do
      visit '/static_pages/help'
      page.should have_selector('title',
                                  text: "#{base_title}")
    end
    
    it "should have a custom title" do
      visit '/static_pages/help'
      page.should have_selector('title', text: ' | Help', )
    end    
  end
  
  describe "about page" do
    it "should have the content 'About Us'" do
      visit '/static_pages/about'
      page.should have_selector('h1', text: 'About Us')
    end
    
    it "should have the base title" do
      visit '/static_pages/about'
      page.should have_selector('title',
                                  text: "#{base_title}")
    end
    
    it "should have a custom title" do
      visit '/static_pages/about'
      page.should have_selector('title', text: ' | About', )
    end      
  end
  
  describe "contact page" do
    it "should have the content 'Contact'" do
      visit '/static_pages/contact'
      page.should have_selector('h1', text: 'Contact')
    end
    
    it "should have the base title" do
      visit '/static_pages/contact'
      page.should have_selector('title',
                                  text: "#{base_title}")
    end
    
    it "should have a custom title" do
      visit '/static_pages/contact'
      page.should have_selector('title', text: ' | Contact', )
    end    
  end
end