#Seed Users
15.times do
    User.create!(
        email: RandomData.random_email,
        password: RandomData.random_sentence,
        username: RandomData.random_word,
        confirmed_at: Date.today
        )
end

#Test user
User.create!(
    email: RandomData.random_email,
    password: "helloworld",
    username: "Marie",
    confirmed_at: Date.today
    )
    
users = User.all


#Seed Muds
5.times do
   Mud.create!(
       name: RandomData.random_title,
       url: "https://www.google.com/",
       verified: true
       ) 
end

Mud.create!(
   name: "Lusternia, Age of Ascension",
   url: "http://www.lusternia.com/",
   verified: true
   )
   
muds = Mud.all

#Seed Wikis
10.times do
    Wiki.create!(
        name: RandomData.random_title,
        description: RandomData.random_paragraph,
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
       title: RandomData.random_title,
       body: RandomData. random_paragraph,
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
