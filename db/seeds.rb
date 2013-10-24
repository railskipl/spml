# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


users = User.create!([{:username => 'admin',:password => 'admin123!', :password_confirmation => "admin123!",:first_name => "admin", 
	:last_name => "admin",:is_admin=>"true",:email => "admin@kipl.com",:mobile_no => "1234567890" }])
