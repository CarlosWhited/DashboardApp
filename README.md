# Project Setup

Clone this repo locally, and from the top-level directory run:

`bundle install`

`bundle exec rake db:setup`

To make sure it's all working,

`rails s`

Dashboard is located at

`localhost:3000`

Endpoint for retrieving all questions or searching for questions is at 

`localhost:3000/questions`

Throttling is implemented based on number of requests for a tenant per day. After the limit is reached, a tenant is limited to 1 request every 10 seconds.

To run the test suite, simply run

`rspec`

from the top-level directory.