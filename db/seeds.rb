# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email


more_users = [{:name => 'Homer  Simpson', :email => 'homer@email.com', :password => '123456', :password_confirmation => '123456'},
              {:name => 'Bart  Simpson', :email => 'bart@email.com', :password => '123456', :password_confirmation => '123456'},
              {:name => 'Chief Wiggum', :email => 'chief@email.com', :password => '123456', :password_confirmation => '123456'},
              {:name => 'Marge  Simpson', :email => 'marge@email.com', :password => '123456', :password_confirmation => '123456'},
              {:name => 'Maggie Simpson', :email => 'maggie@email.com', :password => '123456', :password_confirmation => '123456'},
              {:name => 'Krusty  Clown', :email => 'krusty@email.com', :password => '123456', :password_confirmation => '123456'}]


more_users.each { |u| User.create!(u)}

puts 'CREATED USERS'

more_accounts = [{:status => 'active', :balance => 5000, :user_id => 2},
                 {:status => 'active', :balance => 4000, :user_id => 2},
                 {:status => 'active', :balance => 3000, :user_id => 2},
                 {:status => 'active', :balance => 5000, :user_id => 3},
                 {:status => 'active', :balance => 5000, :user_id => 3},
                 {:status => 'active', :balance => 5000, :user_id => 3},
                 {:status => 'active', :balance => 5000, :user_id => 4},
                 {:status => 'active', :balance => 5000, :user_id => 4},
                 {:status => 'active', :balance => 5000, :user_id => 4},
                 {:status => 'active', :balance => 5000, :user_id => 5},
                 {:status => 'active', :balance => 5000, :user_id => 5},
                 {:status => 'active', :balance => 5000, :user_id => 6},
                 {:status => 'active', :balance => 5000, :user_id => 6},
                 {:status => 'active', :balance => 5000, :user_id => 7},
                 {:status => 'active', :balance => 5000, :user_id => 7},
                 {:status => 'active', :balance => 5000, :user_id => 7}]



more_accounts.each { |a| Account.create!(a)}

puts 'CREATED ACCOUNTS'


more_friends = [{:status => 'accepted', :sender => 2, :recipient => 3},
                {:status => 'accepted', :sender => 3, :recipient => 4},
                {:status => 'accepted', :sender => 3, :recipient => 5},
                {:status => 'accepted', :sender => 4, :recipient => 2},
                {:status => 'accepted', :sender => 4, :recipient => 5},
                {:status => 'accepted', :sender => 5, :recipient => 3},
                {:status => 'accepted', :sender => 5, :recipient => 6},
                {:status => 'accepted', :sender => 6, :recipient => 4},
                {:status => 'accepted', :sender => 6, :recipient => 7},
                {:status => 'accepted', :sender => 7, :recipient => 5}]

more_friends.each { |f| Connection.create!(f)}

puts 'CREATED FRIENDS'
