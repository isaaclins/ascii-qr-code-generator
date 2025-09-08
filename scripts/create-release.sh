#!/bin/bash

# QR Code Generator Release Script
# This script helps create a new release by creating a git tag

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 QR Code Generator Release Script${NC}"
echo ""

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo -e "${RED}❌ Error: Not in a git repository${NC}"
    exit 1
fi

# Check if there are uncommitted changes
if ! git diff-index --quiet HEAD --; then
    echo -e "${YELLOW}⚠️  Warning: You have uncommitted changes${NC}"
    echo "Please commit or stash your changes before creating a release."
    read -p "Do you want to continue anyway? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Release cancelled."
        exit 1
    fi
fi

# Get current version from git tags
CURRENT_VERSION=$(git describe --tags --abbrev=0 2>/dev/null || echo "v0.0.0")
echo -e "${BLUE}Current version: ${CURRENT_VERSION}${NC}"

# Parse version number
VERSION_NUMBER=${CURRENT_VERSION#v}
MAJOR=$(echo $VERSION_NUMBER | cut -d. -f1)
MINOR=$(echo $VERSION_NUMBER | cut -d. -f2)
PATCH=$(echo $VERSION_NUMBER | cut -d. -f3)

# Ask for version bump type
echo ""
echo "What type of release do you want to create?"
echo "1) Patch (${MAJOR}.${MINOR}.$((PATCH + 1))) - Bug fixes"
echo "2) Minor (${MAJOR}.$((MINOR + 1)).0) - New features"
echo "3) Major ($((MAJOR + 1)).0.0) - Breaking changes"
echo "4) Custom version"
echo ""
read -p "Choose option (1-4): " -n 1 -r
echo

case $REPLY in
    1)
        NEW_VERSION="v${MAJOR}.${MINOR}.$((PATCH + 1))"
        ;;
    2)
        NEW_VERSION="v${MAJOR}.$((MINOR + 1)).0"
        ;;
    3)
        NEW_VERSION="v$((MAJOR + 1)).0.0"
        ;;
    4)
        read -p "Enter custom version (e.g., v1.2.3): " NEW_VERSION
        if [[ ! $NEW_VERSION =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
            echo -e "${RED}❌ Error: Invalid version format. Use v1.2.3 format${NC}"
            exit 1
        fi
        ;;
    *)
        echo -e "${RED}❌ Error: Invalid option${NC}"
        exit 1
        ;;
esac

echo ""
echo -e "${BLUE}Creating release: ${NEW_VERSION}${NC}"

# Update version in files if needed
echo "Updating version information..."

# Create a simple version file
echo "$NEW_VERSION" > VERSION

# Update README if it has version references
if grep -q "Version:" README.md; then
    sed -i.bak "s/Version:.*/Version: ${NEW_VERSION}/" README.md
    rm README.md.bak
fi

# Commit version changes
git add VERSION README.md
git commit -m "Bump version to ${NEW_VERSION}" || echo "No changes to commit"

# Create and push tag
echo "Creating git tag..."
git tag -a "${NEW_VERSION}" -m "Release ${NEW_VERSION}

## QR Code Generator ${NEW_VERSION}

### Features
- 🚀 Single executable - No dependencies required
- 📱 Multiple formats - Text (ASCII art) and PNG image output
- ⚙️ Customizable - Adjustable size, error correction level, and output options
- 🌍 Cross-platform - Works on macOS, Linux, and Windows
- 🎯 Simple CLI - Easy-to-use command-line interface

### Quick Start
\`\`\`bash
# Make executable (Unix systems)
chmod +x qr-gen-*

# Generate ASCII QR code (default)
./qr-gen-* --text \"Hello World!\"

# Generate PNG image
./qr-gen-* --text \"Hello World!\" --format png
\`\`\`

### Downloads
Choose the binary for your platform and verify using the SHA256 checksums."

echo "Pushing tag to remote..."
git push origin "${NEW_VERSION}"

echo ""
echo -e "${GREEN}✅ Release ${NEW_VERSION} created successfully!${NC}"
echo ""
echo "The GitHub Actions workflow will now:"
echo "1. 🧪 Run comprehensive tests"
echo "2. 🔨 Build binaries for all platforms"
echo "3. 📦 Create a GitHub release with downloadable binaries"
echo ""
echo "You can monitor the progress at:"
echo -e "${BLUE}https://github.com/$(git config --get remote.origin.url | sed 's/.*github.com[:/]\([^.]*\).*/\1/')/actions${NC}"
echo ""
echo -e "${YELLOW}Note: The release will be available once the GitHub Actions workflow completes.${NC}"
