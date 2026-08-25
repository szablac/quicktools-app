#!/bin/bash
# QuickTools.hu — deploy szkript. A SZERVEREN futtatandó SSH-n keresztül, NEM a fejlesztői gépen.
#
# Használat (a fejlesztői gépről egy paranccsal):
#   ssh szablac@185.75.192.93 'bash ~/quicktools.qwer.hu/scripts/deploy.sh'
#
# Mit csinál:
#   1. Leáll, ha a szerveren trackelt fájlban el nem mentett módosítás van (biztonsági fék).
#   2. git pull.
#   3. Csak akkor futtat npm install-t, ha a package-lock.json ténylegesen változott a pull során.
#   4. Újraindítja a Passenger-alkalmazást (tmp/restart.txt érintésével).
#
# Amit ez a szkript NEM csinál (tudatosan):
#   - Nem futtat le adatbázis-migrációt automatikusan — az séma-módosítás, külön átgondolást
#     érdemel minden alkalommal (lásd CLAUDE.md 4. szakasz). Migráció futtatásához:
#       cd ~/quicktools.qwer.hu && mysql < db/migrations/0XX_nev.sql
#     (feltételezi, hogy a ~/.my.cnf be van állítva a DB-hitelesítéshez — lásd docs/09_DECISIONS.md)

set -euo pipefail

APP_DIR="$HOME/quicktools.qwer.hu"
cd "$APP_DIR"

echo "== Biztonsági ellenőrzés: van-e el nem mentett módosítás trackelt fájlban =="
DIRTY=$(git status --short --untracked-files=no)
if [ -n "$DIRTY" ]; then
  echo "HIBA: a szerveren el nem mentett módosítás van trackelt fájlban — megszakítva, hogy ne vesszen el semmi:"
  echo "$DIRTY"
  exit 1
fi

echo "== git pull =="
LOCK_BEFORE=$(md5sum package-lock.json 2>/dev/null || echo "none")
git pull
LOCK_AFTER=$(md5sum package-lock.json 2>/dev/null || echo "none")

if [ "$LOCK_BEFORE" != "$LOCK_AFTER" ]; then
  echo "== package-lock.json változott — npm install =="
  # shellcheck disable=SC1091
  source "$HOME/nodevenv/quicktools.qwer.hu/22/bin/activate"
  npm install --omit=dev
else
  echo "== package.json/lock nem változott — npm install kihagyva =="
fi

echo "== Passenger újraindítás =="
mkdir -p tmp
touch tmp/restart.txt

echo "== Kész: $(git log -1 --oneline) =="
