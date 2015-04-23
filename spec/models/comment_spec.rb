require 'rails_helper'

describe Comment, type: :model do
  it 'has a valid factory' do
    expect(build(:comment)).to be_valid
  end

  describe 'model validations' do
    it 'is valid with a title and body' do
      comment = build(:comment)
      expect(comment).to be_valid
    end

    it 'is invalid without a title' do
      comment = build(:comment, title: nil)
      expect(comment).to_not be_valid
    end

    it 'is invalid without a body' do
      comment = build(:comment, body: nil)
      expect(comment).to_not be_valid
    end
  end

  describe 'model attributes' do
    let(:comment) { create(:comment) }

    it 'has a #title attribute' do
      expect(comment.title).to eq("Delivering Goods")
    end

    it 'has a title equivalent to the associated post #name attribute' do
      expect(comment.title).to eq(comment.post.name)
    end

    it 'has a #body attribute' do
      expect(comment.body).to eq("The delivery man broke my jar of cookies.")
    end
  end
end
