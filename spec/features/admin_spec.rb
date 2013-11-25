require 'spec_helper'

  

feature 'Admin panel' do
  let! (:post) do 
    Post.create title: "bla",
                content: "blacontent",
                is_published: true
    end

  context "on admin homepage" do
    xit "can see a list of recent posts" do 
      visit admin_posts_path
      expect(page).to have_content "blacontent"
    end
    xit "can edit a post by clicking the edit link next to a post"

    xit "can delete a post by clicking the delete link next to a post"

    xit "can create a new post and view it" do
       visit new_admin_posts_url

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
    xit "can mark an existing post as unpublished" do
      pending # remove this line when you're working on implementing this test

      page.should have_content "Published: false"
    end
  end

  context "on post show page" do
    xit "can visit a post show page by clicking the title"

    xit "can see an edit link that takes you to the edit post path"

    xit "can go to the admin homepage by clicking the Admin welcome page link"
  end
end

