FactoryGirl.define do
  factory :comment do
    post
    title { post.name }
    body { "The delivery man broke my jar of cookies." }
  end

end
