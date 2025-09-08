#!/bin/bash

# GitHub Actions Workflow Status Checker
# This script checks the status of GitHub Actions workflows

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔍 GitHub Actions Workflow Status Checker${NC}"
echo ""

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo -e "${RED}❌ Error: Not in a git repository${NC}"
    exit 1
fi

# Get repository information
REPO_URL=$(git config --get remote.origin.url)
if [[ $REPO_URL =~ github\.com[:/]([^/]+)/([^/]+) ]]; then
    OWNER="${BASH_REMATCH[1]}"
    REPO="${BASH_REMATCH[2]%.git}"
else
    echo -e "${RED}❌ Error: Could not determine GitHub repository${NC}"
    exit 1
fi

echo -e "${BLUE}Repository: ${OWNER}/${REPO}${NC}"
echo ""

# Check if GitHub CLI is available
if command -v gh &> /dev/null; then
    echo -e "${GREEN}✅ GitHub CLI found${NC}"
    
    # Check authentication
    if gh auth status &> /dev/null; then
        echo -e "${GREEN}✅ GitHub CLI authenticated${NC}"
        echo ""
        
        # Get workflow runs
        echo -e "${BLUE}📊 Recent Workflow Runs:${NC}"
        gh run list --limit 10 --json status,conclusion,name,createdAt,url | jq -r '.[] | "\(.name) - \(.status) (\(.conclusion // "in_progress")) - \(.createdAt)"'
        echo ""
        
        # Get specific workflow status
        echo -e "${BLUE}🧪 Test Workflow Status:${NC}"
        TEST_RUNS=$(gh run list --workflow=test.yml --limit 1 --json status,conclusion,createdAt)
        if [ "$TEST_RUNS" != "[]" ]; then
            echo "$TEST_RUNS" | jq -r '.[] | "Status: \(.status), Conclusion: \(.conclusion // "in_progress"), Created: \(.createdAt)"'
        else
            echo -e "${YELLOW}⚠️  No test workflow runs found${NC}"
        fi
        echo ""
        
        echo -e "${BLUE}🚀 Release Workflow Status:${NC}"
        RELEASE_RUNS=$(gh run list --workflow=release.yml --limit 1 --json status,conclusion,createdAt)
        if [ "$RELEASE_RUNS" != "[]" ]; then
            echo "$RELEASE_RUNS" | jq -r '.[] | "Status: \(.status), Conclusion: \(.conclusion // "in_progress"), Created: \(.createdAt)"'
        else
            echo -e "${YELLOW}⚠️  No release workflow runs found${NC}"
        fi
        echo ""
        
        # Get latest release
        echo -e "${BLUE}📦 Latest Release:${NC}"
        LATEST_RELEASE=$(gh release view --json tagName,createdAt,url)
        if [ "$LATEST_RELEASE" != "null" ]; then
            echo "$LATEST_RELEASE" | jq -r '"Tag: \(.tagName), Created: \(.createdAt), URL: \(.url)"'
        else
            echo -e "${YELLOW}⚠️  No releases found${NC}"
        fi
        
    else
        echo -e "${YELLOW}⚠️  GitHub CLI not authenticated${NC}"
        echo "Run 'gh auth login' to authenticate"
    fi
else
    echo -e "${YELLOW}⚠️  GitHub CLI not found${NC}"
    echo "Install GitHub CLI for detailed workflow status"
    echo "Visit: https://cli.github.com/"
    echo ""
    echo -e "${BLUE}Manual check:${NC}"
    echo "https://github.com/${OWNER}/${REPO}/actions"
fi

echo ""
echo -e "${BLUE}🔗 Quick Links:${NC}"
echo "• Workflows: https://github.com/${OWNER}/${REPO}/actions"
echo "• Releases: https://github.com/${OWNER}/${REPO}/releases"
echo "• Issues: https://github.com/${OWNER}/${REPO}/issues"
echo "• Pull Requests: https://github.com/${OWNER}/${REPO}/pulls"
