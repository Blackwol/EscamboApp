namespace :dev do

	desc "Setup Development"
	task setup_dev: :environment do
		images_path = Rails.root.join('public', 'system')

		puts "Executando o setup para desenvolvimento..."
		%x(rake db:drop)
		%x(rm -rf #{images_path})
		%x(rake db:create)
		%x(rake db:migrate)
		%x(rake db:seed)
		%x(rake dev:generate_admins)
		%x(rake dev:generate_members)
		%x(rake dev:generate_ads)
		%x(rake dev:generate_comments)
		puts "Executando o setup para desenvolvimento... [OK!]"
	end

	###################################################

	desc "Criando admins fakes..."
	task generate_admins: :environment do
		puts "Cadastrando Admins..."	
		10.times do
			Admin.create!(name: Faker::Name.name, 
						  email: Faker::Internet.email, 
						  password: "123456", 
						  password_confirmation: "123456", 
						  role: [0,0,1,1,1].sample)
		end

		puts "Cadastrando Admins...[OK!]"

	end

	desc "Criando members fakes..."
	task generate_members: :environment do
		puts "Cadastrando Members..."

		10.times do
			member = Member.new(email: Faker::Internet.email, 
						  password: "123456", 
						  password_confirmation: "123456")
			member.build_profile_member
			member.profile_member.first_name = Faker::Name.first_name
			member.profile_member.second_name = Faker::Name.last_name
			member.save!
		end

		puts "Cadastrando Members...[OK!]"
	end


	desc "Criando Anúncios fakes..."
	task generate_ads: :environment do
		puts "Cadastrando Anúncios..."

		5.times do
			Ad.create!(title: Faker::Lorem.sentence([2,3,4,5].sample), 
					   description: LeroleroGenerator.paragraph([1,2,3].sample), 
					   member: Member.first, 
					   category: Category.all.sample, 
					   price: "#{Random.rand(500)}, #{Random.rand(99)}", 
					   finish_date: Date.today + Random.rand(90), 
					   picture: File.new(Rails.root.join('public', 'templates', 'images-for-ads', "#{Random.rand(4)}.jpg"), 'r'))
		end

		100.times do
			Ad.create!(title: Faker::Lorem.sentence([2,3,4,5].sample), 
					   description: LeroleroGenerator.paragraph([1,2,3].sample), 
					   member: Member.all.sample, 
					   category: Category.all.sample, 
					   price: "#{Random.rand(500)}, #{Random.rand(99)}", 
					   finish_date: Date.today + Random.rand(90),
					   picture: File.new(Rails.root.join('public', 'templates', 'images-for-ads', "#{Random.rand(3)}.jpg"), 'r'))					   
		end
		puts "Cadastrando Anúncios...[OK!]"
	end

	desc "Criando comentários fakes..."
	task generate_comments: :environment do
		puts "Criando Comentários..."
		Ad.all.each do |ad|
			(Random.rand(3)).times do
				Comment.create!(
					body: Faker::Lorem.paragraph([1,2,3].sample), 
					member: Member.all.sample, 
					ad: ad)
			end
		end

		puts "Criando Comentários...[OK!]"
	end
end
