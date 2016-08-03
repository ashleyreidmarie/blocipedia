#Seed Users
15.times do
    username = Faker::Name.first_name
    User.create!(
        username: username,
        email: Faker::Internet.safe_email(username),
        password: Faker::Internet.password(6, 15),
        confirmed_at: Date.today
        )
end

#Test user
User.create!(
    email: Faker::Internet.safe_email,
    password: "helloworld",
    username: "Marie",
    confirmed_at: Date.today
    )
    
users = User.all


#Seed Muds
5.times do
   Mud.create!(
       name: Faker::Company.name,
       url: Faker::Internet.url,
       approved: true
       ) 
end

Mud.create!(
   name: "Lusternia, Age of Ascension",
   url: "http://www.lusternia.com/",
   approved: true
   )
   
muds = Mud.all

#Seed Wikis
20.times do
    Wiki.create!(
        name: Faker::Book.title,
        description: Faker::Hipster.paragraph,
        user: users.sample,
        mud: muds.sample
        )
end
Wiki.create!(
    name: "Lusternia Skills",
    description: "List of all skills in Lusternia.",
    user: User.last,
    mud: Mud.last
    )
wikis = Wiki.all

#Seed wiki Pages
50.times do
   Page.create!(
       title: Faker::Commerce.product_name,
       body: Faker::Hipster.paragraph,
       wiki: wikis.sample
       ) 
end
Page.create!(
   title: "Knighthood",
   body: "You have gained the following abilities in Knighthood:
Striking            Strike out with your weapons.
Raze                Attack the defences that would keep your weapons out.",
   wiki: Wiki.last
   ) 



puts "Seed finished"
puts "#{User.count} users created"
puts "#{Mud.count} muds created"
puts "#{Wiki.count} wikis created"
puts "#{Page.count} pages created"
