# README

## Team CRM

This repo is for the Team CRM - MX VS ATV LEGENDS Racing Team.

Ruby: 3.2.2

Rails: 7

Postgresql DB

### Start PostGresql

- ``` sudo service postgresql restart ```

### Start Rails dev server

- ``` ./bin/dev ```

### Running on MacOs
1. Clone repo

2. Set rbenv ruby version to 3.2.2 - `rbenv local 3.2.2`

3. Install bundler - `gem install bundler`

4. Install Postgresql - `brew install postgresql`

4. Install gems - `bundle install`

5. Start Postgresql - `brew services start postgresql`

6. Create `crm` role in Postgresql - `psql postgres -c "CREATE ROLE crm WITH LOGIN PASSWORD 'yourpassword`;

8. Add `gssapi` gem to Gemfile - `gem install gssapi`

9. Install `gssapi` gem - `bundle install`

10. Create database - `rails db:create`

11. Run migrations - `rails db:migrate`

12. Start server - `./bin/dev`
 - If you get an error about `esbuild` not being installed, run `yarn install`
 - If you get an error about `@hotwired/turbo-rails` not being installed, run `yarn add @hotwired/turbo-rails`
 - If you get an error about `@hotwired/stimulus` not being installed, run `yarn add @hotwired/stimulus`
 - If you get a `[__NSCFConstantString initialize] may have been in progress in another thread when fork() was called` error, run `export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES` and try again.

13. Close server - `ctrl + c` and restart server - `./bin/dev`
14. Open browser to `127.0.0.1:3000`