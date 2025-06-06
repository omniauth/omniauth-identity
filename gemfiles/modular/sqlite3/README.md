Read as a blog post here: https://dev.to/galtzo/activerecord-sqlite3-compatibility-matrix-58id

This matrix covers the versions of Rails / ActiveRecord against the versions of the sqlite3 RubyGem.

Other posts in my Compatibility Matrix Series
- [RRRRb Matrix (Ruby, RubyGems, RuboCop, Rails, Bundler)][rrrrb]

[rrrrb]: https://dev.to/galtzo/matrix-ruby-gem-bundler-etc-4kk7

| Rails / ActiveRecord | Min sqlite3 gem      | Source Gemfile @ Tag                                            |
|----------------------|----------------------|-----------------------------------------------------------------|
| 5.2.x                | `~> 1.3.6`           | [v5.2.0](https://github.com/rails/rails/blob/v5.2.0/Gemfile)    |
| 6.0.x                | `~> 1.4`             | [v6.0.0](https://github.com/rails/rails/blob/v6.0.0/Gemfile)    |
| 6.1.x                | `~> 1.4`             | [v6.1.0](https://github.com/rails/rails/blob/v6.1.0/Gemfile)    |
| 7.0.x                | `~> 1.4`             | [v7.0.0](https://github.com/rails/rails/blob/v7.0.0/Gemfile)    |
| 7.1.x                | `~> 1.6`, `>= 1.6.6` | [v7.1.0](https://github.com/rails/rails/blob/v7.1.0/Gemfile)    |
| 7.2.x                | `>= 1.6.6`           | [v7.2.0](https://github.com/rails/rails/blob/v7.2.0/Gemfile)    |
| 8.0.x                | `>= 2.1`             | [v8.0.0](https://github.com/rails/rails/blob/v8.0.0/Gemfile)    |
| main/edge (2025)     | `>= 2.1`             | [main branch](https://github.com/rails/rails/blob/main/Gemfile) |

**Notes:**
- For all versions above, constraints are for: `platforms :ruby, :mswin, :mswin64, :mingw, :x64_mingw` or `:windows`.
- For the `:jruby` platform, use `activerecord-jdbcsqlite3-adapter` (not shown, yet; watch this space).
- These constraints are derived from the `Gemfile` line for the `sqlite3` dependency at the specified tags.  Since `sqlite3` isn't a runtime dependency in the `gemspec`, this is the most effective way to determine the constraint.

**References:**
- [Rails Gemfile at v5.2.0](https://github.com/rails/rails/blob/v5.2.0/Gemfile) (`gem "sqlite3", "~> 1.3.6"`)
- [Rails Gemfile at v6.0.0](https://github.com/rails/rails/blob/v6.0.0/Gemfile) (`gem "sqlite3", "~> 1.4"`)
- [Rails Gemfile at v6.1.0](https://github.com/rails/rails/blob/v6.1.0/Gemfile) (`gem "sqlite3", "~> 1.4"`)
- [Rails Gemfile at v7.0.0](https://github.com/rails/rails/blob/v7.0.0/Gemfile) (`gem "sqlite3", "~> 1.4"`)
- [Rails Gemfile at v7.1.0](https://github.com/rails/rails/blob/v7.1.0/Gemfile) (`gem "sqlite3", "~> 1.6", ">= 1.6.6"`)
- [Rails Gemfile at v7.2.0](https://github.com/rails/rails/blob/v7.2.0/Gemfile) (`gem "sqlite3", ">= 1.6.6"`)
- [Rails Gemfile at v8.0.0](https://github.com/rails/rails/blob/v8.0.0/Gemfile) (`gem "sqlite3", ">= 2.1"`)
- [Main branch Gemfile](https://github.com/rails/rails/blob/main/Gemfile) (`gem "sqlite3", ">= 2.1"`)
