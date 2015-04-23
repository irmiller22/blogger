require 'rails_helper'

describe PostsController, type: :controller do
  describe "GET #index" do

    it 'renders the :index view' do
    end

    it 'returns all posts' do
    end
  end

  describe "GET #new" do
    it 'renders the :new view' do
    end

    it 'assigns a new post to @post' do
    end
  end

  describe "GET #edit" do

    it 'renders the :edit view' do
    end

    it 'retrieves the correct post object' do
    end
  end

  describe "GET #show" do

    it 'renders the :show view' do
    end

    it 'retrives the correct post object' do
    end
  end

  describe "POST #create" do
    context 'with valid attributes' do
      it 'saves the new post in the database' do
      end

      it 'redirects to the post show page' do
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new post to the database' do
      end

      it 're-renders the :new template' do
      end
    end
  end

  describe "PATCH #update" do

    context 'with valid attributes' do
      it 'locates the correct post' do
      end

      it 'updates the correct attribute' do
      end

      it 're-directs to the correct template' do
      end
    end

    context 'with invalid attributes' do
      it 'does not update the attributes' do
      end

      it 're-renders the :edit template' do
      end
    end
  end

  describe "DELETE #destroy" do

    it 'deletes the post' do
    end

    it 're-directs to the index page' do
    end
  end
end
