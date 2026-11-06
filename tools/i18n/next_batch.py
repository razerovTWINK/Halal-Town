#!/usr/bin/env python3
"""Generate the next translation batch template for a zone, without overlaps.

Usage:
  python tools/i18n/scan.py                      # refresh registry first
  python tools/i18n/next_batch.py --zone strings/ --limit 200
  python tools/i18n/next_batch.py --zone code/game/objects/items/ --limit 200

Output: tools/i18n/batch_<slug>.json with { "English text": "" } entries.
Fill the empty values with Russian translations, save as ru-dict-N.json, then
run `python tools/i18n/apply.py` (which merges all ru-dict*.json).

Claude Code owns code/modules/roguetown/** - that path is always excluded.
"""
import argparse
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
I18N = ROOT / "tools" / "i18n"
CLAUDE_ZONE = "code/modules/roguetown/"


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--zone", required=True, help="path prefix, e.g. strings/ or code/game/objects/items/")
    ap.add_argument("--limit", type=int, default=200)
    ap.add_argument("--out", default=None)
    args = ap.parse_args()

    pending = json.loads((I18N / "pending.json").read_text(encoding="utf-8"))
    sources = json.loads((I18N / "sources.json").read_text(encoding="utf-8"))

    batch = {}
    for item in pending["pending"]:
        text = item["text"]
        paths = sources.get(text, [])
        if not any(p.startswith(args.zone) for p in paths):
            continue
        if any(p.startswith(CLAUDE_ZONE) for p in paths) and not args.zone.startswith("code/modules/roguetown"):
            continue
        batch[text] = ""
        if len(batch) >= args.limit:
            break

    slug = re.sub(r"[^A-Za-z0-9]+", "_", args.zone).strip("_") or "all"
    out = Path(args.out) if args.out else I18N / f"batch_{slug}.json"
    out.write_text(json.dumps(batch, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"Zone: {args.zone}")
    print(f"Strings queued: {len(batch)}")
    print(f"Template: {out.relative_to(ROOT)}")
    print("Fill values, rename to ru-dict-N.json, then run apply.py")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
