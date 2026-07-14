# Contributing to puppet-stunnel

First off, thank you for considering contributing to this project!

## Code of Conduct

By participating in this project, you agree to abide by the [Code of Conduct](CODE_OF_CONDUCT.md) and professional engineering standards.

## Branching Strategy (Trunk-Based Development)

This repository uses **Trunk-Based Development**.

### Primary Branch

- **`main`**: The single source of truth. All feature branches and bugfixes merge directly here.

### Workflow

1. Fork the repository.
2. Create a new branch from `main` (`feature/my-feature` or `bugfix/my-fix`).
3. Make your changes.
4. Run validation and tests locally.
5. Open a Pull Request targeting `main`.

## Testing

This project uses standard open-source Ruby tooling and community Vox Pupuli standards for testing and validation.

Before opening a pull request, please ensure you validate your code. You can test locally using **Jig** (the community PDK replacement) or standard `rake` tasks:

**Using Jig:**

```bash
jig validate
jig test unit
```

**Using native Bundler & Rake:**

```bash
bundle install
bundle exec rake validate
bundle exec rake spec
```

Ensure that all syntax checks, rubocop rules, and unit tests pass successfully.
