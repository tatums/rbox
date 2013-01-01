# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Product.delete_all
Category.delete_all

25.times do
  Category.create(title: Faker::Lorem.word, active: true)
end

100.times do
  Product.create(title: Faker::Lorem.sentence, description: Faker::Lorem.sentences.join(' ') ).categories << Category.all.sample( rand(25) )
end