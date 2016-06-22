#Seed Users
15.times do
    User.create!(
        email: RandomData.random_email,
        password: RandomData.random_sentence,
        username: RandomData.random_word
        )
end
users = User.all

#Seed Wikis
10.times do
    Wiki.create!(
        title: RandomData.random_sentence,
        body: RandomData.random_paragraph,
        user: users.sample
        )
end
wikis = Wiki.all

#Seed wiki Pages
50.times do
   Page.create!(
       title: RandomData.random_sentence,
       body: RandomData. random_paragraph,
       wiki: wikis.sample
       ) 
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
puts "#{Page.count} pages created"
