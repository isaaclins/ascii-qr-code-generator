#!/bin/bash

# QR Code Generator Test Script
# This script demonstrates various usage examples

echo "🧪 Testing QR Code Generator..."
echo ""

# Test 1: Basic text output (default)
echo "Test 1: ASCII QR code in terminal (default behavior)"
echo "Command: ./qr-gen --text \"Hello World!\""
echo "Output:"
./qr-gen --text "Hello World!"
echo ""
echo "----------------------------------------"
echo ""

# Test 2: PNG generation
echo "Test 2: PNG generation"
echo "Command: ./qr-gen --text \"https://github.com\" --format png --output test-github.png"
./qr-gen --text "https://github.com" --format png --output test-github.png
echo ""

# Test 3: Large QR code
echo "Test 3: Large QR code"
echo "Command: ./qr-gen --text \"Large QR Code Test\" --format png --size 400 --output test-large.png"
./qr-gen --text "Large QR Code Test" --format png --size 400 --output test-large.png
echo ""

# Test 4: High error correction
echo "Test 4: High error correction"
echo "Command: ./qr-gen --text \"Secure Data\" --format png --recovery H --output test-secure.png"
./qr-gen --text "Secure Data" --format png --recovery H --output test-secure.png
echo ""

# Test 5: WiFi QR code
echo "Test 5: WiFi QR code"
echo "Command: ./qr-gen --text \"WIFI:T:WPA;S:TestNetwork;P:password123;;\" --format png --output test-wifi.png"
./qr-gen --text "WIFI:T:WPA;S:TestNetwork;P:password123;;" --format png --output test-wifi.png
echo ""

# Test 6: Special characters
echo "Test 6: Special characters"
echo "Command: ./qr-gen --text \"Special chars: @#$%^&*()\""
echo "Output:"
./qr-gen --text "Special chars: @#$%^&*()"
echo ""

echo "✅ All tests completed!"
echo ""
echo "Generated files:"
ls -la test-*.png 2>/dev/null || echo "No PNG files generated"
echo ""
echo "You can now test the QR codes by:"
echo "1. Opening the PNG files with any image viewer"
echo "2. Scanning them with a QR code scanner app"
echo "3. Verifying the content matches the input text"
