package main

import (
	"flag"
	"fmt"
	"os"
	"strings"

	"github.com/skip2/go-qrcode"
)

func main() {
	var (
		text     = flag.String("text", "", "Text to encode in QR code (required)")
		output   = flag.String("output", "", "Output file path (optional, defaults to stdout for text or 'qrcode.png' for png)")
		format   = flag.String("format", "text", "Output format: text, png (default: text)")
		size     = flag.Int("size", 256, "Size of the QR code in pixels (for image formats)")
		recovery = flag.String("recovery", "M", "Error correction level: L, M, Q, H (default: M)")
	)
	flag.Parse()

	// Validate required text input
	if *text == "" {
		fmt.Fprintf(os.Stderr, "Error: --text flag is required\n")
		fmt.Fprintf(os.Stderr, "Usage: %s --text \"your text here\" [options]\n", os.Args[0])
		flag.Usage()
		os.Exit(1)
	}

	// Validate format
	*format = strings.ToLower(*format)
	if *format != "text" && *format != "png" {
		fmt.Fprintf(os.Stderr, "Error: format must be one of: text, png\n")
		os.Exit(1)
	}

	// Validate recovery level
	*recovery = strings.ToUpper(*recovery)
	if *recovery != "L" && *recovery != "M" && *recovery != "Q" && *recovery != "H" {
		fmt.Fprintf(os.Stderr, "Error: recovery level must be one of: L, M, Q, H\n")
		os.Exit(1)
	}

	// Convert recovery level to qrcode constant
	var recoveryLevel qrcode.RecoveryLevel
	switch *recovery {
	case "L":
		recoveryLevel = qrcode.Low
	case "M":
		recoveryLevel = qrcode.Medium
	case "Q":
		recoveryLevel = qrcode.High
	case "H":
		recoveryLevel = qrcode.Highest
	}

	// Generate QR code
	qr, err := qrcode.New(*text, recoveryLevel)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error generating QR code: %v\n", err)
		os.Exit(1)
	}

	// Handle different output formats
	switch *format {
	case "text":
		// Output as ASCII art to stdout
		if *output == "" {
			fmt.Print(qr.ToSmallString(false))
		} else {
			err := os.WriteFile(*output, []byte(qr.ToSmallString(false)), 0644)
			if err != nil {
				fmt.Fprintf(os.Stderr, "Error writing text file: %v\n", err)
				os.Exit(1)
			}
			fmt.Printf("QR code saved as text to: %s\n", *output)
		}

	case "png":
		// Generate PNG image
		if *output == "" {
			*output = "qrcode.png"
		}

		// Create PNG data
		pngData, err := qr.PNG(*size)
		if err != nil {
			fmt.Fprintf(os.Stderr, "Error generating PNG: %v\n", err)
			os.Exit(1)
		}

		// Write PNG file
		err = os.WriteFile(*output, pngData, 0644)
		if err != nil {
			fmt.Fprintf(os.Stderr, "Error writing PNG file: %v\n", err)
			os.Exit(1)
		}
		fmt.Printf("QR code saved as PNG to: %s\n", *output)

	}
}
