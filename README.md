# OmniAuth Identity

[![Version](https://img.shields.io/gem/v/omniauth-identity.svg)](https://rubygems.org/gems/omniauth-identity)
[![Depfu](https://badges.depfu.com/badges/6c9b45362951b872127f9e46d39bed76/count.svg)](https://depfu.com/github/omniauth/omniauth-identity?project_id=22381)
[![Build Status](https://img.shields.io/endpoint.svg?url=https%3A%2F%2Factions-badge.atrox.dev%2Fomniauth%2Fomniauth-identity%2Fbadge&style=flat)](https://actions-badge.atrox.dev/omniauth/omniauth-identity/goto)
[![Maintainability](https://api.codeclimate.com/v1/badges/621d6211cb2e0959ce00/maintainability)](https://codeclimate.com/github/omniauth/omniauth-identity/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/621d6211cb2e0959ce00/test_coverage)](https://codeclimate.com/github/omniauth/omniauth-identity/test_coverage)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![Open Source Helpers](https://www.codetriage.com/omniauth/omniauth-identity/badges/users.svg)](https://www.codetriage.com/omniauth/omniauth-identity)
[![Downloads Rank](https://img.shields.io/gem/rd/omniauth-identity.svg)](https://rubygems.org/gems/omniauth-identity)

The OmniAuth Identity gem provides a way for applications to utilize a
traditional username/password based authentication system without the need
to give up the simple authentication flow provided by OmniAuth. Identity
is designed on purpose to be as featureless as possible: it provides the
basic construct for user management and then gets out of the way.

## Compatibility

This gem is compatible with, as of Feb 2021, version 3:

* Latest released version of omniauth, v2.0.2
* Ruby 2.4, 2.5, 2.6, 2.7, 3.0, ruby-head

## Installation

To acquire the latest release from RubyGems add the following to your `Gemfile`:

```ruby
gem 'omniauth-identity'
```

If the git repository has new commits not yet in an official release, simply specify the repo instead:

```ruby
gem 'omniauth-identity', git: 'https://github.com/intridea/omniauth-identity.git'
```

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
class SequelTestIdentity < Sequel::Model
  include OmniAuth::Identity::Models::Sequel
  auth_key :email
  # whatever else you want!
end
```


### Mongoid

Include the `OmniAuth::Identity::Models::Mongoid` mixin and specify
fields that you will need.

```ruby
class Identity
  include Mongoid::Document
  include OmniAuth::Identity::Models::Mongoid

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
  include CouchPotato::Persistence
  include OmniAuth::Identity::Models::CouchPotatoModule

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
  include NoBrainer::Document
  include OmniAuth::Identity::Models::NoBrainer

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
           locate_conditions: ->(req) { { model.auth_key => req['auth_key'] } }
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
option :locate_conditions, ->(req) { { model.auth_key => req['auth_key'] } }
```

Please contribute some documentation if you have the gumption!  The maintainer's time is limited, and sometimes the authors of PRs with new options don't update the _this_ readme. 😭

## License

MIT License. See LICENSE for details.

## Copyright

* Copyright (c) 2021 OmniAuth-Identity Maintainers
* Copyright (c) 2020 Peter Boling, Andrew Roberts, and Jellybooks Ltd.
* Copyright (c) 2010-2015 Michael Bleigh, and Intridea, Inc.
