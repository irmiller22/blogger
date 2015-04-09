require 'rails_helper'

describe Post, type: :model do
  it 'has a valid factory' do
    expect(build(:post)).to be_valid
  end

  describe 'model validations' do
    it 'is valid with a name and content' do
      post = build(:post)
      expect(post).to be_valid
    end

    it 'is invalid without a name' do
      post = build(:post, name: nil)
      expect(post).to_not be_valid
    end

    it 'is invalid without content' do
      post = build(:post, content: nil)
      expect(post).to_not be_valid
    end
  end

  describe 'model attributes' do
    let(:post) { create(:post) }

    it 'has a #name attribute' do
      expect(post.name).to eq("Delivering Goods")
    end

    it 'has a #content attribute' do
      expect(post.content).to eq("In order to deliver goods, you should...")
    end
  end

end
