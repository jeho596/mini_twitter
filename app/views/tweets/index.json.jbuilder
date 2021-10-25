json.tweets do
    json.array! @tweets do |tweet|
      json.content tweet.content
    end
end