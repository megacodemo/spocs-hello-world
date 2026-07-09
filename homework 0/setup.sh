#!/bin/bash
# setup.sh — one-time setup script for the AI Resume Agent
#
# Run this script once after cloning the repo:
#     bash setup.sh
#
# What it does:
#   1. Checks that Python 3 is installed
#   2. Creates a Python virtual environment (venv)
#   3. Installs all required packages
#   4. Creates your .env file from the template (if it doesn't exist yet)
#
# After running this script, you still need to:
#   - Add your OpenRouter API key to .env
#   - Run: source venv/bin/activate && python app.py

set -e   # stop immediately if any command fails

echo ""
echo "========================================"
echo "  AI Resume Agent — Setup"
echo "========================================"
echo ""

# ----------------------------------------------------------------
# STEP 1: Check Python version
# ----------------------------------------------------------------
echo "Step 1: Checking Python version..."

if ! command -v python3 &> /dev/null; then
    echo ""
    echo "ERROR: Python 3 is not installed or not on your PATH."
    echo "Please install Python 3 from https://www.python.org/downloads/"
    exit 1
fi

PYTHON_VERSION=$(python3 --version)
echo "  Found: $PYTHON_VERSION"

# ----------------------------------------------------------------
# STEP 2: Create virtual environment
# ----------------------------------------------------------------
echo ""
echo "Step 2: Creating virtual environment (venv)..."

# A virtual environment is an isolated Python installation just for this project.
# It keeps this project's packages separate from other Python projects on your machine.
if [ -d "venv" ]; then
    echo "  venv/ already exists — skipping creation."
else
    python3 -m venv venv
    echo "  Created venv/"
fi

# ----------------------------------------------------------------
# STEP 3: Install dependencies
# ----------------------------------------------------------------
echo ""
echo "Step 3: Installing packages from requirements.txt..."

# Activate the venv so pip installs into it (not into your system Python)
source venv/bin/activate
pip install --quiet --upgrade pip
pip install --quiet -r requirements.txt

echo "  All packages installed."

# ----------------------------------------------------------------
# STEP 4: Create .env file
# ----------------------------------------------------------------
echo ""
echo "Step 4: Setting up .env file..."

if [ -f ".env" ]; then
    echo "  .env already exists — skipping."
else
    cp .env.example .env
    echo "  Created .env from .env.example"
    echo ""
    echo "  *** ACTION REQUIRED ***"
    echo "  Open .env and replace 'paste-your-key-here' with your OpenRouter API key."
    echo ""
fi

# ----------------------------------------------------------------
# DONE
# ----------------------------------------------------------------
echo "========================================"
echo "  Setup complete!"
echo "========================================"
echo ""
echo "Next steps:"
echo "  1. If you haven't already, add your OpenRouter API key to .env"
echo "  2. Activate the virtual environment:"
echo "       source venv/bin/activate"
echo "  3. Start the app:"
echo "       python app.py"
echo "  4. Open your browser to: http://localhost:8080"
echo ""
