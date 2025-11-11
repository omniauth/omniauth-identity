# Integration Tests

This directory contains integration tests that verify omniauth-identity works correctly within actual web application frameworks.

## Structure

- `spec/integration/*_spec.rb` - Integration test specs
- `spec/dummies/` - Minimal dummy applications for testing

## Frameworks Tested

1. **Sinatra + Sequel** - Minimal framework with lightweight ORM
2. **Roda + ROM** - Modern minimal stack
3. **Hanami + ROM-SQL** - Full-featured modern framework
4. **Rails + ActiveRecord** (via Combustion) - Most common use case

## Running Tests

```bash
# Run all integration tests
bundle exec rspec spec/integration

# Run specific framework
bundle exec rspec spec/integration/sinatra_spec.rb

# Run with specific appraisal
bundle exec appraisal ar-7-1-r3 rspec spec/integration/rails_spec.rb
```

## Notes

- Integration gemfile uses `require: false` to prevent auto-loading
- Each test will explicitly require only the framework it needs
- Combustion setup (Rails) is deferred to later phases

