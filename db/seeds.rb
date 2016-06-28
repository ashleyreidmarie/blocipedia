#Seed Users
15.times do
    User.create!(
        email: RandomData.random_email,
        password: RandomData.random_sentence,
        username: RandomData.random_word,
        confirmed_at: Date.today
        )
end
users = User.all

#Seed Wikis
10.times do
    Wiki.create!(
        name: RandomData.random_title,
        description: RandomData.random_paragraph,
        user: users.sample
        )
end
wikis = Wiki.all

#Seed wiki Pages
50.times do
   Page.create!(
       title: RandomData.random_title,
       body: RandomData. random_paragraph,
       wiki: wikis.sample
       ) 
end

#Test user
User.create!(
    email: RandomData.random_email,
    password: "helloworld",
    username: "Marie",
    confirmed_at: Date.today
    )

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
puts "#{Page.count} pages created"
