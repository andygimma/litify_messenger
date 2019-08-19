# Litify Messenger

Litify's latest project!

Messenger is a communications and data stream that can easily be extended to suit any communications needs. Make sure to check out the Highlights section below for a little more information.

## Installation

1. Install docker and docker-compose
2. Run `docker-compose up -d && docker attach $(docker-compose ps -q web)`
3. This would run the web service in a container and postgres in a container and allows us to use binding.pry.
4. Run `bundle exec rake db:seed` to seed the database.
5. Navigate to http://localhost:3000
6. Login with any of the users from seeds.rb. For example, you can use 'first@litify.com' as the email, and 'litify' as the password.

## Highlights

1. The use of MessageThread, MessageThreadUser, and MessageHelpers allows us to easily add new types of communications/data streams with minimal code. The entire project was built around this idea, to hopefully stand out during the application process.
2. We used database/model scopes appropriately to make our code more readable.
3. Readability in general was a goal (though with a bit more time it could be made more readable).

## Next steps

1. Had I a bit more time, I would have used a message broker and websockets to make this all update live.
2. I also would have added paperclip to emails
3. More focus on security and testing.

## Final Notes

Looking forward to walking you through the codebase!

PS: Bootstrap sidebar designed was adapted from this repo: https://github.com/BlackrockDigital/startbootstrap-simple-sidebar/blob/master/index.html

