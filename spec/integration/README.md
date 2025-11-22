# Integration Tests

This directory contains integration tests that verify omniauth-identity works correctly within actual web application frameworks.

## Structure

- `spec/integration/*_spec.rb` - Integration test specs
- `spec/dummies/` - Minimal dummy applications for testing

## Frameworks Tested

1. **Sinatra + Sequel** - Minimal framework with lightweight ORM
2. **Roda + ROM** - Modern minimal stack with Ruby Object Mapper
3. **Hanami + ROM-SQL** - Full-featured modern framework
4. **Rails + ActiveRecord** (via Combustion) - Most common use case

## Running Tests

```bash
# Run all integration tests
bundle exec rspec spec/integration

# Run specific framework
bundle exec rspec spec/integration/sinatra_spec.rb
bundle exec rspec spec/integration/roda_spec.rb  # Ruby 3.1+ only

# Run with specific appraisal
bundle exec appraisal rom-r3 rspec spec/integration/roda_spec.rb
bundle exec appraisal ar-7-1-r3 rspec spec/integration/rails_spec.rb
```

## Framework-Specific Notes

### Roda + ROM

**Requirements**: Ruby 3.1+ (ROM 5.x / ROM-SQL 3.x requirement)

The Roda integration demonstrates:
- ROM's data mapper pattern (vs. ActiveRecord's active record pattern)
- Roda's plugin-based architecture
- In-memory SQLite database for testing
- ROM relations and repositories

**Files**:
- `spec/integration/roda_spec.rb` - Integration tests
- `spec/dummies/roda_app/app.rb` - Roda application
- `spec/dummies/roda_app/models/identity.rb` - ROM-based identity model

The tests will be skipped automatically on Ruby < 3.1.

## Notes

- Integration gemfile uses `require: false` to prevent auto-loading
- Each test will explicitly require only the framework it needs
- Combustion setup (Rails) is deferred to later phases

