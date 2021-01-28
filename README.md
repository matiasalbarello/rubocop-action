# GitHub Actions Template in Ruby

This template can be used for easy start creating a GitHub Action with Ruby.
It has a basic setup using Docker.

The input parameters can be configured on the `action.yml` file. They are used to configure the MainAppService through ActiveSupport Configurable module.

## Testing
The project includes a `spec` directory with basic settings for RSpec but there's also a sample github workflow in the `.github/workflows` directory, which can be used for "self" e2e testing.
