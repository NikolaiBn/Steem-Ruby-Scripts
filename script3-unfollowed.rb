require 'radiator'

options = {
  ur: 'https://api.steemit.com',
  failover_urls: [
    'https://api.steemitstage.com'
  ]
}

api = Radiator::Api.new(options)

my_account = api.find_account('cryptonik')
puts "Looking up account data..."
puts "Account: #{my_account.name}"

$steem_balance=my_account.balance.to_f
$sbd_balance=my_account.sbd_balance.to_f
$voting_power=(my_account.voting_power/100.to_f)
$reputation=((Math::log10(my_account.reputation.to_f)-9)*9+25)

puts "Reputation:   %.2f" % $reputation
puts "Voting power: %.2f" % $voting_power
puts "Balance (STEEM): %.2f" % $steem_balance 
puts "Balance (SBD): %.2f"   % $sbd_balance


followapi = Radiator::FollowApi.new
response  = followapi.get_followers('cryptonik', 200, 'blog', 100)
followers_ary = response.result.map(&:follower)
$sum_followers=followers_ary.length

puts "followers: #{$sum_followers}"


