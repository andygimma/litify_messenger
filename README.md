# README

This is an example repository for working with rails and postgres, and setting them up using docker-compose.

To run this app, do the following. 

1. Install docker
1. Run `docker-compose up -d && docker attach $(docker-compose ps -q web)`
2. This would run the web service in a container and postgres in a container and allows us to use binding.pry.
3. Run `bundle exec rake db:seed` to seed the database.
4. Navigate to http://localhost:3000
5. Login with any of the users from seeds.rb. For example, you can use 'first@litify.com' as the email, and 'litify' as the password.

