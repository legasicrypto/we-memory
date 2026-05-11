#!/bin/bash
# WeMemory - Client Installer
# Downloads and installs the latest WeMemory client from the API.
#
# Usage: bash install.sh
# Requires: bash, curl, python3, shasum

set -e

API_URL="${LEGASI_API_URL:-https://memory.legasi.io}"

echo "WeMemory - Installing client..."
echo ""

# Check dependencies
for cmd in curl python3 shasum tar; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "Error: $cmd is required but not found." >&2
        exit 1
    fi
done

# Fetch latest release info
echo "Fetching latest release..."
RELEASE_JSON=$(curl -s --connect-timeout 5 --max-time 10 "$API_URL/releases/latest" 2>/dev/null)

if [ -z "$RELEASE_JSON" ]; then
    echo "Error: Could not reach the API at $API_URL" >&2
    echo "If you are self-hosting, set LEGASI_API_URL before running this script:" >&2
    echo "  export LEGASI_API_URL=\"https://your-instance.example.com\"" >&2
    exit 1
fi

if echo "$RELEASE_JSON" | grep -q '"detail"'; then
    echo "Error: No release available on the server." >&2
    exit 1
fi

VERSION=$(echo "$RELEASE_JSON" | python3 -c "import sys, json; print(json.load(sys.stdin)['version'])" 2>/dev/null)
SHA256=$(echo "$RELEASE_JSON" | python3 -c "import sys, json; print(json.load(sys.stdin)['sha256'])" 2>/dev/null)
DOWNLOAD_URL=$(echo "$RELEASE_JSON" | python3 -c "import sys, json; print(json.load(sys.stdin)['download_url'])" 2>/dev/null)

if [ -z "$VERSION" ] || [ -z "$SHA256" ] || [ -z "$DOWNLOAD_URL" ]; then
    echo "Error: Invalid release data from server." >&2
    exit 1
fi

echo "  Version: $VERSION"

# Download archive
TMP_DIR=$(mktemp -d)
ARCHIVE="$TMP_DIR/wememory.tar.gz"

echo "Downloading..."
curl -s --max-time 60 "$API_URL$DOWNLOAD_URL" -o "$ARCHIVE" 2>/dev/null

if [ ! -f "$ARCHIVE" ] || [ ! -s "$ARCHIVE" ]; then
    echo "Error: Download failed." >&2
    rm -rf "$TMP_DIR"
    exit 1
fi

# Verify integrity
ACTUAL_SHA256=$(shasum -a 256 "$ARCHIVE" | cut -d' ' -f1)
if [ "$ACTUAL_SHA256" != "$SHA256" ]; then
    echo "Error: SHA256 verification failed." >&2
    echo "  Expected: $SHA256" >&2
    echo "  Got:      $ACTUAL_SHA256" >&2
    rm -rf "$TMP_DIR"
    exit 1
fi

echo "  Integrity verified."

# Extract and run the bundled installer
tar -xzf "$ARCHIVE" -C "$TMP_DIR" 2>/dev/null
INSTALLER=$(find "$TMP_DIR" -name "install*.sh" -type f | head -1)

if [ -z "$INSTALLER" ]; then
    echo "Error: No installer found in the archive." >&2
    rm -rf "$TMP_DIR"
    exit 1
fi

echo "Installing..."
cd "$(dirname "$INSTALLER")" && bash "$(basename "$INSTALLER")"
INSTALL_EXIT=$?

# Cleanup
rm -rf "$TMP_DIR"

if [ $INSTALL_EXIT -eq 0 ]; then
    echo ""
    echo "WeMemory v$VERSION installed successfully!"
else
    echo "Error: Installation failed." >&2
    exit 1
fi
