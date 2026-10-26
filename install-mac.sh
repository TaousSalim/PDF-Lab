#!/bin/bash
# PDF Lab for the Mac: the installer in one command.
#
#     curl -fsSL https://raw.githubusercontent.com/TaousSalim/PDF-Lab/main/install-mac.sh | bash
#
# What it does, and nothing else:
#   1. checks that this is a Mac with macOS 14.4 or newer (what PDF Lab needs)
#   2. downloads the newest PDF Lab from GitHub and checks that it arrived whole
#   3. puts it into the Applications folder (an older PDF Lab there goes to the Trash)
#   4. if the Mac has neither Brave nor Google Chrome (nor Edge or Chromium), downloads Google Chrome from Google
#      and puts it into Applications as well: two of the twelve tools (Word to PDF, Image to PDF) print
#      through such a browser, without ever opening it
#   5. opens PDF Lab
# Nothing else is installed, nothing asks for the Mac's password, and every step says what it does.
# The app needs no Python, no Homebrew and no other program. Works on Apple Silicon and Intel.
set -euo pipefail

URL="${PDFLAB_URL:-https://github.com/TaousSalim/PDF-Lab/releases/latest/download/PDF-Lab-Mac.zip}"
CHROME_URL="https://dl.google.com/chrome/mac/universal/stable/GGRO/googlechrome.dmg"
DEST="${PDFLAB_DEST:-/Applications}"
APP_NAME="PDF Lab.app"

say()  { printf '\n==> %s\n' "$*"; }
note() { printf '    %s\n' "$*"; }
fail() { printf '\nPDF Lab was not installed: %s\n' "$*" >&2; exit 1; }

# ---- 1. the Mac
[ "$(uname -s)" = "Darwin" ] || fail "this installer is for a Mac."
OS="$(sw_vers -productVersion)"
MAJOR="${OS%%.*}"; REST="${OS#*.}"; MINOR="${REST%%.*}"; [ "$MINOR" = "$OS" ] && MINOR=0
if [ "$MAJOR" -lt 14 ] || { [ "$MAJOR" -eq 14 ] && [ "$MINOR" -lt 4 ]; }; then
  fail "this Mac runs macOS $OS. PDF Lab needs macOS 14.4 or newer. Update macOS (System Settings, General, Software Update), then run this again."
fi
say "Installing PDF Lab on this Mac (macOS $OS, $(uname -m))"

TMP="$(mktemp -d)"
MOUNT=""
cleanup() { [ -n "$MOUNT" ] && hdiutil detach -quiet "$MOUNT" >/dev/null 2>&1; rm -rf "$TMP"; }
trap cleanup EXIT

# ---- 2. the download
say "Downloading PDF Lab (about 75 MB)"
curl -fL --retry 3 --retry-delay 2 --progress-bar -o "$TMP/PDF-Lab-Mac.zip" "$URL" \
  || fail "the download did not work. Check the internet connection and run this again."
ditto -x -k "$TMP/PDF-Lab-Mac.zip" "$TMP/unpacked" 2>/dev/null || fail "the download is not complete. Run this again."
[ -d "$TMP/unpacked/$APP_NAME" ] || fail "the download does not hold PDF Lab. Run this again."
codesign --verify --deep --strict "$TMP/unpacked/$APP_NAME" 2>/dev/null || fail "the download arrived damaged. Run this again."
note "downloaded and checked"

# ---- 3. into Applications
if [ ! -w "$DEST" ]; then
  DEST="$HOME/Applications"       # a Mac where this user may not change /Applications
  mkdir -p "$DEST"
fi
if pgrep -x pdf-lab-native >/dev/null 2>&1; then
  say "Closing the PDF Lab that is open"
  osascript -e 'tell application "PDF Lab" to quit' >/dev/null 2>&1 || true
  for _ in 1 2 3 4 5 6 7 8 9 10; do pgrep -x pdf-lab-native >/dev/null 2>&1 || break; sleep 0.5; done
  pkill -x pdf-lab-native >/dev/null 2>&1 || true
fi
if [ -e "$DEST/$APP_NAME" ]; then
  mkdir -p "$HOME/.Trash"
  OLD="$HOME/.Trash/PDF Lab (replaced $(date +%Y-%m-%d\ %H.%M.%S)).app"
  mv "$DEST/$APP_NAME" "$OLD" 2>/dev/null || fail "the PDF Lab in $DEST could not be moved to the Trash. Move it there yourself, then run this again."
  note "the PDF Lab that was there is in the Trash"
fi
say "Putting PDF Lab into $DEST"
ditto "$TMP/unpacked/$APP_NAME" "$DEST/$APP_NAME" || fail "PDF Lab could not be copied into $DEST."
xattr -dr com.apple.quarantine "$DEST/$APP_NAME" >/dev/null 2>&1 || true
codesign --verify --deep --strict "$DEST/$APP_NAME" 2>/dev/null || fail "the copy in $DEST is not whole. Run this again."
note "done"

# ---- 4. Google Chrome, only when the Mac has none (Word to PDF and Image to PDF print through it)
have_browser() {
  local base name
  for base in /Applications "$HOME/Applications"; do
    for name in "Brave Browser" "Google Chrome" "Chromium" "Microsoft Edge"; do
      [ -d "$base/$name.app" ] && return 0
    done
  done
  return 1
}
if [ -n "${PDFLAB_SKIP_CHROME:-}" ] || have_browser; then
  note "Brave or Chrome is already here (two of the tools print through it)"
else
  say "Installing Google Chrome from Google (two of the tools need it)"
  if curl -fL --retry 3 --progress-bar -o "$TMP/googlechrome.dmg" "$CHROME_URL" \
     && MOUNT="$TMP/chrome" && mkdir -p "$MOUNT" && hdiutil attach -nobrowse -quiet -readonly -mountpoint "$MOUNT" "$TMP/googlechrome.dmg" \
     && [ -d "$MOUNT/Google Chrome.app" ] && ditto "$MOUNT/Google Chrome.app" "$DEST/Google Chrome.app"; then
    note "Google Chrome is installed"
  else
    note "Google Chrome could not be installed automatically."
    note "PDF Lab works without it, except Word to PDF and Image to PDF. To add it later: google.com/chrome"
  fi
fi

# ---- 5. open it
say "PDF Lab is installed"
note "It opens now and asks for its licence key: send the computer code it shows to get yours."
note "Next time: open PDF Lab from the Applications folder or with Spotlight. It updates itself."
[ -n "${PDFLAB_NO_OPEN:-}" ] || open "$DEST/$APP_NAME" || true
