# Contributing to QR Code Generator

Thank you for your interest in contributing to QR Code Generator! This document provides guidelines for contributing to the project.

## How to Contribute

### Reporting Issues

1. Check if the issue already exists in the [Issues](https://github.com/isaaclins/qr-code-gen-bash/issues) section
2. Use the bug report template when creating a new issue
3. Provide as much detail as possible including:
   - OS and architecture
   - Version of the binary
   - Steps to reproduce
   - Expected vs actual behavior

### Suggesting Features

1. Check if the feature has already been requested
2. Use the feature request template
3. Describe the use case and potential implementation

### Code Contributions

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Make your changes
4. Run tests: `./test.sh`
5. Commit your changes: `git commit -m 'Add amazing feature'`
6. Push to the branch: `git push origin feature/amazing-feature`
7. Open a Pull Request

## Development Setup

### Prerequisites

- Go 1.21 or later
- Git

### Local Development

1. Clone the repository:

   ```bash
   git clone https://github.com/isaaclins/qr-code-gen-bash.git
   cd qr-code-gen-bash
   ```

2. Install dependencies:

   ```bash
   go mod tidy
   ```

3. Run tests:

   ```bash
   ./test.sh
   ```

4. Build the binary:
   ```bash
   go build -o qr-gen main.go
   ```

### Testing

Before submitting a PR, ensure:

- [ ] All tests pass: `./test.sh`
- [ ] Code builds successfully on your platform
- [ ] Cross-platform builds work: `./build.sh`
- [ ] No new warnings or errors
- [ ] Code follows Go conventions

### Code Style

- Follow standard Go formatting: `go fmt`
- Use meaningful variable and function names
- Add comments for public functions
- Keep functions focused and small
- Handle errors appropriately

## Release Process

Releases are created automatically when:

1. A git tag is pushed (e.g., `v1.0.0`)
2. The release workflow is triggered manually

### Creating a Release

Use the provided script:

```bash
./scripts/create-release.sh
```

Or manually:

1. Update version information
2. Create and push a tag: `git tag -a v1.0.0 -m "Release v1.0.0"`
3. Push the tag: `git push origin v1.0.0`

## Project Structure

```
qr-code-gen-bash/
├── .github/
│   ├── workflows/          # GitHub Actions workflows
│   └── ISSUE_TEMPLATE/     # Issue templates
├── scripts/
│   └── create-release.sh   # Release script
├── main.go                 # Main application code
├── go.mod                  # Go module definition
├── build.sh               # Build script
├── test.sh                # Test script
└── README.md              # Project documentation
```

## Questions?

If you have questions about contributing, please:

1. Check the [Issues](https://github.com/isaaclins/qr-code-gen-bash/issues) section
2. Create a new issue with the "question" label
3. Join the discussions in existing issues

## Thank You!

Your contributions help make QR Code Generator better for everyone. We appreciate your time and effort!
