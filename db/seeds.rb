# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(user_name: "テスト",
              email: "test@icloud.com",
              password: "password",
              admin: 'true'
            )

10.times do |i|
  Tag.create!(name: "sample#{i + 1}")
end

10.times do |n|
  User.create!(
    email: "user#{n+1}@example.com",
    password: "password" )
 end

#  10.times do |t|
#   Task.create!(
#     title: "task#{n+1}",
#     content: "content#{n+1}"
#     created_at: "2022/12/16"
#     expired_at: "2022/12/16"
#     status: 1
#     priority: 1
#     user_id:
#     )
#  end

 User.all.each do |user|
  Task.create!(
   user_id: user.id,
   title: "title",
   content: "content",
   created_at: "2022/11/07",
   expired_at: "2022/12/16",
   status: 1
   priority: 1
  )
 end