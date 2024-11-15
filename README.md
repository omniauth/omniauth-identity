# `OmniAuth::Identity`

[![Version][👽versioni]][👽version]
[![License: MIT][📄license-img]][📄license-ref]
[![Downloads Rank][👽dl-ranki]][👽dl-rank]
[![Open Source Helpers][👽oss-helpi]][👽oss-help]
[![Depfu][🔑depfui♻️]][🔑depfu]
[![CodeCov][🔑codecovi♻️]][🔑codecov]
[![Test Coverage][🔑cc-covi♻️]][🔑cc-cov]
[![Maintainability][🔑cc-mnti♻️]][🔑cc-mnt]
[![CI Supported Build][🚎6-s-wfi]][🚎6-s-wf]
[![CI Legacy Build][🚎4-lg-wfi]][🚎4-lg-wf]
[![CI Unsupported Build][🚎7-us-wfi]][🚎7-us-wf]
[![CI Heads Build][🚎3-hd-wfi]][🚎3-hd-wf]
[![CI Ancient Build][🚎1-an-wfi]][🚎1-an-wf]
[![CI Coverage Build][🚎2-cov-wfi]][🚎2-cov-wf]
[![CI Style Build][🚎5-st-wfi]][🚎5-st-wf]

[comment]: <> ( 👽️ INFO LINKS )

[👽dl-rank]: https://rubygems.org/gems/omniauth-identity
[👽dl-ranki]: https://img.shields.io/gem/rd/omniauth-identity.svg
[👽oss-help]: https://www.codetriage.com/omniauth/omniauth-identity
[👽oss-helpi]: https://www.codetriage.com/omniauth/omniauth-identity/badges/users.svg
[👽version]: https://rubygems.org/gems/omniauth-identity
[👽versioni]: https://img.shields.io/gem/v/omniauth-identity.svg

[comment]: <> ( 🔑 KEYED LINKS )

[🔑cc-mnt]: https://codeclimate.com/github/omniauth/omniauth-identity/maintainability
[🔑cc-mnti♻️]: https://api.codeclimate.com/v1/badges/621d6211cb2e0959ce00/maintainability
[🔑cc-cov]: https://codeclimate.com/github/omniauth/omniauth-identity/test_coverage
[🔑cc-covi♻️]: https://api.codeclimate.com/v1/badges/621d6211cb2e0959ce00/test_coverage
[🔑codecov]: https://codecov.io/gh/omniauth/omniauth-identity
[🔑codecovi♻️]: https://codecov.io/gh/omniauth/omniauth-identity/graph/badge.svg?token=selEoMrZzA
[🔑depfu]: https://depfu.com/github/omniauth/omniauth-identity
[🔑depfui♻️]: https://badges.depfu.com/badges/6c9b45362951b872127f9e46d39bed76/count.svg

[comment]: <> ( 🚎 BUILD LINKS )

[🚎1-an-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/ancient.yml
[🚎1-an-wfi]: https://github.com/omniauth/omniauth-identity/actions/workflows/ancient.yml/badge.svg
[🚎2-cov-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/coverage.yml
[🚎2-cov-wfi]: https://github.com/omniauth/omniauth-identity/actions/workflows/coverage.yml/badge.svg
[🚎3-hd-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/heads.yml
[🚎3-hd-wfi]: https://github.com/omniauth/omniauth-identity/actions/workflows/heads.yml/badge.svg
[🚎4-lg-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/legacy.yml
[🚎4-lg-wfi]: https://github.com/omniauth/omniauth-identity/actions/workflows/legacy.yml/badge.svg
[🚎5-st-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/style.yml
[🚎5-st-wfi]: https://github.com/omniauth/omniauth-identity/actions/workflows/style.yml/badge.svg
[🚎6-s-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/supported.yml
[🚎6-s-wfi]: https://github.com/omniauth/omniauth-identity/actions/workflows/supported.yml/badge.svg
[🚎7-us-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/unsupported.yml
[🚎7-us-wfi]: https://github.com/omniauth/omniauth-identity/actions/workflows/unsupported.yml/badge.svg

-----

[![Liberapay Patrons][⛳liberapay-img]][⛳liberapay]
[![Sponsor Me on Github][🖇sponsor-img]][🖇sponsor]
[![Polar Shield][🖇polar-img]][🖇polar]
[![Donate to my FLOSS or refugee efforts at ko-fi.com][🖇kofi-img]][🖇kofi]
[![Donate to my FLOSS or refugee efforts using Patreon][🖇patreon-img]][🖇patreon]

[⛳liberapay-img]: https://img.shields.io/liberapay/patrons/pboling.svg?logo=liberapay
[⛳liberapay]: https://liberapay.com/pboling/donate
[🖇sponsor-img]: https://img.shields.io/badge/Sponsor_Me!-pboling.svg?style=social&logo=github
[🖇sponsor]: https://github.com/sponsors/pboling
[🖇polar-img]: https://polar.sh/embed/seeks-funding-shield.svg?org=pboling
[🖇polar]: https://polar.sh/pboling
[🖇kofi-img]: https://img.shields.io/badge/buy%20me%20coffee-donate-yellow.svg
[🖇kofi]: https://ko-fi.com/O5O86SNP4
[🖇patreon-img]: https://img.shields.io/badge/patreon-donate-yellow.svg
[🖇patreon]: https://patreon.com/galtzo

The OmniAuth Identity gem provides a way for applications to utilize a
traditional username/password based authentication system without the need
to give up the simple authentication flow provided by OmniAuth. Identity
is designed on purpose to be as featureless as possible: it provides the
basic construct for user management and then gets out of the way.

| Primary Namespace | `OmniAuth::Identity`                                                                                                                                                                                                                                                                                                                                     |
|-------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| documentation     | [on Github.com][homepage], [on RubyDoc.info][documentation]                                                                                                                                                                                                                                                                                              |
| expert support    | [![Get help on Codementor](https://cdn.codementor.io/badges/get_help_github.svg)](https://www.codementor.io/peterboling?utm_source=github&utm_medium=button&utm_term=peterboling&utm_campaign=github)                                                                                                                                                    |
| `...` 💖          | [![Follow Me on LinkedIn][🖇linkedin-img]][🖇linkedin] [![Find Me on WellFound:][✌️wellfound-img]][✌️wellfound] [![Find Me on CrunchBase][💲crunchbase-img]][💲crunchbase] [![My LinkTree][🌳linktree-img]][🌳linktree] [![Follow Me on Ruby.Social][🐘ruby-mast-img]][🐘ruby-mast] [![Tweet @ Peter][🐦tweet-img]][🐦tweet] [💻][coderme] [🌏][aboutme] |

<!-- 7️⃣ spread 💖 -->
[🐦tweet-img]: https://img.shields.io/twitter/follow/galtzo.svg?style=social&label=Follow%20%40galtzo
[🐦tweet]: http://twitter.com/galtzo
[🚎blog]: http://www.railsbling.com/tags/omniauth-identity/
[🚎blog-img]: https://img.shields.io/badge/blog-railsbling-brightgreen.svg?style=flat
[🖇linkedin]: http://www.linkedin.com/in/peterboling
[🖇linkedin-img]: https://img.shields.io/badge/PeterBoling-blue?style=plastic&logo=linkedin
[✌️wellfound]: https://angel.co/u/peter-boling
[✌️wellfound-img]: https://img.shields.io/badge/peter--boling-orange?style=plastic&logo=wellfound
[💲crunchbase]: https://www.crunchbase.com/person/peter-boling
[💲crunchbase-img]: https://img.shields.io/badge/peter--boling-purple?style=plastic&logo=crunchbase
[🐘ruby-mast]: https://ruby.social/@galtzo
[🐘ruby-mast-img]: https://img.shields.io/mastodon/follow/109447111526622197?domain=https%3A%2F%2Fruby.social&style=plastic&logo=mastodon&label=Ruby%20%40galtzo
[🌳linktree]: https://linktr.ee/galtzo
[🌳linktree-img]: https://img.shields.io/badge/galtzo-purple?style=plastic&logo=linktree

<!-- Maintainer Contact Links -->
[aboutme]: https://about.me/peter.boling
[coderme]: https://coderwall.com/Peter%20Boling

## Installation

To acquire the latest release from RubyGems, and add this gem to your `Gemfile`, run:

```ruby
bundle add(omniauth - identity)
```

If the git repository has new commits not yet in an official release, simply specify the repo instead:

```ruby
gem "omniauth-identity", git: "https://github.com/omniauth/omniauth-identity.git"
```

## Compatibility

This gem is compatible with a wide range of Ruby versions and Ruby ORMs, as of Nov 2024, version 3.1.

* Latest released version of omniauth, v2+
* Tested in CI against Ruby 2.5, 2.6, 2.7, 3.0, 3.1, 3.2, 3.3, ruby-head, truffleruby-head
* Probably also compatible with Ruby 2.4 and jruby-head
* At least 5 different database ORM adapters, which connect to 15 different database clients!

| Databases                                                                                                 | Adapter Libraries                                                        |
|-----------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------|
| MySQL, PostgreSQL, SQLite3                                                                                | [ActiveRecord](https://guides.rubyonrails.org/active_record_basics.html) |
| CouchDB                                                                                                   | [CouchPotato](https://github.com/langalex/couch_potato)                  |
| MongoDB                                                                                                   | [Mongoid](https://github.com/mongodb/mongoid)                            |
| RethinkDB                                                                                                 | [NoBrainer](http://nobrainer.io/)                                        |
| ADO, Amalgalite, IBM_DB, JDBC, MySQL, Mysql2, ODBC, Oracle, PostgreSQL, SQLAnywhere, SQLite3, and TinyTDS | [Sequel](http://sequel.jeremyevans.net)                                  |

## Usage

This can be a bit hard to understand the first time. Luckily, Ryan Bates made
a [Railscast](http://railscasts.com/episodes/304-omniauth-identity) about it!

You use `omniauth-identity` just like you would any other OmniAuth provider: as a
Rack middleware. In rails, this would be created by an initializer, such as
`config/initializers/omniauth.rb`. The basic setup for a email/password authentication would look something like this:

```ruby
use OmniAuth::Builder do
  provider :identity,                        #mandatory: tells OA that the Identity strategy is being used
    model: Identity,                  # optional: specifies the name of the "Identity" model. Defaults to "Identity"
    fields: %i[email custom1 custom2] # optional: list of custom fields that are in the model's table
end
```

Next, you need to create a model (called `Identity` by default, or specified
with `:model` argument above) that will be able to persist the information
provided by the user. Luckily for you, there are pre-built models for popular
ORMs that make this dead simple.

Once you've got an `Identity` persistence model and the strategy up and
running, you can point users to `/auth/identity` and it will request
that they log in or give them the opportunity to sign up for an account.
Once they have authenticated with their identity, OmniAuth will call
through to `/auth/identity/callback` with the same kinds of information
it would had the user authenticated through an external provider.

**Note:** OmniAuth Identity is different from many other user authentication
systems in that it is *not* built to store authentication information in your primary
`User` model. Instead, the `Identity` model should be **associated** with your
`User` model giving you maximum flexibility to include other authentication
strategies such as Facebook, Twitter, etc.

### ActiveRecord

Just subclass `OmniAuth::Identity::Models::ActiveRecord` and provide fields
in the database for all of the fields you are using.

```ruby
class Identity < OmniAuth::Identity::Models::ActiveRecord
  auth_key :email    # optional: specifies the field within the model that will be used during the login process
                     # defaults to email, but may be username, uid, login, etc.

  # Anything else you want!
end
```

### Sequel

[Sequel](http://sequel.jeremyevans.net/) is an alternative to ActiveRecord.

Just include `OmniAuth::Identity::Models::Sequel` mixin, and specify
whatever else you will need.

```ruby
class SequelTestIdentity < Sequel::Model(:identities)
  include ::OmniAuth::Identity::Models::Sequel
  auth_key :email
  # whatever else you want!
end
```

### Mongoid

Include the `OmniAuth::Identity::Models::Mongoid` mixin and specify
fields that you will need.

```ruby
class Identity
  include ::Mongoid::Document
  include ::OmniAuth::Identity::Models::Mongoid

  field :email, type: String
  field :name, type: String
  field :password_digest, type: String
end
```

### CouchPotato

Include the `OmniAuth::Identity::Models::CouchPotatoModule` mixin and specify
fields that you will need.

```ruby
class Identity
  # NOTE: CouchPotato::Persistence must be included before OmniAuth::Identity::Models::CouchPotatoModule
  include ::CouchPotato::Persistence
  include ::OmniAuth::Identity::Models::CouchPotatoModule

  property :email
  property :password_digest

  def self.where(search_hash)
    CouchPotato.database.view(Identity.by_email(key: search_hash))
  end

  view :by_email, key: :email
end
```

### NoBrainer

[NoBrainer](http://nobrainer.io/) is an ORM for [RethinkDB](https://rethinkdb.com/).

Include the `OmniAuth::Identity::Models::NoBrainer` mixin and specify
fields that you will need.

```ruby
class Identity
  include ::NoBrainer::Document
  include ::OmniAuth::Identity::Models::NoBrainer

  auth_key :email
end
```

### Ruby Object Mapper

Would love to add a mixin for the [Ruby Object Mapper (ROM)](https://rom-rb.org/) if anyone wants to work on it!

## Custom Auth Model

To use a class other than the default, specify the <tt>:model</tt> option to a
different class.

```ruby
use OmniAuth::Builder do
  provider :identity, fields: [:email], model: MyCustomClass
end
```

NOTE: In the above example, `MyCustomClass` must have a class method called `auth_key` that returns
the default (`email`) or custom `auth_key` to use.

## Customizing Registration Failure

To use your own custom registration form, create a form that POSTs to
`/auth/identity/register` with `password`, `password_confirmation`, and your
other fields.

```erb
<%= form_tag '/auth/identity/register' do |f| %>
  <h1>Create an Account</h1>
  <%= text_field_tag :email %>
  <%= password_field_tag :password %>
  <%= password_field_tag :password_confirmation %>
  <%= submit_tag %>
<% end %>
```

Beware not to nest your form parameters within a namespace. This strategy
looks for the form parameters at the top level of the post params. If you are
using [simple\_form](https://github.com/plataformatec/simple_form), then you
can avoid the params nesting by specifying `:input_html`.

```erb
<%= simple_form_for @identity, :url => '/auth/identity/register' do |f| %>
  <h1>Create an Account</h1>
  <%# specify :input_html to avoid params nesting %>
  <%= f.input :email, :input_html => {:name => 'email'} %>
  <%= f.input :password, :as => 'password', :input_html => {:name => 'password'} %>
  <%= f.input :password_confirmation, :label => "Confirm Password", :as => 'password', :input_html => {:name => 'password_confirmation'} %>
  <button type='submit'>Sign Up</button>
<% end %>
```

Next you'll need to let OmniAuth know what action to call when a registration
fails. In your OmniAuth configuration, specify any valid rack endpoint in the
`:on_failed_registration` option.

```ruby
use OmniAuth::Builder do
  provider :identity,
    fields: [:email],
    on_failed_registration: UsersController.action(:new)
end
```

For more information on rack endpoints, check out [this
introduction](http://library.edgecase.com/Rails/2011/01/04/rails-routing-and-rack-endpoints.html)
and
[ActionController::Metal](http://rubydoc.info/docs/rails/ActionController/Metal)

## Customizing Locate Conditions

You can customize the way that matching records are found when authenticating.
For example, for a site with multiple domains, you may wish to scope the search
within a particular subdomain.  To do so, add :locate_conditions to your config.
The default value is:

```ruby
use OmniAuth::Builder do
  provider :identity,
    locate_conditions: ->(req) { {model.auth_key => req.params["auth_key"]} }
    # ...
end
```

`locate_conditions` takes a `Proc` object, and must return a `Hash` object, which will be used
as the argument to the locate method for your ORM.  The proc is evaluated in the
callback context, and has access to your `Identity` model (using `model`) and receives the request
object as a parameter.  Note  that `model.auth_key` defaults to `email`, but is also configurable.

Note: Be careful when customizing `locate_conditions`.  The best way to modify the conditions is
to copy the default value, and then add to the hash.  Removing the default condition will almost
always break things!

## Customizing Other Things

From the code - here are the options we have for you, a couple of which are documented above, and the rest are documented... in the specs we hope!?
```
option :fields, %i[name email]

      # Primary Feature Switches:
option :enable_registration, true   # See #other_phase and #request_phase
option :enable_login, true          # See #other_phase

      # Customization Options:
option :on_login, nil               # See #request_phase
option :on_validation, nil          # See #registration_phase
option :on_registration, nil        # See #registration_phase
option :on_failed_registration, nil # See #registration_phase
option :locate_conditions, ->(req) { {model.auth_key => req.params["auth_key"]} }
```

Please contribute some documentation if you have the gumption!  The maintainer's time is limited, and sometimes the authors of PRs with new options don't update the _this_ readme. 😭

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am ‘Added some feature’`)
4. Push to the branch (`git push origin my-new-feature`)
5. Make sure to add tests for it. This is important so I don’t break it in a future version unintentionally.

NOTE: In order to run *all* the tests you will need to have the following databases installed, configured, and running.

1. [RethinkDB](https://rethinkdb.com), an open source, real-time, web database, [installed](https://rethinkdb.com/docs/install/) and [running](https://rethinkdb.com/docs/start-a-server/), e.g.
   ```bash
   brew install rethinkdb
   rethinkdb
   ```
2. [MongoDB](https://docs.mongodb.com/manual/administration/install-community/)
   ```bash
   brew tap mongodb/brew
   brew install mongodb-community@4.4
   mongod --config /usr/local/etc/mongod.conf
   ```
3. [CouchDB](https://couchdb.apache.org) - download the .app, or:
   ```bash
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
   ```bash
   brew services start couchdb
   ```

Now you can run any of the tests!

To run all tests on all databases (except RethinkDB):
```bash
bundle exec rake spec:orm:all
```

To run all tests that do not require any additional services, like MongoDB, CouchDB, or RethinkDB:
```bash
bundle exec rake test
```

To run a specific DB:
```bash
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

### Finally

Run all the default tasks, which includes running the gradually autocorrecting linter, `rubocop-gradual`.
```bash
bundle exec rake
```

📌 Create new Pull Request with your changes 📌

## 🤝 Contributing

If you need some ideas of where to help, you could work on adding more code coverage,
or if it is already 💯 (see [below](#code-coverage)) then check [issues][🤝issues], or [PRs][🤝pulls],
or use the gem and think about how it could be better.

Also, see [CONTRIBUTING.md][🤝contributing].

[🤝issues]: https://github.com/omniauth/omniauth-identity/issues
[🤝pulls]: https://github.com/omniauth/omniauth-identity/pulls
[🤝contributing]: CONTRIBUTING.md

### Code Coverage

[![Coverage Graph][🔑codecov-g]][🖇codecov]

[🔑codecov-g]: https://codecov.io/gh/omniauth/omniauth-identity/graphs/tree.svg?token=selEoMrZzA

## 🌈 Contributors

[![Contributors][🖐contributors-img]][🖐contributors]

Made with [contributors-img][🖐contrib-rocks].

[🖐contrib-rocks]: https://contrib.rocks
[🖐contributors]: https://github.com/omniauth/omniauth-identity/graphs/contributors
[🖐contributors-img]: https://contrib.rocks/image?repo=omniauth/omniauth-identity

## Star History

<a href="https://star-history.com/#omniauth/omniauth-identity&Date">
 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=omniauth/omniauth-identity&type=Date&theme=dark" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=omniauth/omniauth-identity&type=Date" />
   <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=omniauth/omniauth-identity&type=Date" />
 </picture>
</a>

## 🪇 Code of Conduct

Everyone interacting in this project's codebases, issue trackers,
chat rooms and mailing lists is expected to follow the [code of conduct][🪇conduct].

[🪇conduct]: CODE_OF_CONDUCT.md

## 📌 Versioning

This Library adheres to [Semantic Versioning 2.0.0][📌semver].
Violations of this scheme should be reported as bugs.
Specifically, if a minor or patch version is released that breaks backward compatibility,
a new version should be immediately released that restores compatibility.
Breaking changes to the public API will only be introduced with new major versions.

To get a better understanding of how SemVer is intended to work over a project's lifetime,
read this article from the creator of SemVer:

- ["Major Version Numbers are Not Sacred"][📌major-versions-not-sacred]

As a result of this policy, you can (and should) specify a dependency on these libraries using
the [Pessimistic Version Constraint][📌pvc] with two digits of precision.

For example:

```ruby
spec.add_dependency("omniauth-identity", "~> 3.1")
```

See [CHANGELOG.md][📌changelog] for list of releases.

[comment]: <> ( 📌 VERSIONING LINKS )

[📌pvc]: http://guides.rubygems.org/patterns/#pessimistic-version-constraint
[📌semver]: http://semver.org/
[📌major-versions-not-sacred]: https://tom.preston-werner.com/2022/05/23/major-version-numbers-are-not-sacred.html
[📌changelog]: CHANGELOG.md

## 📄 License

The gem is available as open source under the terms of
the [MIT License][📄license] [![License: MIT][📄license-img]][📄license-ref].
See [LICENSE.txt][📄license] for the official [Copyright Notice][📄copyright-notice-explainer].

[comment]: <> ( 📄 LEGAL LINKS )

[📄copyright-notice-explainer]: https://opensource.stackexchange.com/questions/5778/why-do-licenses-such-as-the-mit-license-specify-a-single-year
[📄license]: LICENSE.txt
[📄license-ref]: https://opensource.org/licenses/MIT
[📄license-img]: https://img.shields.io/badge/License-MIT-green.svg

### © Copyright

* Copyright (c) 2021, 2024 [Peter H. Boling][peterboling], and OmniAuth-Identity Maintainers
* Copyright (c) 2020 [Peter H. Boling][peterboling], Andrew Roberts, and Jellybooks Ltd.
* Copyright (c) 2010-2015 Michael Bleigh, and Intridea, Inc.

[railsbling]: http://www.railsbling.com
[peterboling]: http://www.peterboling.com
[bundle-group-pattern]: https://gist.github.com/pboling/4564780
[documentation]: http://rubydoc.info/gems/omniauth-identity
[homepage]: https://github.com/omniauth/omniauth-identity

## 🤑 One more thing

You made it to the bottom of the page,
so perhaps you'll indulge me for another 20 seconds.
I maintain many dozens of gems, including this one,
because I want Ruby to be a great place for people to solve problems, big and small.
Please consider supporting my efforts via the giant yellow link below,
or one of the others at the head of this README.

[![Buy me a latte][🖇buyme-img]][🖇buyme]

[🖇buyme-img]: https://img.buymeacoffee.com/button-api/?text=Buy%20me%20a%20latte&emoji=&slug=pboling&button_colour=FFDD00&font_colour=000000&font_family=Cookie&outline_colour=000000&coffee_colour=ffffff
[🖇buyme]: https://www.buymeacoffee.com/pboling
