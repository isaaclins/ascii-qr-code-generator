#!/bin/bash

# QR Code Generator Build Script
# This script builds the QR code generator for multiple platforms

set -e

echo "🔧 Building QR Code Generator..."

# Create build directory
mkdir -p build

# Build for current platform (macOS)
echo "📱 Building for macOS (current platform)..."
go build -ldflags="-s -w" -o build/qr-gen-macos main.go

# Build for Linux
echo "🐧 Building for Linux..."
GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o build/qr-gen-linux main.go

# Build for Windows
echo "🪟 Building for Windows..."
GOOS=windows GOARCH=amd64 go build -ldflags="-s -w" -o build/qr-gen-windows.exe main.go

# Make the current platform binary executable and copy it to root
echo "✅ Making executable..."
chmod +x build/qr-gen-macos
cp build/qr-gen-macos qr-gen

echo "🎉 Build complete!"
echo ""
echo "Available binaries:"
echo "  - qr-gen (current platform)"
echo "  - build/qr-gen-macos"
echo "  - build/qr-gen-linux"
echo "  - build/qr-gen-windows.exe"
echo ""
echo "Usage: ./qr-gen -text \"Hello World\""
