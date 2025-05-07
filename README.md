# `OmniAuth::Identity`

[![Version][👽versioni]][👽version]
[![License: MIT][📄license-img]][📄license-ref]
[![Downloads Rank][👽dl-ranki]][👽dl-rank]
[![Open Source Helpers][👽oss-helpi]][👽oss-help]
[![Depfu][🔑depfui♻️]][🔑depfu]
[![CodeCov Test Coverage][🔑codecovi♻️]][🔑codecov]
[![Coveralls Test Coverage][🔑coveralls-img]][🔑coveralls]
[![CI Heads][🚎3-hd-wfi]][🚎3-hd-wf]
[![CI Current][🚎11-c-wfi]][🚎11-c-wf]
[![CI Supported][🚎6-s-wfi]][🚎6-s-wf]
[![CI Legacy][🚎4-lg-wfi]][🚎4-lg-wf]
[![CI Unsupported][🚎7-us-wfi]][🚎7-us-wf]
[![CI Ancient][🚎1-an-wfi]][🚎1-an-wf]
[![CI Test Coverage][🚎2-cov-wfi]][🚎2-cov-wf]
[![CI Style][🚎5-st-wfi]][🚎5-st-wf]

---

[![Liberapay Patrons][⛳liberapay-img]][⛳liberapay]
[![Sponsor Me on Github][🖇sponsor-img]][🖇sponsor]
[![Buy me a coffee][🖇buyme-small-img]][🖇buyme]
[![Donate on Polar][🖇polar-img]][🖇polar]
[![Donate to my FLOSS or refugee efforts at ko-fi.com][🖇kofi-img]][🖇kofi]
[![Donate to my FLOSS or refugee efforts using Patreon][🖇patreon-img]][🖇patreon]

The `omniauth-identity` gem provides a way for applications to utilize a
traditional username/password based authentication system without the need
to give up the simple authentication flow provided by OmniAuth. Identity
is designed on purpose to be as featureless as possible: it provides the
basic construct for user management and then gets out of the way.

## 💡 Info you can shake a stick at

| Tokens to Remember      | [![Gem name][⛳️name-img]][⛳️gem-name] [![Gem namespace][⛳️namespace-img]][⛳️gem-namespace]                                                                                                                                                                                                                                                                                                                                                                          |
|-------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Works with JRuby        | [![JRuby 9.2 Compat][💎jruby-9.2i]][🚎10-j-wf] [![JRuby 9.3 Compat][💎jruby-9.3i]][🚎10-j-wf] [![JRuby 9.4 Compat][💎jruby-9.4i]][🚎10-j-wf] [![JRuby 10.0 Compat][💎jruby-c-i]][🚎11-c-wf] [![JRuby HEAD Compat][💎jruby-headi]][🚎3-hd-wf]                                                                                                                                                                         |
| Works with Truffle Ruby | [![Truffle Ruby 22.3 Compat][💎truby-22.3i]][🚎9-t-wf] [![Truffle Ruby 23.0 Compat][💎truby-23.0i]][🚎9-t-wf] [![Truffle Ruby 23.1 Compat][💎truby-23.1i]][🚎9-t-wf] [![Truffle Ruby 24.1 Compat][💎truby-c-i]][🚎11-c-wf] [![Truffle Ruby HEAD Compat][💎truby-headi]][🚎3-hd-wf]                                                                                                                                                                                  |
| Works with MRI Ruby 3   | [![Ruby 3.0 Compat][💎ruby-3.0i]][🚎4-lg-wf] [![Ruby 3.1 Compat][💎ruby-3.1i]][🚎6-s-wf] [![Ruby 3.2 Compat][💎ruby-3.2i]][🚎6-s-wf] [![Ruby 3.3 Compat][💎ruby-3.3i]][🚎6-s-wf] [![Ruby 3.4 Compat][💎ruby-c-i]][🚎11-c-wf] [![Ruby HEAD Compat][💎ruby-headi]][🚎3-hd-wf]                                                                                                                                                                                         |
| Works with MRI Ruby 2   | [![Ruby 2.4 Compat][💎ruby-2.4i]][🚎1-an-wf] [![Ruby 2.5 Compat][💎ruby-2.5i]][🚎1-an-wf] [![Ruby 2.6 Compat][💎ruby-2.6i]][🚎7-us-wf] [![Ruby 2.7 Compat][💎ruby-2.7i]][🚎7-us-wf]                                                                                                                                                                                                                                                                                 |
| Source                  | [![Source on Github.com][📜src-gh-img]][📜src-gh] [![The best SHA: dQw4w9WgXcQ!][🧮kloc-img]][🧮kloc]                                                                                                                                                                                                                                                                                                             |
| Documentation           | [![Current release on RubyDoc.info][📜docs-cr-rd-img]][🚎yard-current] [![HEAD on RubyDoc.info][📜docs-head-rd-img]][🚎yard-head] [![BDFL Blog][🚂bdfl-blog-img]][🚂bdfl-blog] [![Wiki][📜wiki-img]][📜wiki]                                                                                                                                                                                                                                                        |
| Compliance              | [![License: MIT][📄license-img]][📄license-ref] [![📄ilo-declaration-img]][📄ilo-declaration] [![Security Policy][🔐security-img]][🔐security] [![CodeQL][🖐codeQL-img]][🖐codeQL] [![Contributor Covenant 2.1][🪇conduct-img]][🪇conduct] [![SemVer 2.0.0][📌semver-img]][📌semver] [![Keep-A-Changelog 1.0.0][📗keep-changelog-img]][📗keep-changelog] [![Gitmoji Commits][📌gitmoji-img]][📌gitmoji]                                                             |
| Expert 1:1 Support      | [![Get help from me on Upwork][👨🏼‍🏫expsup-upwork-img]][👨🏼‍🏫expsup-upwork] `or` [![Get help from me on Codementor][👨🏼‍🏫expsup-codementor-img]][👨🏼‍🏫expsup-codementor]                                                                                                                                                                                                                                                                                    |
| Enterprise Support      | [![Get help from me on Tidelift][🏙️entsup-tidelift-img]][🏙️entsup-tidelift]<br/>💡Subscribe for support guarantees covering _all_ FLOSS dependencies!<br/>💡Tidelift is part of [Sonar][🏙️entsup-tidelift-sonar]!<br/>💡Tidelift pays maintainers to maintain the software you depend on!<br/>📊`@`Pointy Haired Boss: An [enterprise support][🏙️entsup-tidelift] subscription is "[never gonna let you down][🧮kloc]", and *supports* open source maintainers! |
| Comrade BDFL 🎖️        | [![Follow Me on LinkedIn][💖🖇linkedin-img]][💖🖇linkedin] [![Follow Me on Ruby.Social][💖🐘ruby-mast-img]][💖🐘ruby-mast] [![Follow Me on Bluesky][💖🦋bluesky-img]][💖🦋bluesky] [![Contact BDFL][🚂bdfl-contact-img]][🚂bdfl-contact] [![My technical writing][💖💁🏼‍♂️devto-img]][💖💁🏼‍♂️devto]                                                                                                                                                              |
| `...` 💖                | [![Find Me on WellFound:][💖✌️wellfound-img]][💖✌️wellfound] [![Find Me on CrunchBase][💖💲crunchbase-img]][💖💲crunchbase] [![My LinkTree][💖🌳linktree-img]][💖🌳linktree] [![More About Me][💖💁🏼‍♂️aboutme-img]][💖💁🏼‍♂️aboutme] [🧊][💖🧊berg] [🐙][💖🐙hub]  [🛖][💖🛖hut] [🧪][💖🧪lab]                                                                                                                                                                   |

## ✨ Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add omniauth-identity

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install omniauth-identity

### 🔒 Secure Installation

`omniauth-identity` is cryptographically signed, and with verifiable [SHA-256 and SHA-512][💎SHA_checksums] checksums by
[stone_checksums][💎stone_checksums]. Be sure the gem you install hasn’t been tampered with
by following the instructions below.

Add my public key (if you haven’t already, expires 2045-04-29) as a trusted certificate:

```shell
gem cert --add <(curl -Ls https://raw.github.com/omniauth/omniauth-identity/main/certs/pboling.pem)
```

You only need to do that once.  Then proceed to install with:

```shell
gem install omniauth-identity -P MediumSecurity
```

The `MediumSecurity` trust profile will verify signed gems, but allow the installation of unsigned dependencies.

This is necessary because not all of `omniauth-identity`’s dependencies are signed, so we cannot use `HighSecurity`.

If you want to up your security game full-time:

```shell
bundle config set --global trust-policy MediumSecurity
```

NOTE: Be prepared to track down certs for signed gems and add them the same way you added mine.

## 🔧 Compatibility

This gem is compatible with a wide range of Ruby versions and Ruby ORMs, as of Nov 2024, version 3.1.

* Latest released version of omniauth, v2+
* Tested in CI against Ruby 2.5, 2.6, 2.7, 3.0, 3.1, 3.2, 3.3, 3.4, ruby-head, truffleruby-head
* Probably also compatible with Ruby 2.4 and jruby-head
* At least 5 different database ORM adapters, which connect to 15 different database clients!

| Databases                                                                                                 | Adapter Libraries                                                        |
| --------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------ |
| MySQL, MariaDB, PostgreSQL, SQLite                                                                        | [ActiveRecord](https://guides.rubyonrails.org/active_record_basics.html) |
| CouchDB                                                                                                   | [CouchPotato](https://github.com/langalex/couch_potato)                  |
| MongoDB                                                                                                   | [Mongoid](https://github.com/mongodb/mongoid)                            |
| RethinkDB                                                                                                 | [NoBrainer](http://nobrainer.io/)                                        |
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
object as a parameter.  Note  that `model.auth_key` defaults to `email`, but is also configurable.

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

## 🔐 Security

See [SECURITY.md][🔐security].

## 🤝 Contributing

If you need some ideas of where to help, you could work on adding more code coverage,
or if it is already 💯 (see [below](#code-coverage)) then check [issues][🤝issues], or [PRs][🤝pulls],
or use the gem and think about how it could be better.

We [![Keep A Changelog][📗keep-changelog-img]][📗keep-changelog] so if you make changes, remember to update it.

See [CONTRIBUTING.md][🤝contributing] for more detailed instructions.

### Code Coverage

[![Coverage Graph][🔑codecov-g♻️]][🔑codecov]

### 🪇 Code of Conduct

Everyone interacting in this project's codebases, issue trackers,
chat rooms and mailing lists is expected to follow the [![Contributor Covenant 2.1][🪇conduct-img]][🪇conduct].

## 🌈 Contributors

[![Contributors][🖐contributors-img]][🖐contributors]

Made with [contributors-img][🖐contrib-rocks].

## ⭐️ Star History

<a href="https://star-history.com/#omniauth/omniauth-identity&Date">
 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=omniauth/omniauth-identity&type=Date&theme=dark" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=omniauth/omniauth-identity&type=Date" />
   <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=omniauth/omniauth-identity&type=Date" />
 </picture>
</a>

## 📌 Versioning

This Library adheres to [![Semantic Versioning 2.0.0][📌semver-img]][📌semver].
Violations of this scheme should be reported as bugs.
Specifically, if a minor or patch version is released that breaks backward compatibility,
a new version should be immediately released that restores compatibility.
Breaking changes to the public API will only be introduced with new major versions.

### 📌 Is "Platform Support" part of the public API?

Yes.  But I'm obligated to include notes...

SemVer should, but doesn't explicitly, say that dropping support for specific Platforms
is a *breaking change* to an API.
It is obvious to many, but not all, and since the spec is silent, the bike shedding is endless.

> dropping support for a platform is both obviously and objectively a breaking change

- Jordan Harband (@ljharb, maintainer of SemVer) [in SemVer issue 716][📌semver-breaking]

To get a better understanding of how SemVer is intended to work over a project's lifetime,
read this article from the creator of SemVer:

- ["Major Version Numbers are Not Sacred"][📌major-versions-not-sacred]

As a result of this policy, and the interpretive lens used by the maintainer,
you can (and should) specify a dependency on these libraries using
the [Pessimistic Version Constraint][📌pvc] with two digits of precision.

For example:

```ruby
spec.add_dependency("omniauth-identity", "~> 3.1")
```

See [CHANGELOG.md][📌changelog] for list of releases.

## 📄 License

The gem is available as open source under the terms of
the [MIT License][📄license] [![License: MIT][📄license-img]][📄license-ref].
See [LICENSE.txt][📄license] for the official [Copyright Notice][📄copyright-notice-explainer].

### © Copyright

* Copyright (c) 2021, 2024 [Peter H. Boling][peterboling], and OmniAuth-Identity Maintainers
* Copyright (c) 2020 [Peter H. Boling][peterboling], Andrew Roberts, and Jellybooks Ltd.
* Copyright (c) 2010-2015 Michael Bleigh, and Intridea, Inc.

## 🤑 One more thing

You made it to the bottom of the page,
so perhaps you'll indulge me for another 20 seconds.
I maintain many dozens of gems, including this one,
because I want Ruby to be a great place for people to solve problems, big and small.
Please consider supporting my efforts via the giant yellow link below,
or one of the others at the head of this README.

[![Buy me a latte][🖇buyme-img]][🖇buyme]

[✇bundle-group-pattern]: https://gist.github.com/pboling/4564780
[⛳️gem-namespace]: https://github.com/omniauth/omniauth-identity
[⛳️namespace-img]: https://img.shields.io/badge/namespace-OmniAuth%3A%3AIdentity-brightgreen.svg?style=flat&logo=ruby&logoColor=white
[⛳️gem-name]: https://rubygems.org/gems/omniauth-identity
[⛳️name-img]: https://img.shields.io/badge/name-omniauth--identity-brightgreen.svg?style=flat&logo=rubygems&logoColor=red
[🚂bdfl-blog]: http://www.railsbling.com/tags/omniauth-identity
[🚂bdfl-blog-img]: https://img.shields.io/badge/blog-railsbling-0093D0.svg?style=for-the-badge&logo=rubyonrails&logoColor=orange
[🚂bdfl-contact]: http://www.railsbling.com/contact
[🚂bdfl-contact-img]: https://img.shields.io/badge/Contact-BDFL-0093D0.svg?style=flat&logo=rubyonrails&logoColor=red
[💖🖇linkedin]: http://www.linkedin.com/in/peterboling
[💖🖇linkedin-img]: https://img.shields.io/badge/PeterBoling-LinkedIn-0B66C2?style=flat&logo=newjapanprowrestling
[💖✌️wellfound]: https://angel.co/u/peter-boling
[💖✌️wellfound-img]: https://img.shields.io/badge/peter--boling-orange?style=flat&logo=wellfound
[💖💲crunchbase]: https://www.crunchbase.com/person/peter-boling
[💖💲crunchbase-img]: https://img.shields.io/badge/peter--boling-purple?style=flat&logo=crunchbase
[💖🐘ruby-mast]: https://ruby.social/@galtzo
[💖🐘ruby-mast-img]: https://img.shields.io/mastodon/follow/109447111526622197?domain=https%3A%2F%2Fruby.social&style=flat&logo=mastodon&label=Ruby%20%40galtzo
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
[🏙️entsup-tidelift]: https://tidelift.com/subscription
[🏙️entsup-tidelift-img]: https://img.shields.io/badge/Tidelift_and_Sonar-Enterprise_Support-FD3456?style=for-the-badge&logo=sonar&logoColor=white
[🏙️entsup-tidelift-sonar]: https://blog.tidelift.com/tidelift-joins-sonar
[💁🏼‍♂️peterboling]: http://www.peterboling.com
[🚂railsbling]: http://www.railsbling.com
[📜src-gl-img]: https://img.shields.io/badge/GitLab-FBA326?style=for-the-badge&logo=Gitlab&logoColor=orange
[📜src-gl]: https://gitlab.com/omniauth/omniauth-identity/
[📜src-cb-img]: https://img.shields.io/badge/CodeBerg-4893CC?style=for-the-badge&logo=CodeBerg&logoColor=blue
[📜src-cb]: https://codeberg.org/omniauth/omniauth-identity
[📜src-gh-img]: https://img.shields.io/badge/GitHub-238636?style=for-the-badge&logo=Github&logoColor=green
[📜src-gh]: https://github.com/omniauth/omniauth-identity
[📜docs-cr-rd-img]: https://img.shields.io/badge/RubyDoc-Current_Release-943CD2?style=for-the-badge&logo=readthedocs&logoColor=white
[📜docs-head-rd-img]: https://img.shields.io/badge/RubyDoc-HEAD-943CD2?style=for-the-badge&logo=readthedocs&logoColor=white
[📜wiki]: https://gitlab.com/omniauth/omniauth-identity/-/wikis/home
[📜wiki-img]: https://img.shields.io/badge/wiki-examples-943CD2.svg?style=for-the-badge&logo=Wiki&logoColor=white
[👽dl-rank]: https://rubygems.org/gems/omniauth-identity
[👽dl-ranki]: https://img.shields.io/gem/rd/omniauth-identity.svg
[👽oss-help]: https://www.codetriage.com/omniauth/omniauth-identity
[👽oss-helpi]: https://www.codetriage.com/omniauth/omniauth-identity/badges/users.svg
[👽version]: https://rubygems.org/gems/omniauth-identity
[👽versioni]: https://img.shields.io/gem/v/omniauth-identity.svg
[🔑codecov]: https://codecov.io/gh/omniauth/omniauth-identity
[🔑codecovi♻️]: https://codecov.io/gh/omniauth/omniauth-identity/branch/main/graph/badge.svg?token=cc6UdZCpAL
[🔑coveralls]: https://coveralls.io/github/omniauth/omniauth-identity?branch=main
[🔑coveralls-img]: https://coveralls.io/repos/github/omniauth/omniauth-identity/badge.svg?branch=main
[🔑depfu]: https://depfu.com/github/omniauth/omniauth-identity?project_id=22381
[🔑depfui♻️]: https://badges.depfu.com/badges/6c9b45362951b872127f9e46d39bed76/count.svg
[🖐codeQL]: https://github.com/omniauth/omniauth-identity/security/code-scanning
[🖐codeQL-img]: https://github.com/omniauth/omniauth-identity/actions/workflows/codeql-analysis.yml/badge.svg
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
[🚎8-ho-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/hoary.yml
[🚎8-ho-wfi]: https://github.com/omniauth/omniauth-identity/actions/workflows/hoary.yml/badge.svg
[🚎9-t-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/truffle.yml
[🚎9-t-wfi]: https://github.com/omniauth/omniauth-identity/actions/workflows/truffle.yml/badge.svg
[🚎10-j-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/jruby.yml
[🚎10-j-wfi]: https://github.com/omniauth/omniauth-identity/actions/workflows/jruby.yml/badge.svg
[🚎11-c-wf]: https://github.com/omniauth/omniauth-identity/actions/workflows/current.yml
[🚎11-c-wfi]: https://github.com/omniauth/omniauth-identity/actions/workflows/current.yml/badge.svg
[⛳liberapay-img]: https://img.shields.io/liberapay/goal/pboling.svg?logo=liberapay
[⛳liberapay]: https://liberapay.com/pboling/donate
[🖇sponsor-img]: https://img.shields.io/badge/Sponsor_Me!-pboling.svg?style=social&logo=github
[🖇sponsor]: https://github.com/sponsors/pboling
[🖇polar-img]: https://img.shields.io/badge/polar-donate-yellow.svg
[🖇polar]: https://polar.sh/pboling
[🖇kofi-img]: https://img.shields.io/badge/a_more_different_coffee-✓-yellow.svg
[🖇kofi]: https://ko-fi.com/O5O86SNP4
[🖇patreon-img]: https://img.shields.io/badge/patreon-donate-yellow.svg
[🖇patreon]: https://patreon.com/galtzo
[🖇buyme-img]: https://img.buymeacoffee.com/button-api/?text=Buy%20me%20a%20latte&emoji=&slug=pboling&button_colour=FFDD00&font_colour=000000&font_family=Cookie&outline_colour=000000&coffee_colour=ffffff
[🖇buyme]: https://www.buymeacoffee.com/pboling
[🖇buyme-small-img]: https://img.shields.io/badge/buy_me_a_coffee-✓-yellow.svg?style=flat
[💎ruby-2.3i]: https://img.shields.io/badge/Ruby-2.3-DF00CA?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-2.4i]: https://img.shields.io/badge/Ruby-2.4-DF00CA?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-2.5i]: https://img.shields.io/badge/Ruby-2.5-DF00CA?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-2.6i]: https://img.shields.io/badge/Ruby-2.6-DF00CA?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-2.7i]: https://img.shields.io/badge/Ruby-2.7-DF00CA?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-3.0i]: https://img.shields.io/badge/Ruby-3.0-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-3.1i]: https://img.shields.io/badge/Ruby-3.1-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-3.2i]: https://img.shields.io/badge/Ruby-3.2-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-3.3i]: https://img.shields.io/badge/Ruby-3.3-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-c-i]: https://img.shields.io/badge/Ruby-current-CC342D?style=for-the-badge&logo=ruby&logoColor=green
[💎ruby-headi]: https://img.shields.io/badge/Ruby-HEAD-CC342D?style=for-the-badge&logo=ruby&logoColor=blue
[💎truby-22.3i]: https://img.shields.io/badge/Truffle_Ruby-22.3-34BCB1?style=for-the-badge&logo=ruby&logoColor=pink
[💎truby-23.0i]: https://img.shields.io/badge/Truffle_Ruby-23.0-34BCB1?style=for-the-badge&logo=ruby&logoColor=pink
[💎truby-23.1i]: https://img.shields.io/badge/Truffle_Ruby-23.1-34BCB1?style=for-the-badge&logo=ruby&logoColor=pink
[💎truby-c-i]: https://img.shields.io/badge/Truffle_Ruby-current-34BCB1?style=for-the-badge&logo=ruby&logoColor=green
[💎truby-headi]: https://img.shields.io/badge/Truffle_Ruby-HEAD-34BCB1?style=for-the-badge&logo=ruby&logoColor=blue
[💎jruby-9.2i]: https://img.shields.io/badge/JRuby-9.2-FBE742?style=for-the-badge&logo=ruby&logoColor=red
[💎jruby-9.3i]: https://img.shields.io/badge/JRuby-9.3-FBE742?style=for-the-badge&logo=ruby&logoColor=red
[💎jruby-9.4i]: https://img.shields.io/badge/JRuby-9.4-FBE742?style=for-the-badge&logo=ruby&logoColor=red
[💎jruby-c-i]: https://img.shields.io/badge/JRuby-current-FBE742?style=for-the-badge&logo=ruby&logoColor=green
[💎jruby-headi]: https://img.shields.io/badge/JRuby-HEAD-FBE742?style=for-the-badge&logo=ruby&logoColor=blue
[🤝issues]: https://github.com/omniauth/omniauth-identity/issues
[🤝pulls]: https://github.com/omniauth/omniauth-identity/pulls
[🤝contributing]: CONTRIBUTING.md
[🔑codecov-g♻️]: https://codecov.io/gh/omniauth/omniauth-identity/graphs/tree.svg?token=cc6UdZCpAL
[🖐contrib-rocks]: https://contrib.rocks
[🖐contributors]: https://github.com/omniauth/omniauth-identity/graphs/contributors
[🖐contributors-img]: https://contrib.rocks/image?repo=omniauth/omniauth-identity
[🚎contributors-gl]: https://gitlab.com/omniauth/omniauth-identity/-/graphs/main
[🪇conduct]: CODE_OF_CONDUCT.md
[🪇conduct-img]: https://img.shields.io/badge/Contributor_Covenant-2.1-4baaaa.svg
[📌pvc]: http://guides.rubygems.org/patterns/#pessimistic-version-constraint
[📌semver]: https://semver.org/spec/v2.0.0.html
[📌semver-img]: https://img.shields.io/badge/semver-2.0.0-FFDD67.svg?style=flat
[📌semver-breaking]: https://github.com/semver/semver/issues/716#issuecomment-869336139
[📌major-versions-not-sacred]: https://tom.preston-werner.com/2022/05/23/major-version-numbers-are-not-sacred.html
[📌changelog]: CHANGELOG.md
[📗keep-changelog]: https://keepachangelog.com/en/1.0.0/
[📗keep-changelog-img]: https://img.shields.io/badge/keep--a--changelog-1.0.0-FFDD67.svg?style=flat
[📌gitmoji]:https://gitmoji.dev
[📌gitmoji-img]:https://img.shields.io/badge/gitmoji-%20😜%20😍-FFDD67.svg?style=flat-square
[🧮kloc]: https://www.youtube.com/watch?v=dQw4w9WgXcQ
[🧮kloc-img]: https://img.shields.io/badge/KLOC-0.073-FFDD67.svg?style=for-the-badge&logo=YouTube&logoColor=blue
[🔐security]: SECURITY.md
[🔐security-img]: https://img.shields.io/badge/security-policy-brightgreen.svg?style=flat
[📄copyright-notice-explainer]: https://opensource.stackexchange.com/questions/5778/why-do-licenses-such-as-the-mit-license-specify-a-single-year
[📄license]: LICENSE.txt
[📄license-ref]: https://opensource.org/licenses/MIT
[📄license-img]: https://img.shields.io/badge/License-MIT-green.svg
[📄ilo-declaration]: https://www.ilo.org/declaration/lang--en/index.htm
[📄ilo-declaration-img]: https://img.shields.io/badge/ILO_Fundamental_Principles-✓-brightgreen.svg?style=flat
[🚎yard-current]: http://rubydoc.info/gems/omniauth-identity
[🚎yard-head]: https://rubydoc.info/github/omniauth/omniauth-identity/main
[💎stone_checksums]: https://github.com/pboling/stone_checksums
[💎SHA_checksums]: https://gitlab.com/omniauth/omniauth-identity/-/tree/main/checksums
