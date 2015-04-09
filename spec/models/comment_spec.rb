require 'rails_helper'

describe Comment, type: :model do
  it 'has a valid factory' do
    expect(build(:comment)).to be_valid
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
