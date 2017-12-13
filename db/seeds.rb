# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Criando banco de categorias..."
categories = ["Animais e acessórios", "Esportes", "Para sua Casa", "Eletrônicos e Celulares", "Músicas e Hobbies", 
				"Bebês e Crianças", "Moda e Beleza", "Veículos e Barcos", "Imóveis", "Empregos e negócios"]

categories.each do |category|
	Category.find_or_create_by(description: category)
end
puts "Criando banco de categorias...[OK!]"

###########################

puts "Criando administrador padrão..."
	
Admin.create!(name:"Admin Geral", email: "admin@admin.com", password: "123456", password_confirmation: "123456", role: 0)

puts "Criando administrador padrão...[OK!]"

puts "Criando membro padrão..."
	
member = Member.new(email: "member@member.com", password: "123456", password_confirmation: "123456")
member.build_profile_member
member.profile_member.first_name = Faker::Name.first_name
member.profile_member.second_name = Faker::Name.last_name
member.save!

puts "Criando membro padrão...[OK!]"
