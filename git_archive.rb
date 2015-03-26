repo = ARGV[0]
remoteUrl = ARGV[1]

if !(repo && remoteUrl)
  puts "Improper arguments! Come on guys!"
  return
end

puts `git remote add -f #{repo} #{remoteUrl}`
puts `git merge -s ours --no-commit #{repo}/master`
puts `git read-tree --prefix=#{repo}/ -u #{repo}/master`
puts `git commit -m "Subtree merged in #{repo}"`
