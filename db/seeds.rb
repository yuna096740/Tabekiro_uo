# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create(
  email:"admin@tabekiro.com", password: "123456"
)

Member.create([
  { nickname: "test太郎", email: "test@tabekiro.com",  password: "123456", introduction: "お魚大好きです！",   status: 0 },
  { nickname: "うお一郎", email: "mail1@tabekiro.com", password: "123456", introduction: "お魚LOVEです！",     status: 0 },
  { nickname: "うお二郎", email: "mail2@tabekiro.com", password: "123456", introduction: "お魚好物です！",     status: 0 },
  { nickname: "うお三郎", email: "mail3@tabekiro.com", password: "123456", introduction: "お魚マニアです！",   status: 0 },
  { nickname: "うお四郎", email: "mail4@tabekiro.com", password: "123456", introduction: "お魚博士です！",     status: 0 },
  { nickname: "うお五郎", email: "mail5@tabekiro.com", password: "123456", introduction: "お魚屋さんです！",   status: 0 },
  { nickname: "うお六郎", email: "mail6@tabekiro.com", password: "123456", introduction: "お魚大好物です！",   status: 0 },
  { nickname: "うお七郎", email: "mail7@tabekiro.com", password: "123456", introduction: "お魚紳士です！",     status: 0 },
  { nickname: "うお八郎", email: "mail8@tabekiro.com", password: "123456", introduction: "お魚さんです！",     status: 0 },
  { nickname: "うお九郎", email: "mail9@tabekiro.com", password: "123456", introduction: "お魚おじさんです！", status: 0 }
])

Tag.create([
  { name: '小魚' }, { name: '大型魚' }, { name: '青魚' }, { name: '白身魚' }, { name: '赤身魚' }
])

Post.create([
  { member_id: 1,  tag_id: 1, title: "神奈川県産太刀魚", introduction: "炙っても美味しい！", limit: 1,
    latitude: 35.33410148363077,  longitube: 139.63108452578126, place_name: "金沢八景", open_status: 0,
    post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/1tachiuo.jpg"), filename:"1tachiuo.jpg")
  },

  { member_id: 2,  tag_id: 2, title: "千葉県産めじな", introduction: "煮付けがおすすめです！", limit: 2,
    latitude: 34.9965461, longitube: 139.870044, place_name: "館山", open_status: 0,
    post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/2mezina.jpg"), filename:"2mezina.jpg")
  },

  { member_id: 3,  tag_id: 3, title: "横浜で釣れたアジ", introduction: "小さいので唐揚げに！", limit: 3,
    latitude: 35.4436739, longitube: 139.6379639, place_name: "横浜", open_status: 0,
    post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/3azi.jpg"), filename:"3azi.jpg")
  },

  { member_id: 4,  tag_id: 4, title: "佐渡産天然真鯛",   introduction: "鮮度抜群です！", limit: 4,
    latitude: 38.02593887241749, longitube: 138.24258782890624, place_name: "佐渡島", open_status: 0,
    post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/4madai.jpg"), filename:"4madai.jpg")
  },

  { member_id: 5,  tag_id: 5, title: "出雲崎産カマス",   introduction: "塩焼きがうまいです！", limit: 5,
    latitude: 37.548331217698326, longitube: 138.6907733453125, place_name: "出雲崎", open_status: 0,
    post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/5kamasu.jpg"), filename:"5kamasu.jpg")
  },

  { member_id: 6,  tag_id: 1, title: "宮古市産ヒラメ",   introduction: "ムニエルにどうぞ！", limit: 6,
    latitude: 39.64898166657326, longitube: 141.97098033828124, place_name: "宮古", open_status: 0,
    post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/6hirame.jpg"), filename:"6hirame.jpg")
  },

  { member_id: 7,  tag_id: 2, title: "陸前高田産牡蠣",   introduction: "殻付の牡蠣です", limit: 7,
    latitude: 38.987202080844355, longitube: 141.67356528554689, place_name: "陸前高田", open_status: 0,
    post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/7kaki.jpg"), filename:"7kaki.jpg")},

  { member_id: 8,  tag_id: 3, title: "大阪湾石持",   introduction: "しおやきがうまい！です！", limit: 8,
    latitude: 34.452097494689426, longitube: 134.9204705429688, place_name: "大阪湾", open_status: 0,
    post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/8ishimothi.jpg"), filename:"8ishimothi.jpg")
  },

  { member_id: 9,  tag_id: 4, title: "高知県産カツオ",   introduction: "藁焼でどうぞ！", limit: 9,
    latitude: 33.49133680560353, longitube: 133.56145070234376, place_name: "高知", open_status: 0,
    post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/9kastuo.jpg"), filename:"9kastuo.jpg")
  },

  { member_id: 10, tag_id: 5, title: "長崎県産金目鯛",   introduction: "脂ノってます！", limit: 10,
    latitude: 32.7226093995921, longitube: 129.82433045039062, place_name: "長崎市", open_status: 0,
    post_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/10kinmedai.jpg"), filename:"10kinmedai.jpg")},
  ])

Member.all.each do |member|
  Post.all.each do |post|
    member.post_comments.create!([
      { member_id: member.id, post_id: post.id, comment: "こんにちは！" },
      { member_id: member.id, post_id: post.id, comment: "こちらのお魚はまだお裾分け可能でしょうか。" },
    ])
  end
end
