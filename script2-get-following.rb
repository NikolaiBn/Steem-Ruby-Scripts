require 'radiator'

options = {
  ur: 'https://api.steemit.com',
  failover_urls: [
    'https://api.steemitstage.com'
  ]
}

api = Radiator::Api.new(options)

followapi = Radiator::FollowApi.new
response  = followapi.get_followers('cryptonik', 0, 'blog', 1000)
$followers_ary = response.result.map(&:follower)

$following_ary = followapi.get_following('cryptonik',0, 'blog',100).result.map(&:following)
$fetch_next = followapi.get_following('cryptonik',"#{$following_ary[99]}", 'blog',100).result.map(&:following)
$following_ary.pop
$following_ary.push(*$fetch_next)

loop do 
$fetch_next = followapi.get_following('cryptonik',"#{$fetch_next[99]}",'blog',100).result.map(&:following)
$following_ary.pop
$following_ary.push(*$fetch_next)

break if($fetch_next.length<98)
end 

puts "Done fetching data for 'cryptonik'..."
puts "\nYou have #{$followers_ary.length} followers:"
for i in 0..19 
$stdout.print("#{$followers_ary[i]}, ")
end
$stdout.print("...and #{$followers_ary.length-20} more")

puts "\n\nYou are following #{$following_ary.length} users:"
for i in 0..19 
$stdout.print("#{$following_ary[i]}, ")
end
$stdout.print("...and #{$following_ary.length-20} more")

$diff=$following_ary-$followers_ary
puts "\n\n#{$diff.length} users are not following you back:"
for i in 0..19 
$stdout.print("#{$diff[i]}, ")
end
$stdout.print("...and #{$diff.length-20} more")

$diff2=$followers_ary-$following_ary
puts "\n\nYou don't follow back #{$diff2.length} users:"
for i in 0..19 
$stdout.print("#{$diff2[i]}, ")
end
$stdout.print("...and #{$diff2.length-20} more\n\n")



