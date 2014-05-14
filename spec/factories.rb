FactoryGirl.define do
  factory :bookmark do
    url        "http://example.com/documentation"
    tilte      "Example Domain"
    short_link "http://bit.ly/1je9djX"
    domain
    tag
  end

  factory :domain do
    id         "1000"
    name       "http://example.com"
  end

  factory :tag do
    name       "tag_example"
    bookmark
  end

end