#!/usr/bin/env bash
set -euo pipefail
ALLOWED=("app_en" "app_yo" "app_ig" "app_ha")
found=()
while IFS= read -r -d '' file; do
  base="$(basename "$file" .arb)"
  ok=false
  for a in "${ALLOWED[@]}"; do
    if [[ "$base" == "$a" ]]; then ok=true; break; fi
  done
  if [[ "$ok" == "false" ]]; then found+=("$file"); fi
done < <(find lib/l10n -type f -name "app_*.arb" -print0 || true)
if [ "${#found[@]}" -ne 0 ]; then
  echo "Found disallowed locale files:"
  for f in "${found[@]}"; do echo " - $f"; done
  echo "Only these locales are allowed: ${ALLOWED[*]}"
  exit 1
fi
echo "Locale check passed. Only allowed locale files present."
exit 0