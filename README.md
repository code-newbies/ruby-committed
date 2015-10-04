# ruby-commited
Ruby-Monday's 2nd project. Aggregate your different coding activity and build support and a following.

## Project Setup

Assuming you have PG running and the default blank root password
and assuming your currnet working directory is the root of this project:

$ bundle install
$ cp ./config/database.yml.sample ./config/database.yml
$ cp ./config/secrets.yml.sample ./config/secrets.yml

To change the default secret keys, run the command below, copy the generated
key and modify the secrets.yml file. You'll need to do this twice. Once for
the test key and once for the developement key.

$ rake secret

_If you *do not* want to use the project default database names, then you'll want to edit
config/database.yml before runnig the last command._

$ rake db:setup
