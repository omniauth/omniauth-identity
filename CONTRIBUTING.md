# Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/omniauth/omniauth-identity][🚎src-main].
This project should be a safe, welcoming space for collaboration, so contributors agree to adhere to
the [code of conduct][🤝conduct].

To submit a patch, please fork the project, create a patch with tests, and send a pull request.

Remember to [![Keep A Changelog][📗keep-changelog-img]][📗keep-changelog].

## Help out!

Take a look at the `reek` list which is the file called `REEK` and find something to improve.

Follow these instructions:

1. Fork the repository
2. Create a feature branch (`git checkout -b my-new-feature`)
3. Make some fixes.
4. Commit changes (`git commit -am 'Added some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Make sure to add tests for it. This is important, so it doesn't break in a future release.
7. Create new Pull Request.

## Appraisals

From time to time the Appraisal2 gemfiles in `gemfiles/` will need to be updated.
They are created and updated with the commands:

```console
BUNDLE_GEMFILE=Appraisal.root.gemfile bundle
BUNDLE_GEMFILE=Appraisal.root.gemfile bundle exec appraisal update
bundle exec rake rubocop_gradual:autocorrect
```

NOTE: Commands need to be run from the devcontainer if old Rails or old sqlite3 won't install for you locally.

When adding an appraisal to CI, check the [runner tool cache][🏃‍♂️runner-tool-cache] to see which runner to use.

### We commit, and don't commit, our "gemfile.lock" files

Thanks to [Appraisal2](https://github.com/appraisal-rb/appraisal2) we have a `gemfiles/*.gemfile` suite
in addition to the main `Gemfile` at the root of the project.
We run a workflow against the main Gemfile, which has a `Gemfile.lock` committed, and
we also run workflows against each of the Appraisal2 `gemfiles/*.gemfile` suite,
which **do not** have `gemfiles/*.gemfile.lock` committed.

```
# Lock/Unlock Deps Pattern
#
# Two often conflicting goals resolved!
#
#  - deps_unlocked.yml
#    - All runtime & dev dependencies, but does not have a `gemfiles/*.gemfile.lock` committed
#    - Uses an Appraisal2 "deps_unlocked" gemfile, and the current MRI Ruby release
#    - Know when new dependency releases will break local dev with unlocked dependencies
#    - Broken workflow indicates that new releases of dependencies may not work
#
#  - deps_locked.yml
#    - All runtime & dev dependencies, and has a `Gemfile.lock` committed
#    - Uses the project's main Gemfile, and the current MRI Ruby release
#    - Matches what contributors and maintainers use locally for development
#    - Broken workflow indicates that a new contributor will have a bad time
#
```

## The Reek List

Take a look at the `reek` list which is the file called `REEK` and find something to improve.

To refresh the `reek` list:

```console
bundle exec reek > REEK
```

## Run Tests

NOTE: To run *all* tests have the following databases installed, configured, and running.

1. [RethinkDB](https://rethinkdb.com), an open source, real-time, web database, [installed](https://rethinkdb.com/docs/install/) and [running](https://rethinkdb.com/docs/start-a-server/), e.g.
   ```console
   brew install rethinkdb
   rethinkdb
   ```
2. [MongoDB](https://docs.mongodb.com/manual/administration/install-community/)
   ```console
   brew tap mongodb/brew
   brew install mongodb-community@4.4
   mongod --config /usr/local/etc/mongod.conf
   ```
3. [CouchDB](https://couchdb.apache.org) - download the .app, or:
   ```console
   brew install couchdb
   ```
   CouchDB 3.x requires a set admin password set before startup.
   Add one to your `$HOMEBREW_PREFIX/etc/local.ini` before starting CouchDB e.g.:
   ```ini
   [admins]
   admin = yourabsolutesecret
   ```
   Also add whatever password you set to your `.env.local`:
   ```dotenv
   export COUCHDB_PASSWORD=yourabsolutesecret
   ```
   Then start the CouchDB service
   ```console
   brew services start couchdb
   ```

Now you can run any of the tests!

To run all tests on all databases (except RethinkDB):
```console
bundle exec rake spec:orm:all
```

To run all tests that do not require any additional services, i.e. excluding MongoDB, CouchDB, & RethinkDB:
```console
bundle exec rake test
```

To run a specific DB:
```console
# CouchDB / CouchPotato
bundle exec rspec spec spec_orms --tag 'couchdb'

# ActiveRecord and Sequel, as they both use the in-memory SQLite driver.
bundle exec rspec spec spec_orms --tag 'sqlite3'

# NOTE - mongoid and nobrainer specs can't be isolated with "tag" because it still loads everything,
#        and the two libraries are fundamentally incompatible.

# MongoDB / Mongoid
bundle exec rspec spec_orms/mongoid_spec.rb

# RethinkDB / NoBrainer (Ignored by CI! see spec file for reasons)
bundle exec rspec spec_ignored/nobrainer_spec.rb
```

## Lint It

Run all the default tasks, which includes running the gradually autocorrecting linter, `rubocop-gradual`.

```console
bundle exec rake
```

Or just run the linter.

```console
bundle exec rake rubocop_gradual:autocorrect
```

## Contributors

[![Contributors][🖐contributors-img]][🖐contributors]

Made with [contributors-img][🖐contrib-rocks].

## For Maintainers

### One-time, Per-maintainer, Setup

**IMPORTANT**: To sign a build,
a public key for signing gems will need to be picked up by the line in the
`gemspec` defining the `spec.cert_chain` (check the relevant ENV variables there).
All releases to RubyGems.org are signed releases.
See: [RubyGems Security Guide][🔒️rubygems-security-guide]

NOTE: To build without signing the gem set `SKIP_GEM_SIGNING` to any value in the environment.

### To release a new version:

1. Run `bin/setup && bin/rake` as a "test, coverage, & linting" sanity check
2. Update the version number in `version.rb`, and ensure `CHANGELOG.md` reflects changes
3. Run `bin/setup && bin/rake` again as a secondary check, and to update `Gemfile.lock`
4. Run `git commit -am "🔖 Prepare release v<VERSION>"` to commit the changes
5. Run `git push` to trigger the final CI pipeline before release, and merge PRs
    - NOTE: Remember to [check the build][🧪build].
6. Run `export GIT_TRUNK_BRANCH_NAME="$(git remote show origin | grep 'HEAD branch' | cut -d ' ' -f5)" && echo $GIT_TRUNK_BRANCH_NAME`
7. Run `git checkout $GIT_TRUNK_BRANCH_NAME`
8. Run `git pull origin $GIT_TRUNK_BRANCH_NAME` to ensure latest trunk code
9. Set `SOURCE_DATE_EPOCH` so `rake build` and `rake release` use same timestamp, and generate same checksums
    - Run `export SOURCE_DATE_EPOCH=$EPOCHSECONDS && echo $SOURCE_DATE_EPOCH`
    - If the echo above has no output, then it didn't work.
    - Note: `zsh/datetime` module is needed, if running `zsh`.
    - In older versions of `bash` you can use `date +%s` instead, i.e. `export SOURCE_DATE_EPOCH=$(date +%s) && echo $SOURCE_DATE_EPOCH`
10. Run `bundle exec rake build`
11. Run `bin/gem_checksums` (more context [1][🔒️rubygems-checksums-pr], [2][🔒️rubygems-guides-pr])
    to create SHA-256 and SHA-512 checksums. This functionality is provided by the `stone_checksums`
    [gem][💎stone_checksums].
    - The script automatically commits but does not push the checksums
12. Run `bundle exec rake release` which will create a git tag for the version,
    push git commits and tags, and push the `.gem` file to [rubygems.org][💎rubygems]

[🚎src-main]: https://github.com/omniauth/omniauth-identity
[🧪build]: https://github.com/omniauth/omniauth-identity/actions
[🤝conduct]: https://github.com/omniauth/omniauth-identity/blob/main/CODE_OF_CONDUCT.md
[🖐contrib-rocks]: https://contrib.rocks
[🖐contributors]: https://github.com/omniauth/omniauth-identity/graphs/contributors
[🖐contributors-img]: https://contrib.rocks/image?repo=omniauth/omniauth-identity
[💎rubygems]: https://rubygems.org
[🔒️rubygems-security-guide]: https://guides.rubygems.org/security/#building-gems
[🔒️rubygems-checksums-pr]: https://github.com/rubygems/rubygems/pull/6022
[🔒️rubygems-guides-pr]: https://github.com/rubygems/guides/pull/325
[💎stone_checksums]: https://github.com/pboling/stone_checksums
[📗keep-changelog]: https://keepachangelog.com/en/1.0.0/
[📗keep-changelog-img]: https://img.shields.io/badge/keep--a--changelog-1.0.0-FFDD67.svg?style=flat
[🏃‍♂️runner-tool-cache]: https://github.com/ruby/ruby-builder/releases/tag/toolcache
