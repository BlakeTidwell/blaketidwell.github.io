# Blake Tidwell's Personal Blog

*or, Alternately, Sounds Made by Electrons Moving Varying Distances*

## Deployment

Since you have already forgotten this like a hundred times...

*Dear Future Blake,*

* `main` is what it sounds like: the main branch. Do your work here.
* `middleman-gh-pages` provides a `publish` rake task that does the dirty work. Use it
  like so:

  ```
  $ BRANCH_NAME=master bundle exec rake publish
  ```

* Since the site is set up as a user page, it is deployed to `master`, not
  `gh-pages`.

*Go forth,*

*Past Blake*
