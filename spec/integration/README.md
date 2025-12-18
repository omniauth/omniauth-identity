# Integration Tests

This directory contains integration tests that verify omniauth-identity works correctly within actual web application frameworks.

## Structure

- `spec/integration/*_spec.rb` - Integration test specs
- `spec/dummies/` - Minimal dummy Sinatra, Roda, and Hanami applications for testing
- `spec/internal/` - Minimal dummy Rails application for testing

## Frameworks Tested

1. **Sinatra + Sequel** - Minimal framework with lightweight ORM
2. **Roda + ROM** - Modern minimal stack with Ruby Object Mapper
3. **Hanami + ROM** - Full-featured modern framework with Ruby Object Mapper
4. **Rails + ActiveRecord** (via Combustion) - Want to build a blog in 15 minutes?

## Running Tests

All integration tests run exclusively on the current Ruby release, which is v3.4 as of November 2025.

```bash
# Run all integration tests
bundle exec rspec spec/integration

# Run specific framework
bundle exec rspec spec/integration/sinatra_spec.rb
bundle exec rspec spec/integration/roda_spec.rb
bundle exec rspec spec/integration/hanami_spec.rb
bundle exec rspec spec/integration/rails_spec.rb

# Run with specific appraisal
bundle exec appraisal rom-r3 rspec spec/integration/roda_spec.rb
bundle exec appraisal rom-r3 rspec spec/integration/hanami_spec.rb
bundle exec appraisal ar-7-2 rspec spec/integration/rails_spec.rb
bundle exec appraisal ar-8-0 rspec spec/integration/rails_spec.rb
```

## Framework-Specific Notes

### Roda + ROM

**Requirements**: latest version of Ruby, ROM 5.x, ROM-SQL 3.x

The Roda integration demonstrates:
- ROM's data mapper pattern (vs. ActiveRecord's active record pattern)
- Roda's plugin-based architecture
- In-memory SQLite database for testing
- ROM relations and repositories

**Files**:
- `spec/integration/roda_spec.rb` - Integration tests
- `spec/dummies/roda_app/app.rb` - Roda application
- `spec/dummies/roda_app/models/roda_identity.rb` - ROM-based identity model

Automatically skips tests on older-than-current ruby.

### Hanami + ROM

**Requirements**: latest version of Ruby, ROM 5.x, Hanami 2.x

The Hanami integration demonstrates:
- Full-featured modern Ruby framework
- ROM as native data layer
- Clean architecture patterns
- In-memory SQLite database for testing

**Files**:
- `spec/integration/hanami_spec.rb` - Integration tests
- `spec/dummies/hanami_app/app.rb` - Hanami application (Rack-based for simplicity)
- `spec/dummies/hanami_app/models/hanami_identity.rb` - ROM-based identity model

Automatically skips tests on older-than-current ruby.

### Rails + ActiveRecord

**Requirements**: latest version of Ruby, Rails 7.2+

The Rails integration demonstrates:
- Most common production use case
- ActiveRecord ORM (Rails default)
- Combustion for minimal Rails setup
- In-memory SQLite database for testing
- has_secure_password integration

**Files**:
- `spec/integration/rails_spec.rb` - Integration tests
- `spec/internal/` - Combustion Rails app structure
  - `config/routes.rb` - Rails routes
  - `config/database.yml` - Database configuration
  - `db/schema.rb` - Database schema
  - `app/models/user.rb` - ActiveRecord User model
  - `app/controllers/sessions_controller.rb` - Auth callbacks
- `spec/support/combustion_helper.rb` - Combustion initialization

Combustion automatically adapts to the Rails version being tested.
Integration tests run against Rails 7.2, 8.0, and 8.1.

## Notes

- Integration gemfile uses `require: false` to prevent auto-loading
- Each test will explicitly require only the framework it needs

