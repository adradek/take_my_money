# Take My Money: Accepting Payments on the Web
### by Noel Rappin
#### (My Personal Walkthrough)

This repository is the result of my walkthrough of Noel Rappin's tutorial. Unfortunately, the code that was supposed to accompany the book is no longer available at the address listed on the Pragmatic Bookshelf portal. So I used [Alexander Khlipun's repository](https://github.com/alexander-kh/take-my-money) as the primary source.

I wrapped the application in Docker, slightly updated the software versions, and added a few code quality tools. Overall, I hope this work proves useful to someone.

> The code from "Take My Money" book, published by the Pragmatic Bookshelf.
> Copyrights apply to this code. It may not be used to create training material, courses, books, articles, and the like. Contact the publisher if you are in doubt.

Walkthrough progress: completed chapter 1/13

**Versions used:**

  * Docker Composer: 2+
  * Ruby: 2.7.8 (Original book code uses Ruby 2.5.0)
  * Rails: 5.1.4
  * PostgreSQL: 12.2 (10.1)
  * RSpec: 3.7

**Setup:**

  * Building:
  ```
  docker compose build
  ```

  * Initializing:
  ```
  docker compose run --rm web bash

  # inside the container:
  bundle install
  bin/rails db:create
  bin/rails db:migrate
  bin/rails db:seed

  exit
  ```

**Testing:**

  ```
  docker compose run --rm web bin/rspec
  ````
