# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# 25.times do
#   State.create(name: Faker::Address.state)
# end

# 25.times do
#   Category.create(name: Faker::Address.city, active: true)
# end
# category_count = Category.all.size
# state_count = State.all.size

# 100.times do
#   product = Product.create(title: Faker::Name.first_name, description: Faker::Lorem.sentences.join(' ') )
#   product.categories << Category.all.sample( rand(category_count) )
#   product.states << State.all.sample( rand(state_count) )
#   puts "Product: #{product.title} created. Categories: #{product.categories.map(&:name).join(' ')}. States: #{product.states.map(&:name).join(' ')} \n"
# end
puts "\n\n\nDroping all data from Products, Categories, and States table's.\n\n\n"
Product.destroy_all
Category.destroy_all
State.destroy_all

State.create(title: 'Illinois')
State.create(title: 'Indiana')
State.create(title: 'Michigan')

Category.create(title: 'Grocery Stores', active: true)
Category.create(title: 'Walgreens', active: true)
Category.create(title: 'Fuel Stations', active: true)

category_count = Category.all.size
state_count = State.all.size

10.times do
  product = Product.create(title: Faker::Name.first_name, description: Faker::Lorem.sentences.join(' ') )
  product.categories << Category.all.sample( rand(category_count) )
  product.states << State.all.sample( rand(state_count) )
  puts "Product: #{product.title} created. Categories: #{product.categories.map(&:title).join(' ')}. States: #{product.states.map(&:title).join(' ')} \n"
end
