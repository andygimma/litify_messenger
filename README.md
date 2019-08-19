# Litify Messenger

This is an example repository for working with rails and postgres, and setting them up using docker-compose.

To run this app, do the following. 

1. Install docker
2. Run `docker-compose up -d && docker attach $(docker-compose ps -q web)`
3. This would run the web service in a container and postgres in a container and allows us to use binding.pry.
4. Run `bundle exec rake db:seed` to seed the database.
5. Navigate to http://localhost:3000
6. Login with any of the users from seeds.rb. For example, you can use 'first@litify.com' as the email, and 'litify' as the password.

## Highlights

1. The use of MessageThread, MessageThreadUser, and MessageHelpers allows us to easily add new types of communications/data streams with minimal code. 
2. We used database/model scopes appropriately to make our code more readable.
3. Readability in general was a goal (though with a bit more time it could be made more readable).

## Notes

Looking forward to walking you through the codebase!

PS: Bootstrap sidebar designed was adapted from this repo: https://github.com/BlackrockDigital/startbootstrap-simple-sidebar/blob/master/index.html

