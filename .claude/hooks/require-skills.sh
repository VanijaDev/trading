#!/usr/bin/env bash
# UserPromptSubmit: on every prompt, tell Claude to apply never-guess and
# stop-slop, and to invoke whichever of them this session hasn't loaded yet.
# Stdout becomes model context.
set -uo pipefail

transcript=$(jq -r '.transcript_path // empty')

# Parse tool_use records, never raw text: prose that names a skill must not
# count as loaded. Prints the missing skills joined with " and ".
read -r -d '' find_missing <<'PY'
import json, sys
required = ['never-guess', 'stop-slop']
loaded = set()
for line in open(sys.argv[1], errors='replace'):
    if '"Skill"' not in line:
        continue
    try:
        rec = json.loads(line)
    except Exception:
        continue
    msg = rec.get('message') or {}
    if msg.get('role') != 'assistant':
        continue
    for c in msg.get('content') or []:
        if isinstance(c, dict) and c.get('type') == 'tool_use' and c.get('name') == 'Skill':
            loaded.add((c.get('input') or {}).get('skill'))
print(' and '.join(s for s in required if s not in loaded))
PY

missing='never-guess and stop-slop'
if [ -n "$transcript" ] && [ -f "$transcript" ]; then
  # On a parse failure, keep the default so Claude still loads both.
  missing=$(python3 -c "$find_missing" "$transcript" 2>/dev/null) || missing='never-guess and stop-slop'
fi

if [ -n "$missing" ]; then
  echo "Invoke $missing, then apply never-guess and stop-slop to this reply and every file edit."
else
  echo 'Apply never-guess and stop-slop to this reply and every file edit.'
fi
exit 0
