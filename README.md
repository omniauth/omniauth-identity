<a href="https://github.com/omniauth"><img alt="omniauth Logo by Aboling0, CC BY-SA 4.0" src="https://logos.galtzo.com/assets/images/omniauth/avatar-128px.svg" width="14%" align="right"/></a>

# 🫵 OmniAuth::Identity

[![Version][👽versioni]][👽version] [![GitHub tag (latest SemVer)][⛳️tag-img]][⛳️tag] [![License: MIT][📄license-img]][📄license] [![Downloads Rank][👽dl-ranki]][👽dl-rank] [![CodeCov Test Coverage][🏀codecovi]][🏀codecov] [![Coveralls Test Coverage][🏀coveralls-img]][🏀coveralls] [![QLTY Test Coverage][🏀qlty-covi]][🏀qlty-cov] [![QLTY Maintainability][🏀qlty-mnti]][🏀qlty-mnt] [![CI Heads][🚎3-hd-wfi]][🚎3-hd-wf] [![CI Runtime Dependencies @ HEAD][🚎12-crh-wfi]][🚎12-crh-wf] [![CI Current][🚎11-c-wfi]][🚎11-c-wf] [![CI Truffle Ruby][🚎9-t-wfi]][🚎9-t-wf] [![CI JRuby][🚎10-j-wfi]][🚎10-j-wf] [![Deps Locked][🚎13-🔒️-wfi]][🚎13-🔒️-wf] [![Deps Unlocked][🚎14-🔓️-wfi]][🚎14-🔓️-wf] [![CI Test Coverage][🚎2-cov-wfi]][🚎2-cov-wf] [![CI Style][🚎5-st-wfi]][🚎5-st-wf] [![Apache SkyWalking Eyes License Compatibility Check][🚎15-🪪-wfi]][🚎15-🪪-wf]

`if ci_badges.map(&:color).detect { it != "green"}` ☝️ [let me know][✉️discord-invite], as I may have missed the [discord notification][✉️discord-invite].

---

`if ci_badges.map(&:color).all? { it == "green"}` 👇️ send money so I can do more of this. FLOSS maintenance is now my full-time job.

[![OpenCollective Backers][🖇osc-backers-i]][🖇osc-backers] [![OpenCollective Sponsors][🖇osc-sponsors-i]][🖇osc-sponsors] [![Sponsor Me on Github][🖇sponsor-img]][🖇sponsor] [![Liberapay Goal Progress][⛳liberapay-img]][⛳liberapay] [![Donate on PayPal][🖇paypal-img]][🖇paypal] [![Buy me a coffee][🖇buyme-small-img]][🖇buyme] [![Donate on Polar][🖇polar-img]][🖇polar] [![Donate at ko-fi.com][🖇kofi-img]][🖇kofi]

<details markdown="1">
 <summary>👣 How will this project approach the September 2025 hostile takeover of RubyGems? 🚑️</summary>

I've summarized my thoughts in [this blog post](https://dev.to/galtzo/hostile-takeover-of-rubygems-my-thoughts-5hlo).

</details>

## 🌻 Synopsis <a href="https://discord.gg/3qme4XHNKN"><img alt="Galtzo FLOSS Logo by Aboling0, CC BY-SA 4.0" src="https://logos.galtzo.com/assets/images/galtzo-floss/avatar-128px.svg" width="8%" align="right"/></a> <a href="https://ruby-toolbox.com"><img alt="ruby-lang Logo, Yukihiro Matsumoto, Ruby Visual Identity Team, CC BY-SA 2.5" src="https://logos.galtzo.com/assets/images/ruby-lang/avatar-128px.svg" width="8%" align="right"/></a>

The `omniauth-identity` gem provides a way for applications to utilize a
traditional username/password based authentication system without the need
to give up the simple authentication flow provided by OmniAuth. Identity
is designed on purpose to be as featureless as possible: it provides the
basic construct for user management and then gets out of the way.

## 💡 Info you can shake a stick at

| Tokens to Remember | [![Gem name][⛳️name-img]][⛳️gem-name] [![Gem namespace][⛳️namespace-img]][⛳️gem-namespace] |
|-------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Works with JRuby | [![JRuby 9.2 Compat][💎jruby-9.2i]][🚎jruby-9.2-wf] [![JRuby 9.3 Compat][💎jruby-9.3i]][🚎jruby-9.3-wf] <br/> [![JRuby 9.4 Compat][💎jruby-9.4i]][🚎jruby-9.4-wf] [![JRuby 10.0 Compat][💎jruby-10.0i]][🚎jruby-10.0-wf] [![JRuby current Compat][💎jruby-c-i]][🚎10-j-wf] [![JRuby HEAD Compat][💎jruby-headi]][🚎3-hd-wf]|
| Works with Truffle Ruby | [![Truffle Ruby 22.3 Compat][💎truby-22.3i]][🚎truby-22.3-wf] [![Truffle Ruby 23.0 Compat][💎truby-23.0i]][🚎truby-23.0-wf] [![Truffle Ruby 23.1 Compat][💎truby-23.1i]][🚎truby-23.1-wf] <br/> [![Truffle Ruby 24.2 Compat][💎truby-24.2i]][🚎truby-24.2-wf] [![Truffle Ruby 25.0 Compat][💎truby-25.0i]][🚎truby-25.0-wf] [![Truffle Ruby 33.0 Compat][💎truby-33.0i]][🚎truby-33.0-wf] [![Truffle Ruby current Compat][💎truby-c-i]][🚎9-t-wf] [![Truffle Ruby HEAD Compat][💎truby-headi]][🚎3-hd-wf]|
| Works with MRI Ruby 4 | [![Ruby current Compat][💎ruby-c-i]][🚎11-c-wf] [![Ruby HEAD Compat][💎ruby-headi]][🚎3-hd-wf]|
| Works with MRI Ruby 3 | [![Ruby 3.0 Compat][💎ruby-3.0i]][🚎ruby-3.0-wf] [![Ruby 3.1 Compat][💎ruby-3.1i]][🚎ruby-3.1-wf] [![Ruby 3.2 Compat][💎ruby-3.2i]][🚎ruby-3.2-wf] [![Ruby 3.3 Compat][💎ruby-3.3i]][🚎ruby-3.3-wf] [![Ruby 3.4 Compat][💎ruby-3.4i]][🚎ruby-3.4-wf]|
| Works with MRI Ruby 2 | [![Ruby 2.4 Compat][💎ruby-2.4i]][🚎ruby-2.4-wf] [![Ruby 2.5 Compat][💎ruby-2.5i]][🚎ruby-2.5-wf] [![Ruby 2.6 Compat][💎ruby-2.6i]][🚎ruby-2.6-wf] [![Ruby 2.7 Compat][💎ruby-2.7i]][🚎ruby-2.7-wf]|
| Support & Community | [![Join Me on Daily.dev's RubyFriends][✉️ruby-friends-img]][✉️ruby-friends] [![Live Chat on Discord][✉️discord-invite-img-ftb]][✉️discord-invite] [![Get help from me on Upwork][👨🏼‍🏫expsup-upwork-img]][👨🏼‍🏫expsup-upwork] [![Get help from me on Codementor][👨🏼‍🏫expsup-codementor-img]][👨🏼‍🏫expsup-codementor] |
| Source | [![Source on GitLab.com][📜src-gl-img]][📜src-gl] [![Source on CodeBerg.org][📜src-cb-img]][📜src-cb] [![Source on Github.com][📜src-gh-img]][📜src-gh] [![The best SHA: dQw4w9WgXcQ!][🧮kloc-img]][🧮kloc] |
| Documentation | [![Current release on RubyDoc.info][📜docs-cr-rd-img]][🚎yard-current] [![YARD on Galtzo.com][📜docs-head-rd-img]][🚎yard-head] [![Maintainer Blog][🚂maint-blog-img]][🚂maint-blog] [![GitLab Wiki][📜gl-wiki-img]][📜gl-wiki] [![GitHub Wiki][📜gh-wiki-img]][📜gh-wiki] |
| Compliance | [![License: MIT][📄license-img]][📄license] [![Apache license compatibility: Category A][📄license-compat-img]][📄license-compat] [![📄ilo-declaration-img]][📄ilo-declaration] [![Security Policy][🔐security-img]][🔐security] [![Contributor Covenant 2.1][🪇conduct-img]][🪇conduct] [![SemVer 2.0.0][📌semver-img]][📌semver] |
| Style | [![Enforced Code Style Linter][💎rlts-img]][💎rlts] [![Keep-A-Changelog 1.0.0][📗keep-changelog-img]][📗keep-changelog] [![Gitmoji Commits][📌gitmoji-img]][📌gitmoji] [![Compatibility appraised by: appraisal2][💎appraisal2-img]][💎appraisal2] |
| Maintainer 🎖️ | [![Follow Me on LinkedIn][💖🖇linkedin-img]][💖🖇linkedin] [![Follow Me on Ruby.Social][💖🐘ruby-mast-img]][💖🐘ruby-mast] [![Follow Me on Bluesky][💖🦋bluesky-img]][💖🦋bluesky] [![Contact Maintainer][🚂maint-contact-img]][🚂maint-contact] [![My technical writing][💖💁🏼‍♂️devto-img]][💖💁🏼‍♂️devto] |
| `...` 💖 | [![Find Me on WellFound:][💖✌️wellfound-img]][💖✌️wellfound] [![Find Me on CrunchBase][💖💲crunchbase-img]][💖💲crunchbase] [![My LinkTree][💖🌳linktree-img]][💖🌳linktree] [![More About Me][💖💁🏼‍♂️aboutme-img]][💖💁🏼‍♂️aboutme] [🧊][💖🧊berg] [🐙][💖🐙hub] [🛖][💖🛖hut] [🧪][💖🧪lab] |

### Compatibility

Compatible with MRI Ruby 2.4+, and concordant releases of JRuby, and TruffleRuby.
CI workflows and Appraisals are generated for MRI Ruby 2.4+.
This test floor is configured by `ruby.test_minimum` in `.kettle-jem.yml` and
may be higher than the gem's runtime compatibility floor when legacy Rubies are
not practical for the current toolchain.

<a href="https://github.com/kettle-dev"><img alt="kettle-dev Logo by Aboling0, CC BY-SA 4.0" src="https://logos.galtzo.com/assets/images/kettle-dev/avatar-128px.svg" width="14%" align="right"/></a>

The _amazing_ test matrix is powered by the kettle-dev stack.

<details markdown="1">
<summary>How kettle-dev manages complexity in tests</summary>

| Gem | Source | Role | Daily download rank |
|-----|--------|------|---------------------|
| [appraisal2](https://bestgems.org/gems/appraisal2) | [GitHub](https://github.com/appraisal-rb/appraisal2) | multi-dependency Appraisal matrix generation | [![Daily download rank for appraisal2](https://img.shields.io/gem/rd/appraisal2.svg?style=flat-square)](https://bestgems.org/gems/appraisal2) |
| [appraisal2-rubocop](https://bestgems.org/gems/appraisal2-rubocop) | [GitHub](https://github.com/appraisal-rb/appraisal2-rubocop) | RuboCop Appraisal generator integration | [![Daily download rank for appraisal2-rubocop](https://img.shields.io/gem/rd/appraisal2-rubocop.svg?style=flat-square)](https://bestgems.org/gems/appraisal2-rubocop) |
| [kettle-dev](https://bestgems.org/gems/kettle-dev) | [GitHub](https://github.com/kettle-dev/kettle-dev) | development, release, and CI workflow tooling | [![Daily download rank for kettle-dev](https://img.shields.io/gem/rd/kettle-dev.svg?style=flat-square)](https://bestgems.org/gems/kettle-dev) |
| [kettle-jem](https://bestgems.org/gems/kettle-jem) | [GitHub](https://github.com/kettle-dev/kettle-jem) | Appraisals & CI workflow templates | [![Daily download rank for kettle-jem](https://img.shields.io/gem/rd/kettle-jem.svg?style=flat-square)](https://bestgems.org/gems/kettle-jem) |
| [kettle-soup-cover](https://bestgems.org/gems/kettle-soup-cover) | [GitHub](https://github.com/kettle-dev/kettle-soup-cover) | SimpleCov coverage policy and reporting | [![Daily download rank for kettle-soup-cover](https://img.shields.io/gem/rd/kettle-soup-cover.svg?style=flat-square)](https://bestgems.org/gems/kettle-soup-cover) |
| [kettle-test](https://bestgems.org/gems/kettle-test) | [GitHub](https://github.com/kettle-dev/kettle-test) | standard test runner and coverage harness | [![Daily download rank for kettle-test](https://img.shields.io/gem/rd/kettle-test.svg?style=flat-square)](https://bestgems.org/gems/kettle-test) |
| [rubocop-lts](https://bestgems.org/gems/rubocop-lts) | [GitHub](https://github.com/rubocop-lts/rubocop-lts) | Ruby-version-aware linting | [![Daily download rank for rubocop-lts](https://img.shields.io/gem/rd/rubocop-lts.svg?style=flat-square)](https://bestgems.org/gems/rubocop-lts) |
| [turbo_tests2](https://bestgems.org/gems/turbo_tests2) | [GitHub](https://github.com/galtzo-floss/turbo_tests2) | parallel test execution | [![Daily download rank for turbo_tests2](https://img.shields.io/gem/rd/turbo_tests2.svg?style=flat-square)](https://bestgems.org/gems/turbo_tests2) |

</details>

### Federated DVCS

<details markdown="1">
 <summary>Find this repo on federated forges (Coming soon!)</summary>

| Federated [DVCS][💎d-in-dvcs] Repository | Status | Issues | PRs | Wiki | CI | Discussions |
|-------------------------------------------------|-----------------------------------------------------------------------|---------------------------|--------------------------|---------------------------|--------------------------|------------------------------|
| 🧪 [omniauth/omniauth-identity on GitLab][📜src-gl] | The Truth | [💚][🤝gl-issues] | [💚][🤝gl-pulls] | [💚][📜gl-wiki] | 🐭 Tiny Matrix | ➖ |
| 🧊 [omniauth/omniauth-identity on CodeBerg][📜src-cb] | An Ethical Mirror ([Donate][🤝cb-donate]) | [💚][🤝cb-issues] | [💚][🤝cb-pulls] | ➖ | ⭕️ No Matrix | ➖ |
| 🐙 [omniauth/omniauth-identity on GitHub][📜src-gh] | Another Mirror | [💚][🤝gh-issues] | [💚][🤝gh-pulls] | [💚][📜gh-wiki] | 💯 Full Matrix | [💚][gh-discussions] |
| 🎮️ [Discord Server][✉️discord-invite] | [![Live Chat on Discord][✉️discord-invite-img-ftb]][✉️discord-invite] | [Let's][✉️discord-invite] | [talk][✉️discord-invite] | [about][✉️discord-invite] | [this][✉️discord-invite] | [library!][✉️discord-invite] |

</details>

[gh-discussions]: https://github.com/omniauth/omniauth-identity/discussions

### Enterprise Support [![Tidelift](https://tidelift.com/badges/package/rubygems/omniauth-identity)](https://tidelift.com/subscription/pkg/rubygems-omniauth-identity?utm_source=rubygems-omniauth-identity&utm_medium=referral&utm_campaign=readme)

Available as part of the Tidelift Subscription.

<details markdown="1">
 <summary>Need enterprise-level guarantees?</summary>

The maintainers of this and thousands of other packages are working with Tidelift to deliver commercial support and maintenance for the open source packages you use to build your applications. Save time, reduce risk, and improve code health, while paying the maintainers of the exact packages you use.

[![Get help from me on Tidelift][🏙️entsup-tidelift-img]][🏙️entsup-tidelift]

- 💡Subscribe for support guarantees covering _all_ your FLOSS dependencies
- 💡Tidelift is part of [Sonar][🏙️entsup-tidelift-sonar]
- 💡Tidelift pays maintainers to maintain the software you depend on!<br/>📊`@`Pointy Haired Boss: An [enterprise support][🏙️entsup-tidelift] subscription is "[never gonna let you down][🧮kloc]", and *supports* open source maintainers

Alternatively:

- [![Live Chat on Discord][✉️discord-invite-img-ftb]][✉️discord-invite]
- [![Get help from me on Upwork][👨🏼‍🏫expsup-upwork-img]][👨🏼‍🏫expsup-upwork]
- [![Get help from me on Codementor][👨🏼‍🏫expsup-codementor-img]][👨🏼‍🏫expsup-codementor]

</details>

## ✨ Installation

Install the gem and add to the application's Gemfile by executing:

```console
bundle add omniauth-identity
```

If bundler is not being used to manage dependencies, install the gem by executing:

```console
gem install omniauth-identity
```

## ⚙️ Configuration

This gem is compatible with a wide range of Ruby versions and Ruby ORMs, as of May 2025, version 3.1.

* Tested in CI against:
  * Ruby 2.4, 2.5, 2.6, 2.7, 3.0, 3.1, 3.2, 3.3, 3.4, ruby-head
  * JRuby 9.2, 9.3, 9.4, 10.0, jruby-head
  * omniauth 1.0, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0, 2.1, HEAD
  * activerecord 5.2, 6.0, 6.1, 7.0, 7.1, 7.2, 8.0, HEAD
  * sqlite3 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 2.0, 2.1
  * couch_potato 1.17+
  * mongoid 7.3, 7.4, 8.1, 9.0
  * bson 4.12, 4.15, 5.0, HEAD
  * sequel 5.86+
  * rom-sql (Ruby Object Mapper) 3.7+
* At least 6 different database ORM adapters, which connect to 15 different database clients!

| Databases                                                                                                 | Adapter Libraries                                                        |
|-----------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------|
| MySQL, MariaDB, PostgreSQL, SQLite                                                                        | [ActiveRecord](https://guides.rubyonrails.org/active_record_basics.html) |
| CouchDB                                                                                                   | [CouchPotato](https://github.com/langalex/couch_potato)                  |
| MongoDB                                                                                                   | [Mongoid](https://github.com/mongodb/mongoid)                            |
| RethinkDB                                                                                                 | [NoBrainer](http://nobrainer.io/)                                        |
| ADO, Amalgalite, IBM_DB, JDBC, MySQL, MariaDB, ODBC, Oracle, PostgreSQL, SQLAnywhere, SQLite, and TinyTDS | [rom-sql](https://rom-rb.org/)                                           |
| ADO, Amalgalite, IBM_DB, JDBC, MySQL, MariaDB, ODBC, Oracle, PostgreSQL, SQLAnywhere, SQLite, and TinyTDS | [Sequel](http://sequel.jeremyevans.net)                                  |

## 🔧 Basic Usage

This can be a bit hard to understand the first time. Luckily, Ryan Bates made
a [Railscast](http://railscasts.com/episodes/304-omniauth-identity) about it!

You use `omniauth-identity` just like you would any other OmniAuth provider: as a
Rack middleware. In rails, this would be created by an initializer, such as
`config/initializers/omniauth.rb`. The basic setup for an email/password authentication would look something like this:

```ruby
use OmniAuth::Builder do
  provider :identity,                 # required: tells OA that the Identity strategy is being used
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
it would have had the user authenticated through an external provider.

**Note:** OmniAuth Identity is different from many other user authentication
systems in that it is *not* built to store authentication information in your primary
`User` model. Instead, the `Identity` model should be **associated** with your
`User` model giving you maximum flexibility to include other authentication
strategies such as Facebook, Twitter, etc.

### ActiveRecord

Just subclass `OmniAuth::Identity::Models::ActiveRecord` and provide fields
in the database for all the fields you are using.

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

  class << self
    def where(search_hash)
      CouchPotato.database.view(Identity.by_email(key: search_hash))
    end
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

[ROM](https://rom-rb.org/) is an ORM for pretty much every database.

Include the `OmniAuth::Identity::Models::Rom` mixin and specify
the `rom_container`, everything else is optional.

```ruby
class Identity
  include OmniAuth::Identity::Models::Rom

  # Configure the ROM container and relation
  rom_container -> { MyDatabase.rom } # See spec/omniauth/identity/models/rom_spec.rb for example
  rom_relation_name :identities # optional, defaults to :idneitities
  owner_relation_name :owners  # optional, for loading associated owner
  auth_key :email  # optional, defaults to :email
  password_field :password_digest  # optional, defaults to :password_digest
end
```

### Custom Auth Model

To use a class other than the default, specify the <tt>:model</tt> option to a
different class.

```ruby
use OmniAuth::Builder do
  provider :identity, fields: [:email], model: MyCustomClass
end
```

NOTE: In the above example, `MyCustomClass` must have a class method called `auth_key` that returns
the default (`email`) or custom `auth_key` to use.

### Customizing Registration Failure

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

### Customizing Locate Conditions

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
object as a parameter.  Note that `model.auth_key` defaults to `email`, but is also configurable.

Note: Be careful when customizing `locate_conditions`.  The best way to modify the conditions is
to copy the default value, and then add to the hash.  Removing the default condition will almost
always break things!

### Customizing Other Things

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

## 🦷 FLOSS Funding

While omniauth tools are free software and will always be, the project would benefit immensely from some funding.
Raising a monthly budget of... "dollars" would make the project more sustainable.

We welcome both individual and corporate sponsors! We also offer a
wide array of funding channels to account for your preferences.
Currently, [Open Collective][🖇osc] is our preferred funding platform.

**If you're working in a company that's making significant use of omniauth tools we'd
appreciate it if you suggest to your company to become a omniauth sponsor.**

You can support the development of omniauth tools via
[GitHub Sponsors][🖇sponsor],
[Liberapay][⛳liberapay],
[PayPal][🖇paypal],
[Open Collective][🖇osc]
and [Tidelift][🏙️entsup-tidelift].

| 📍 NOTE |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| If doing a sponsorship in the form of donation is problematic for your company <br/> from an accounting standpoint, we'd recommend the use of Tidelift, <br/> where you can get a support-like subscription instead. |

### Open Collective for Individuals

Support us with a monthly donation and help us continue our activities. [[Become a backer](https://opencollective.com/omniauth#backer)]

NOTE: [kettle-readme-backers][kettle-readme-backers] updates this list every day, automatically.

<!-- OPENCOLLECTIVE-INDIVIDUALS:START -->
No backers yet. Be the first!
<!-- OPENCOLLECTIVE-INDIVIDUALS:END -->

### Open Collective for Organizations

Become a sponsor and get your logo on our README on GitHub with a link to your site. [[Become a sponsor](https://opencollective.com/omniauth#sponsor)]

NOTE: [kettle-readme-backers][kettle-readme-backers] updates this list every day, automatically.

<!-- OPENCOLLECTIVE-ORGANIZATIONS:START -->
No sponsors yet. Be the first!
<!-- OPENCOLLECTIVE-ORGANIZATIONS:END -->

[kettle-readme-backers]: https://github.com/omniauth/omniauth-identity/blob/main/bin/kettle-readme-backers

### Another way to support open-source

I’m driven by a passion to foster a thriving open-source community – a space where people can tackle complex problems, no matter how small. Revitalizing libraries that have fallen into disrepair, and building new libraries focused on solving real-world challenges, are my passions. I was recently affected by layoffs, and the tech jobs market is unwelcoming. I’m reaching out here because your support would significantly aid my efforts to provide for my family, and my farm (11 🐔 chickens, 2 🐶 dogs, 3 🐰 rabbits, 8 🐈‍ cats).

If you work at a company that uses my work, please encourage them to support me as a corporate sponsor. My work on gems you use might show up in `bundle fund`.

I’m developing a new library, [floss_funding][🖇floss-funding-gem], designed to empower open-source developers like myself to get paid for the work we do, in a sustainable way. Please give it a look.

**[Floss-Funding.dev][🖇floss-funding.dev]: 👉️ No network calls. 👉️ No tracking. 👉️ No oversight. 👉️ Minimal crypto hashing. 💡 Easily disabled nags**

[![OpenCollective Backers][🖇osc-backers-i]][🖇osc-backers] [![OpenCollective Sponsors][🖇osc-sponsors-i]][🖇osc-sponsors] [![Sponsor Me on Github][🖇sponsor-img]][🖇sponsor] [![Liberapay Goal Progress][⛳liberapay-img]][⛳liberapay] [![Donate on PayPal][🖇paypal-img]][🖇paypal] [![Buy me a coffee][🖇buyme-small-img]][🖇buyme] [![Donate on Polar][🖇polar-img]][🖇polar] [![Donate to my FLOSS efforts at ko-fi.com][🖇kofi-img]][🖇kofi] [![Donate to my FLOSS efforts using Patreon][🖇patreon-img]][🖇patreon]

## 🔐 Security

See [SECURITY.md][🔐security].

## 🤝 Contributing

If you need some ideas of where to help, you could work on adding more code coverage,
or if it is already 💯 (see [below](#code-coverage)) check [issues][🤝gh-issues] or [PRs][🤝gh-pulls],
or use the gem and think about how it could be better.

We [![Keep A Changelog][📗keep-changelog-img]][📗keep-changelog] so if you make changes, remember to update it.

See [CONTRIBUTING.md][🤝contributing] for more detailed instructions.

### 🚀 Release Instructions

See [CONTRIBUTING.md][🤝contributing].

### Code Coverage

<details markdown="1">
<summary>Coverage service badges</summary>

[![Coverage Graph][🏀codecov-g]][🏀codecov]

[![Coveralls Test Coverage][🏀coveralls-img]][🏀coveralls]

[![QLTY Test Coverage][🏀qlty-covi]][🏀qlty-cov]

</details>

### 🪇 Code of Conduct

Everyone interacting with this project's codebases, issue trackers,
chat rooms and mailing lists agrees to follow the [![Contributor Covenant 2.1][🪇conduct-img]][🪇conduct].

## 🌈 Contributors

[![Contributors][🖐contributors-img]][🖐contributors]

Made with [contributors-img][🖐contrib-rocks].

Also see GitLab Contributors: [https://gitlab.com/omniauth/omniauth-identity/-/graphs/main][🚎contributors-gl]

<details markdown="1">
 <summary>⭐️ Star History</summary>

<a href="https://star-history.com/omniauth/omniauth-identity&Date">
 <picture>
 <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=omniauth/omniauth-identity&type=Date&theme=dark" />
 <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=omniauth/omniauth-identity&type=Date" />
 <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=omniauth/omniauth-identity&type=Date" />
 </picture>
</a>

</details>

## 📌 Versioning

This library follows [![Semantic Versioning 2.0.0][📌semver-img]][📌semver] for its public API where practical.
For most applications, prefer the [Pessimistic Version Constraint][📌pvc] with two digits of precision.

For example:

```ruby
spec.add_dependency("omniauth-identity", "~> 3.0")
```

<details markdown="1">
<summary>📌 Is "Platform Support" part of the public API? More details inside.</summary>

Dropping support for a platform can be a breaking change for affected users.
If a release changes supported platforms, it should be called out clearly in the changelog and versioned with that impact in mind.

To get a better understanding of how SemVer is intended to work over a project's lifetime,
read this article from the creator of SemVer:

- ["Major Version Numbers are Not Sacred"][📌major-versions-not-sacred]

</details>

See [CHANGELOG.md][📌changelog] for a list of releases.

## 📄 License

The gem is available as open source under the terms of
the [MIT](MIT.md) [![License: MIT][📄license-img]][📄license-ref].

### © Copyright

See [LICENSE.md][📄license] for the official copyright notice.

<details markdown="1">
<summary>Copyright holders</summary>

- Copyright (c) 2025-2026 |7eter l-|. l3oling

</details>

## 🤑 A request for help

Maintainers have teeth and need to pay their dentists.
After getting laid off in an RIF in March, and encountering difficulty finding a new one,
I began spending most of my time building open source tools.
I'm hoping to be able to pay for my kids' health insurance this month,
so if you value the work I am doing, I need your support.
Please consider sponsoring me or the project.

To join the community or get help 👇️ Join the Discord.

[![Live Chat on Discord][✉️discord-invite-img-ftb]][✉️discord-invite]

To say "thanks!" ☝️ Join the Discord or 👇️ send money.

[![Sponsor omniauth/omniauth-identity on Open Source Collective][🖇osc-all-bottom-img]][🖇osc] 💌 [![Sponsor me on GitHub Sponsors][🖇sponsor-bottom-img]][🖇sponsor] 💌 [![Sponsor me on Liberapay][⛳liberapay-bottom-img]][⛳liberapay] 💌 [![Donate on PayPal][🖇paypal-bottom-img]][🖇paypal]

### Please give the project a star ⭐ ♥.

Many parts of this project are actively managed by a [kettle-jem](https://github.com/structuredmerge/structuredmerge-ruby/tree/main/gems/kettle-jem) smart template utilizing [StructuredMerge.org](https://structuredmerge.org) merge contracts.

Thanks for RTFM. ☺️

[⛳liberapay-img]: https://img.shields.io/liberapay/goal/pboling.svg?logo=liberapay&color=a51611&style=flat
[⛳liberapay-bottom-img]: https://img.shields.io/liberapay/goal/pboling.svg?style=for-the-badge&logo=liberapay&color=a51611
[⛳liberapay]: https://liberapay.com/pboling/donate
[🖇osc-all-img]: https://img.shields.io/opencollective/all/omniauth
[🖇osc-sponsors-img]: https://img.shields.io/opencollective/sponsors/omniauth
[🖇osc-backers-img]: https://img.shields.io/opencollective/backers/omniauth
[🖇osc-backers]: https://opencollective.com/omniauth#backer
[🖇osc-backers-i]: https://opencollective.com/omniauth/backers/badge.svg?style=flat
[🖇osc-sponsors]: https://opencollective.com/omniauth#sponsor
[🖇osc-sponsors-i]: https://opencollective.com/omniauth/sponsors/badge.svg?style=flat
[🖇osc-all-bottom-img]: https://img.shields.io/opencollective/all/omniauth?style=for-the-badge
[🖇osc-sponsors-bottom-img]: https://img.shields.io/opencollective/sponsors/omniauth?style=for-the-badge
[🖇osc-backers-bottom-img]: https://img.shields.io/opencollective/backers/omniauth?style=for-the-badge
[🖇osc]: https://opencollective.com/omniauth
[🖇sponsor-img]: https://img.shields.io/badge/Sponsor_Me!-pboling.svg?style=social&logo=github
[🖇sponsor-bottom-img]: https://img.shields.io/badge/Sponsor_Me!-pboling-blue?style=for-the-badge&logo=github
[🖇sponsor]: https://github.com/sponsors/pboling
[🖇polar-img]: https://img.shields.io/badge/polar-donate-a51611.svg?style=flat
[🖇polar]: https://polar.sh/pboling
[🖇kofi-img]: https://img.shields.io/badge/ko--fi-%E2%9C%93-a51611.svg?style=flat
[🖇kofi]: https://ko-fi.com/pboling
[🖇patreon-img]: https://img.shields.io/badge/patreon-donate-a51611.svg?style=flat
[🖇patreon]: https://patreon.com/galtzo
[🖇buyme-small-img]: https://img.shields.io/badge/buy_me_a_coffee-%E2%9C%93-a51611.svg?style=flat
[🖇buyme-img]: https://img.buymeacoffee.com/button-api/?text=Buy%20me%20a%20latte&emoji=&slug=pboling&button_colour=FFDD00&font_colour=000000&font_family=Cookie&outline_colour=000000&coffee_colour=ffffff
[🖇buyme]: https://www.buymeacoffee.com/pboling
[🖇paypal-img]: https://img.shields.io/badge/donate-paypal-a51611.svg?style=flat&logo=paypal
[🖇paypal-bottom-img]: https://img.shields.io/badge/donate-paypal-a51611.svg?style=for-the-badge&logo=paypal&color=0A0A0A
[🖇paypal]: https://www.paypal.com/paypalme/peterboling
[🖇floss-funding.dev]: https://floss-funding.dev
[🖇floss-funding-gem]: https://github.com/galtzo-floss/floss_funding
[✉️discord-invite]: https://discord.gg/3qme4XHNKN
[✉️discord-invite-img-ftb]: https://img.shields.io/discord/1373797679469170758?style=for-the-badge&logo=discord
[✉️ruby-friends-img]: https://img.shields.io/badge/daily.dev-%F0%9F%92%8E_Ruby_Friends-0A0A0A?style=for-the-badge&logo=dailydotdev&logoColor=white
[✉️ruby-friends]: https://app.daily.dev/squads/rubyfriends

[✇bundle-group-pattern]: https://gist.github.com/pboling/4564780
[⛳️gem-namespace]: https://github.com/omniauth/omniauth-identity
[⛳️namespace-img]: https://img.shields.io/badge/namespace-OmniAuth::Identity-3C2D2D.svg?style=square&logo=ruby&logoColor=white
[⛳️gem-name]: https://bestgems.org/gems/omniauth-identity
[⛳️name-img]: https://img.shields.io/badge/name-omniauth--identity-3C2D2D.svg?style=square&logo=rubygems&logoColor=red
[⛳️tag-img]: https://img.shields.io/github/tag/omniauth/omniauth-identity.svg
[⛳️tag]: https://github.com/omniauth/omniauth-identity/releases
[🚂maint-blog]: http://www.railsbling.com/tags/omniauth-identity
[🚂maint-blog-img]: https://img.shields.io/badge/blog-railsbling-0093D0.svg?style=for-the-badge&logo=rubyonrails&logoColor=orange
[🚂maint-contact]: http://www.railsbling.com/contact
[🚂maint-contact-img]: https://img.shields.io/badge/Contact-Maintainer-0093D0.svg?style=flat&logo=rubyonrails&logoColor=red
[💖🖇linkedin]: http://www.linkedin.com/in/peterboling
[💖🖇linkedin-img]: https://img.shields.io/badge/LinkedIn-Profile-0B66C2?style=flat&logo=newjapanprowrestling
[💖✌️wellfound]: https://wellfound.com/u/peter-boling
[💖✌️wellfound-img]: https://img.shields.io/badge/peter--boling-orange?style=flat&logo=wellfound
[💖💲crunchbase]: https://www.crunchbase.com/person/peter-boling
[💖💲crunchbase-img]: https://img.shields.io/badge/peter--boling-purple?style=flat&logo=crunchbase
[💖🐘ruby-mast]: https://ruby.social/@galtzo
[💖🐘ruby-mast-img]: https://img.shields.io/mastodon/follow/109447111526622197?domain=https://ruby.social&style=flat&logo=mastodon&label=Ruby%20@galtzo
[💖🦋bluesky]: https://bsky.app/profile/galtzo.com
[💖🦋bluesky-img]: https://img.shields.io/badge/@galtzo.com-0285FF?style=flat&logo=bluesky&logoColor=white
[💖🌳linktree]: https://linktr.ee/galtzo
[💖🌳linktree-img]: https://img.shields.io/badge/galtzo-purple?style=flat&logo=linktree
[💖💁🏼‍♂️devto]: https://dev.to/galtzo
[💖💁🏼‍♂️devto-img]: https://img.shields.io/badge/dev.to-0A0A0A?style=flat&logo=devdotto&logoColor=white
[💖💁🏼‍♂️aboutme]: https://about.me/peter.boling
[💖💁🏼‍♂️aboutme-img]: https://img.shields.io/badge/about.me-0A0A0A?style=flat&logo=aboutme&logoColor=white
[💖🧊berg]: https://codeberg.org/pboling
[💖🐙hub]: https://github.org/pboling
[💖🛖hut]: https://sr.ht/~galtzo/
[💖🧪lab]: https://gitlab.com/pboling
[👨🏼‍🏫expsup-upwork]: https://www.upwork.com/freelancers/~014942e9b056abdf86?mp_source=share
[👨🏼‍🏫expsup-upwork-img]: https://img.shields.io/badge/UpWork-13544E?style=for-the-badge&logo=Upwork&logoColor=white
[👨🏼‍🏫expsup-codementor]: https://www.codementor.io/peterboling?utm_source=github&utm_medium=button&utm_term=peterboling&utm_campaign=github
[👨🏼‍🏫expsup-codementor-img]: https://img.shields.io/badge/CodeMentor-Get_Help-1abc9c?style=for-the-badge&logo=CodeMentor&logoColor=white
[🏙️entsup-tidelift]: https://tidelift.com/subscription/pkg/rubygems-omniauth-identity?utm_source=rubygems-omniauth-identity&utm_medium=referral&utm_campaign=readme
[🏙️entsup-tidelift-img]: https://img.shields.io/badge/Tidelift_and_Sonar-Enterprise_Support-FD3456?style=for-the-badge&logo=sonar&logoColor=white
[🏙️entsup-tidelift-sonar]: https://blog.tidelift.com/tidelift-joins-sonar
[💁🏼‍♂️peterboling]: http://www.peterboling.com
[🚂railsbling]: http://www.railsbling.com
[📜src-gl-img]: https://img.shields.io/badge/GitLab-FBA326?style=for-the-badge&logo=Gitlab&logoColor=orange
[📜src-gl]: https://gitlab.com/omniauth/omniauth-identity
[📜src-cb-img]: https://img.shields.io/badge/CodeBerg-4893CC?style=for-the-badge&logo=CodeBerg&logoColor=blue
[📜src-cb]: https://codeberg.org/omniauth/omniauth-identity
[📜src-gh-img]: https://img.shields.io/badge/GitHub-238636?style=for-the-badge&logo=Github&logoColor=green
[📜src-gh]: https://github.com/omniauth/omniauth-identity
[📜docs-cr-rd-img]: https://img.shields.io/badge/RubyDoc-Current_Release-943CD2?style=for-the-badge&logo=readthedocs&logoColor=white
[📜docs-head-rd-img]: https://img.shields.io/badge/YARD_on_Galtzo.com-HEAD-943CD2?style=for-the-badge&logo=readthedocs&logoColor=white
[📜gl-wiki]: https://gitlab.com/omniauth/omniauth-identity/-/wikis/home
[📜gh-wiki]: https://github.com/omniauth/omniauth-identity/wiki
[📜gl-wiki-img]: https://img.shields.io/badge/wiki-gitlab-943CD2.svg?style=for-the-badge&logo=gitlab&logoColor=white
[📜gh-wiki-img]: https://img.shields.io/badge/wiki-github-943CD2.svg?style=for-the-badge&logo=github&logoColor=white
[👽dl-rank]: https://bestgems.org/gems/omniauth-identity
[👽dl-ranki]: https://img.shields.io/gem/rd/omniauth-identity.svg
[👽version]: https://bestgems.org/gems/omniauth-identity
[👽versioni]: https://img.shields.io/gem/v/omniauth-identity.svg
[🏀qlty-mnt]: https://qlty.sh/gh/omniauth/projects/omniauth-identity
[🏀qlty-mnti]: https://qlty.sh/gh/omniauth/projects/omniauth-identity/maintainability.svg
[🏀qlty-cov]: https://qlty.sh/gh/omniauth/projects/omniauth-identity/metrics/code?sort=coverageRating
[🏀qlty-covi]: https://qlty.sh/gh/omniauth/projects/omniauth-identity/coverage.svg
[🏀codecov]: https://codecov.io/gh/omniauth/omniauth-identity
[🏀codecovi]: https://codecov.io/gh/omniauth/omniauth-identity/graph/badge.svg
[🏀coveralls]: https://coveralls.io/github/omniauth/omniauth-identity?branch=main
[🏀coveralls-img]: https://coveralls.io/repos/github/omniauth/omniauth-identity/badge.svg?branch=main
[🚎ruby-2.4-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/ruby-2.4.yml
[🚎ruby-2.5-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/ruby-2.5.yml
[🚎ruby-2.6-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/ruby-2.6.yml
[🚎ruby-2.7-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/ruby-2.7.yml
[🚎ruby-3.0-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/ruby-3.0.yml
[🚎ruby-3.1-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/ruby-3.1.yml
[🚎ruby-3.2-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/ruby-3.2.yml
[🚎ruby-3.3-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/ruby-3.3.yml
[🚎ruby-3.4-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/ruby-3.4.yml
[🚎jruby-9.2-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/jruby-9.2.yml
[🚎jruby-9.3-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/jruby-9.3.yml
[🚎jruby-9.4-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/jruby-9.4.yml
[🚎jruby-10.0-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/jruby-10.0.yml
[🚎truby-22.3-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/truffleruby-22.3.yml
[🚎truby-23.0-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/truffleruby-23.0.yml
[🚎truby-23.1-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/truffleruby-23.1.yml
[🚎truby-24.2-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/truffleruby-24.2.yml
[🚎truby-25.0-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/truffleruby-25.0.yml
[🚎truby-33.0-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/truffleruby-33.0.yml
[🚎2-cov-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/coverage.yml
[🚎2-cov-wfi]: https://github.com/omniauth/omniauth-identity/actions/workflows/coverage.yml/badge.svg
[🚎3-hd-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/heads.yml
[🚎3-hd-wfi]: https://github.com/omniauth/omniauth-identity/actions/workflows/heads.yml/badge.svg
[🚎5-st-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/style.yml
[🚎5-st-wfi]: https://github.com/omniauth/omniauth-identity/actions/workflows/style.yml/badge.svg
[🚎9-t-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/truffle.yml
[🚎9-t-wfi]: https://github.com/omniauth/omniauth-identity/actions/workflows/truffle.yml/badge.svg
[🚎10-j-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/jruby.yml
[🚎10-j-wfi]: https://github.com/omniauth/omniauth-identity/actions/workflows/jruby.yml/badge.svg
[🚎11-c-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/current.yml
[🚎11-c-wfi]: https://github.com/omniauth/omniauth-identity/actions/workflows/current.yml/badge.svg
[🚎12-crh-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/dep-heads.yml
[🚎12-crh-wfi]: https://github.com/omniauth/omniauth-identity/actions/workflows/dep-heads.yml/badge.svg
[🚎13-🔒️-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/locked_deps.yml
[🚎13-🔒️-wfi]: https://github.com/omniauth/omniauth-identity/actions/workflows/locked_deps.yml/badge.svg
[🚎14-🔓️-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/unlocked_deps.yml
[🚎14-🔓️-wfi]: https://github.com/omniauth/omniauth-identity/actions/workflows/unlocked_deps.yml/badge.svg
[🚎15-🪪-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/license-eye.yml
[🚎15-🪪-wfi]: https://github.com/omniauth/omniauth-identity/actions/workflows/license-eye.yml/badge.svg
[💎ruby-2.4i]: https://img.shields.io/badge/Ruby-2.4-DF00CA?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-2.5i]: https://img.shields.io/badge/Ruby-2.5-DF00CA?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-2.6i]: https://img.shields.io/badge/Ruby-2.6-DF00CA?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-2.7i]: https://img.shields.io/badge/Ruby-2.7-DF00CA?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-3.0i]: https://img.shields.io/badge/Ruby-3.0-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-3.1i]: https://img.shields.io/badge/Ruby-3.1-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-3.2i]: https://img.shields.io/badge/Ruby-3.2-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-3.3i]: https://img.shields.io/badge/Ruby-3.3-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-3.4i]: https://img.shields.io/badge/Ruby-3.4-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-c-i]: https://img.shields.io/badge/Ruby-current-CC342D?style=for-the-badge&logo=ruby&logoColor=green
[💎ruby-headi]: https://img.shields.io/badge/Ruby-HEAD-CC342D?style=for-the-badge&logo=ruby&logoColor=blue
[💎truby-22.3i]: https://img.shields.io/badge/Truffle_Ruby-22.3-34BCB1?style=for-the-badge&logo=ruby&logoColor=pink
[💎truby-23.0i]: https://img.shields.io/badge/Truffle_Ruby-23.0-34BCB1?style=for-the-badge&logo=ruby&logoColor=pink
[💎truby-23.1i]: https://img.shields.io/badge/Truffle_Ruby-23.1-34BCB1?style=for-the-badge&logo=ruby&logoColor=pink
[💎truby-24.2i]: https://img.shields.io/badge/Truffle_Ruby-24.2-34BCB1?style=for-the-badge&logo=ruby&logoColor=pink
[💎truby-25.0i]: https://img.shields.io/badge/Truffle_Ruby-25.0-34BCB1?style=for-the-badge&logo=ruby&logoColor=pink
[💎truby-33.0i]: https://img.shields.io/badge/Truffle_Ruby-33.0-34BCB1?style=for-the-badge&logo=ruby&logoColor=pink
[💎truby-c-i]: https://img.shields.io/badge/Truffle_Ruby-current-34BCB1?style=for-the-badge&logo=ruby&logoColor=green
[💎truby-headi]: https://img.shields.io/badge/Truffle_Ruby-HEAD-34BCB1?style=for-the-badge&logo=ruby&logoColor=blue
[💎jruby-9.2i]: https://img.shields.io/badge/JRuby-9.2-FBE742?style=for-the-badge&logo=ruby&logoColor=red
[💎jruby-9.3i]: https://img.shields.io/badge/JRuby-9.3-FBE742?style=for-the-badge&logo=ruby&logoColor=red
[💎jruby-9.4i]: https://img.shields.io/badge/JRuby-9.4-FBE742?style=for-the-badge&logo=ruby&logoColor=red
[💎jruby-10.0i]: https://img.shields.io/badge/JRuby-10.0-FBE742?style=for-the-badge&logo=ruby&logoColor=red
[💎jruby-c-i]: https://img.shields.io/badge/JRuby-current-FBE742?style=for-the-badge&logo=ruby&logoColor=green
[💎jruby-headi]: https://img.shields.io/badge/JRuby-HEAD-FBE742?style=for-the-badge&logo=ruby&logoColor=blue
[🤝gh-issues]: https://github.com/omniauth/omniauth-identity/issues
[🤝gh-pulls]: https://github.com/omniauth/omniauth-identity/pulls
[🤝gl-issues]: https://gitlab.com/omniauth/omniauth-identity/-/issues
[🤝gl-pulls]: https://gitlab.com/omniauth/omniauth-identity/-/merge_requests
[🤝cb-issues]: https://codeberg.org/omniauth/omniauth-identity/issues
[🤝cb-pulls]: https://codeberg.org/omniauth/omniauth-identity/pulls
[🤝cb-donate]: https://donate.codeberg.org/
[🤝contributing]: https://github.com/omniauth/omniauth-identity/blob/main/CONTRIBUTING.md
[🏀codecov-g]: https://codecov.io/gh/omniauth/omniauth-identity/graph/badge.svg
[🖐contrib-rocks]: https://contrib.rocks
[🖐contributors]: https://github.com/omniauth/omniauth-identity/graphs/contributors
[🖐contributors-img]: https://contrib.rocks/image?repo=omniauth/omniauth-identity
[🚎contributors-gl]: https://gitlab.com/omniauth/omniauth-identity/-/graphs/main
[🪇conduct]: https://github.com/omniauth/omniauth-identity/blob/main/CODE_OF_CONDUCT.md
[🪇conduct-img]: https://img.shields.io/badge/Contributor_Covenant-2.1-259D6C.svg
[📌pvc]: http://guides.rubygems.org/patterns/#pessimistic-version-constraint
[📌semver]: https://semver.org/spec/v2.0.0.html
[📌semver-img]: https://img.shields.io/badge/semver-2.0.0-259D6C.svg?style=flat
[📌semver-breaking]: https://github.com/semver/semver/issues/716#issuecomment-869336139
[📌major-versions-not-sacred]: https://tom.preston-werner.com/2022/05/23/major-version-numbers-are-not-sacred.html
[📌changelog]: https://github.com/omniauth/omniauth-identity/blob/main/CHANGELOG.md
[📗keep-changelog]: https://keepachangelog.com/en/1.0.0/
[📗keep-changelog-img]: https://img.shields.io/badge/keep--a--changelog-1.0.0-34495e.svg?style=flat
[📌gitmoji]: https://gitmoji.dev
[📌gitmoji-img]: https://img.shields.io/badge/gitmoji_commits-%20%F0%9F%98%9C%20%F0%9F%98%8D-34495e.svg?style=flat-square
[🧮kloc]: https://www.youtube.com/watch?v=dQw4w9WgXcQ
[🧮kloc-img]: https://img.shields.io/badge/KLOC-0.397-FFDD67.svg?style=for-the-badge&logo=YouTube&logoColor=blue
[🔐security]: https://github.com/omniauth/omniauth-identity/blob/main/SECURITY.md
[🔐security-img]: https://img.shields.io/badge/security-policy-259D6C.svg?style=flat
[📄copyright-notice-explainer]: https://opensource.stackexchange.com/questions/5778/why-do-licenses-such-as-the-mit-license-specify-a-single-year
[📄license]: LICENSE.md
[📄license-ref]: MIT.md
[📄license-img]: https://img.shields.io/badge/License-MIT-259D6C.svg
[📄license-compat]: https://www.apache.org/legal/resolved.html#category-a
[📄license-compat-img]: https://img.shields.io/badge/Apache_Compatible:_Category_A-%E2%9C%93-259D6C.svg?style=flat&logo=Apache

[📄ilo-declaration]: https://www.ilo.org/declaration/lang--en/index.htm
[📄ilo-declaration-img]: https://img.shields.io/badge/ILO_Fundamental_Principles-✓-259D6C.svg?style=flat
[🚎yard-current]: http://rubydoc.info/gems/omniauth-identity
[🚎yard-head]: https://omniauth-identity.galtzo.com
[💎stone_checksums]: https://github.com/galtzo-floss/stone_checksums
[💎SHA_checksums]: https://gitlab.com/omniauth/omniauth-identity/-/tree/main/checksums
[💎rlts]: https://github.com/rubocop-lts/rubocop-lts
[💎rlts-img]: https://img.shields.io/badge/code_style_&_linting-rubocop--lts-34495e.svg?plastic&logo=ruby&logoColor=white
[💎appraisal2]: https://github.com/appraisal-rb/appraisal2
[💎appraisal2-img]: https://img.shields.io/badge/appraised_by-appraisal2-34495e.svg?plastic&logo=ruby&logoColor=white
[💎d-in-dvcs]: https://railsbling.com/posts/dvcs/put_the_d_in_dvcs/

<!-- kettle-jem:metadata:start -->
| Field | Value |
|---|---|
| Package | omniauth-identity |
| Description | 🫵 Traditional username/password based authentication system for OmniAuth |
| Homepage | https://github.com/omniauth/omniauth-identity |
| Source | https://github.com/omniauth/omniauth-identity |
| License | `MIT` |
| Funding | https://github.com/sponsors/pboling, https://issuehunt.io/u/pboling, https://ko-fi.com/pboling, https://liberapay.com/pboling/donate, https://opencollective.com/omniauth, https://patreon.com/galtzo, https://polar.sh/pboling, https://thanks.dev/u/gh/pboling, https://tidelift.com/funding/github/rubygems/omniauth-identity, https://www.buymeacoffee.com/pboling |
<!-- kettle-jem:metadata:end -->
