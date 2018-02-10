require 'radiator'

api = Radiator::FollowApi.new
api.get_followers('cryptonik', 0, 'blog', 1000) do |followers|
puts followers.map(&:follower)
$sum=followers.length
puts("You have = #$sum followers" )
end

