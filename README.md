# QR Code Generator

A single executable binary that generates QR codes from strings. Built with Go for cross-platform compatibility.

## Features

- 🚀 **Single executable** - No dependencies required
- 📱 **Multiple formats** - Text (ASCII art) and PNG image output
- ⚙️ **Customizable** - Adjustable size, error correction level, and output options
- 🌍 **Cross-platform** - Works on macOS, Linux, and Windows
- 🎯 **Simple CLI** - Easy-to-use command-line interface

## Quick Start

### Build the executable

```bash
# Make the build script executable and run it
chmod +x build.sh
./build.sh
```

This creates:

- `qr-gen` - Executable for your current platform
- `build/qr-gen-macos` - macOS binary
- `build/qr-gen-linux` - Linux binary
- `build/qr-gen-windows.exe` - Windows binary

### Basic Usage

```bash
# Generate QR code as ASCII art in terminal (default)
./qr-gen --text "Hello World!"

# Generate QR code as PNG image
./qr-gen --text "Hello World!" --format png

# Generate with custom size and output file
./qr-gen --text "https://github.com" --format png --size 512 --output my-qr.png
```

## Command Line Options

| Flag        | Description                                | Default                | Example               |
| ----------- | ------------------------------------------ | ---------------------- | --------------------- |
| `--text`    | Text to encode in QR code (required)       | -                      | `--text "Hello World"` |
| `-format`   | Output format: `text`, `png`               | `text`                 | `-format png`         |
| `-output`   | Output file path                           | `qrcode.png` or stdout | `-output my-qr.png`   |
| `-size`     | Size in pixels (for image formats)         | `256`                  | `-size 512`           |
| `-recovery` | Error correction level: `L`, `M`, `Q`, `H` | `M`                    | `-recovery H`         |

## Examples

### Generate ASCII QR code in terminal (default)

```bash
./qr-gen --text "Scan me!"
```

### Generate PNG with high error correction

```bash
./qr-gen --text "Important data" --format png --recovery H --size 400 --output secure-qr.png
```

### Generate QR code for URL

```bash
./qr-gen --text "https://example.com" --format png --output website-qr.png
```

### Generate QR code for WiFi credentials

```bash
./qr-gen --text "WIFI:T:WPA;S:MyNetwork;P:password123;;" --format png --output wifi-qr.png
```

## Error Correction Levels

- **L (Low)** - ~7% error correction, smallest size
- **M (Medium)** - ~15% error correction, balanced (default)
- **Q (Quartile)** - ~25% error correction, larger size
- **H (Highest)** - ~30% error correction, largest size

## Building from Source

### Prerequisites

- Go 1.21 or later

### Build Steps

```bash
# Download dependencies
go mod tidy

# Build for current platform
go build -o qr-gen main.go

# Or use the build script for all platforms
./build.sh
```

## File Structure

```
qr-code-gen-bash/
├── main.go          # Main application code
├── go.mod           # Go module definition
├── build.sh         # Cross-platform build script
├── qr-gen           # Executable binary (after build)
├── build/           # Cross-platform binaries
│   ├── qr-gen-macos
│   ├── qr-gen-linux
│   └── qr-gen-windows.exe
└── README.md        # This file
```

## License

This project is open source and available under the MIT License.
