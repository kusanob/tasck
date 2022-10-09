# coding: utf-8

User.create!( name: "Sample User",
              email: "sample@email.com",
              password: "password",
              password_confirmation: "password",
              admin: true)
              

100.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n+1}@email.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end


50.times do
  user = User.take(3)
  title = Faker::JapaneseMedia::OnePiece.character
  detail = Faker::JapaneseMedia::OnePiece.akuma_no_mi
  user.each {
    |user| user.tasks.create!(title: title, 
                             detail: detail,
                             user_id: user
                             )
  }

               
end
