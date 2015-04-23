require 'rails_helper'

describe PostsController, type: :controller do
  describe "GET #index" do
    let!(:post_1) { create(:post) }
    let!(:post_2) { create(:post) }

    it 'renders the :index view' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'returns all posts' do
      get :index
      expect(assigns(:posts)).to eq([post_1, post_2])
    end
  end

  describe "GET #new" do
    it 'renders the :new view' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'assigns a new post to @post' do
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe "GET #edit" do
    let!(:post) { create(:post) }

    it 'renders the :edit view' do
      get :edit, id: post
      expect(response).to render_template(:edit)
    end

    it 'retrieves the correct post object' do
      get :edit, id: post
      expect(assigns(:post)).to eq(post)
    end
  end

  describe "GET #show" do
    let!(:post) { create(:post) }

    it 'renders the :show view' do
      get :show, id: post
      expect(response).to render_template(:show)
    end

    it 'retrives the correct post object' do
      get :show, id: post
      expect(assigns(:post)).to eq(post)
    end
  end

  describe "POST #create" do
    context 'with valid attributes' do
      it 'saves the new post in the database' do
        expect { post :create, post: attributes_for(:post)
          }.to change(Post, :count).by(1)
      end

      it 'redirects to the post show page' do
        post :create, post: attributes_for(:post)
        expect(response).to redirect_to(post_path(assigns(:post)))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new post to the database' do
        expect { post :create, post: attributes_for(:invalid_post)
          }.to_not change(Post, :count)
      end

      it 're-renders the :new template' do
        post :create, post: attributes_for(:invalid_post)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH #update" do
    let!(:post) { create(:post) }

    context 'with valid attributes' do
      it 'locates the correct post' do
        patch :update, id: post, post: attributes_for(:post)
        expect(assigns(:post)).to eq(post)
      end

      it 'updates the correct attribute' do
        patch :update, id: post, post: attributes_for(:post, name: "Renamed Post!")
        post.reload
        expect(post.name).to eq("Renamed Post!")
      end

      it 're-directs to the correct template' do
        patch :update, id: post, post: attributes_for(:post)
        expect(response).to redirect_to(:post)
      end
    end

    context 'with invalid attributes' do
      it 'does not update the attributes' do
        patch :update, id: post, post: attributes_for(:invalid_post)
        post.reload
        expect(post.name).to eq("Delivering Goods")
        expect(post.name).to_not eq(nil)
      end

      it 're-renders the :edit template' do
        patch :update, id: post, post: attributes_for(:invalid_post)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:post) { create(:post) }

    it 'deletes the post' do
      expect { delete :destroy, id: post
        }.to change(Post, :count).by(-1)
    end

    it 're-directs to the index page' do
      delete :destroy, id: post
      expect(response).to redirect_to(posts_path)
    end
  end
end
