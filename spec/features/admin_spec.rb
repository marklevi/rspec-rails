require 'spec_helper'



  feature 'Admin panel' do
    let! (:post) do
    Post.create title: "titlebla",
                content: "blacontent",
                is_published: true
    end

  context "on admin homepage" do
    it "can see a list of recent posts" do
      visit admin_posts_path
      expect(page).to have_content "Titlebla"
    end
    it "can edit a post by clicking the edit link next to a post" do
      visit admin_posts_path
      click_link "Edit"
      expect(page).to have_content "Titlebla"
    end

    it "can delete a post by clicking the delete link next to a post" do
      visit admin_posts_path
      expect {
         click_link 'Delete'
       }.to change(Post, :count).by(-1)
    end

    it "can create a new post and view it" do
       visit new_admin_post_url

       expect {
         fill_in 'post_title',   with: "Hello world!"
         fill_in 'post_content', with: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat."
         page.check('post_is_published')
         click_button "Save"
       }.to change(Post, :count).by(1)

       page.should have_content "Published: true"
       page.should have_content "Post was successfully saved."
     end
  end

  context "editing post" do
    it "can mark an existing post as unpublished" do
      visit admin_posts_path
      click_link "Edit"
      page.uncheck('post_is_published')
      click_button "Save"
      page.should have_content "Published: false"
    end
  end

  context "on post show page" do
    it "can visit a post show page by clicking the title" do
      visit posts_path
      click_link 'Titlebla'
      page.should have_content 'Titlebla'
      expect(page.current_path).to eq("/posts/#{post.id}")
    end

    it "can see an edit link that takes you to the edit post path" do
      visit posts_path
      click_link "Edit"
      expect(page.current_path).to eq("/posts/#{post.id}/edit")
    end

    it "can go to the admin homepage by clicking the Admin welcome page link" do

    end
  end
end

