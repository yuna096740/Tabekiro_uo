# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create(
  email:    "mail@gmail.com",
  password: "123456"
  )

Member.create(
  nickname:     "うお太郎",
  email:        "mail@gmail.com",
  password:     "123456",
  introduction: "お魚大好きです！",
  status:        0
)

Tag.create([
  {name: '小魚'},
  {name: '中型魚'},
  {name: '大型魚'},
  {name: '青魚'},
  {name: '白身魚'},
  {name: '赤身魚'}
])
