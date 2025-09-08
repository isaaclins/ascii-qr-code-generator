# QR Code Generator Makefile

.PHONY: help build test clean release install uninstall

# Default target
help:
	@echo "QR Code Generator - Available targets:"
	@echo ""
	@echo "  build     - Build the binary for current platform"
	@echo "  build-all - Build binaries for all platforms"
	@echo "  test      - Run all tests"
	@echo "  clean     - Clean build artifacts"
	@echo "  release   - Create a new release"
	@echo "  install   - Install binary to /usr/local/bin"
	@echo "  uninstall - Remove binary from /usr/local/bin"
	@echo "  check     - Check workflow status"
	@echo ""

# Build for current platform
build:
	@echo "🔨 Building QR Code Generator..."
	go build -ldflags="-s -w" -o qr-gen main.go
	@echo "✅ Build complete: qr-gen"

# Build for all platforms
build-all:
	@echo "🔨 Building for all platforms..."
	@./build.sh
	@echo "✅ Cross-platform build complete"

# Run tests
test:
	@echo "🧪 Running tests..."
	@./test.sh
	@echo "✅ Tests completed"

# Clean build artifacts
clean:
	@echo "🧹 Cleaning build artifacts..."
	@rm -f qr-gen qr-gen-* test-*.png test-*.txt
	@rm -rf build/
	@echo "✅ Cleanup complete"

# Create a new release
release:
	@echo "🚀 Creating release..."
	@./scripts/create-release.sh

# Install binary
install: build
	@echo "📦 Installing QR Code Generator..."
	@sudo cp qr-gen /usr/local/bin/
	@echo "✅ Installed to /usr/local/bin/qr-gen"

# Uninstall binary
uninstall:
	@echo "🗑️  Uninstalling QR Code Generator..."
	@sudo rm -f /usr/local/bin/qr-gen
	@echo "✅ Uninstalled from /usr/local/bin/qr-gen"

# Check workflow status
check:
	@echo "🔍 Checking workflow status..."
	@./scripts/check-workflows.sh

# Development setup
dev-setup:
	@echo "🛠️  Setting up development environment..."
	@go mod tidy
	@chmod +x *.sh scripts/*.sh
	@echo "✅ Development environment ready"

# Quick test
quick-test:
	@echo "⚡ Running quick test..."
	@go run main.go --text "Quick test" --format text
	@echo "✅ Quick test passed"
