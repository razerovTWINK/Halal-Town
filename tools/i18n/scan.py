#!/usr/bin/env python3
"""Registry of untranslated player-facing strings for HalalTown RU localization.

Read-only. Produces tools/i18n/pending.json and prints a progress summary.
Usage: python tools/i18n/scan.py [--json-check]
"""
import json
import re
import sys
from collections import Counter, defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
I18N = ROOT / "tools" / "i18n"
CYR = re.compile("[\u0400-\u04ff]")
LAT = re.compile("[A-Za-z]")
QUOTED = re.compile(r'"([^"\\\n]{2,200})"')

# Technical / non-translatable files (see glossary.json).
SKIP_FILES = {
    "1000_most_common.txt", "numbers_as_words.txt", "greek_letters.txt",
    "phonetic_alphabet.txt", "round_start_sounds.txt", "spellcheck.json",
    "sillytips.txt", "clockwork_cult_changelog.txt",
}
SKIP_DIR_PARTS = {"names", "node_modules", ".git", "data", "tmp"}
CLAUDE_ZONE = "code/modules/roguetown/"
TECH_WORDS = {
    "name", "desc", "value", "type", "input", "key", "id", "text", "parent",
    "command", "class", "src", "null", "true", "false", "window", "size",
    "is-visible", "is-disabled", "background-color", "text-color", "focus",
    "on-show", "on-hide", "button", "map", "browser", "label", "title",
}
HTML_TAG = re.compile(r"<[^>]*>")


def is_candidate(text: str) -> bool:
    t = text.strip()
    if not (3 <= len(t) <= 200) or not LAT.search(t) or CYR.search(t):
        return False
    if t.lower() in TECH_WORDS or t in {"</span>", "</font>", "</b>", "</i>", "</a>"}:
        return False
    plain = HTML_TAG.sub("", t).strip()
    if not plain or not LAT.search(plain):
        return False
    if t.startswith(("//", "#", "http", "sound/", "icons/", "_maps/", "html/", "config/")):
        return False
    if "/" in t and re.search(r"\.(dm|dmi|dmm|ogg|png|json|txt|css|js)$", t):
        return False
    if re.fullmatch(r"[A-Z0-9_ .\-]+", t) and " " not in t:
        return False  # single uppercase identifier / key
    if t.startswith(("<span", "</span", "<font", "<b>", "<i>", "<a ")):
        return True
    return " " in t or t.isalpha()


SOURCES = defaultdict(set)


def scan_code() -> Counter:
    found = Counter()
    per_zone = defaultdict(Counter)
    for path in (ROOT / "code").rglob("*.dm"):
        rel = path.relative_to(ROOT).as_posix()
        if rel.startswith(CLAUDE_ZONE):
            continue  # owned by Claude Code
        try:
            lines = path.read_text(encoding="utf-8", errors="replace").splitlines()
        except OSError:
            continue
        zone = "/".join(rel.split("/")[:3])
        for line in lines:
            stripped = line.lstrip()
            if stripped.startswith("//") or stripped.startswith("#include") or stripped.startswith("#define"):
                continue
            # Only lines that actually present text to a player or name an object.
            if not re.search(r"\b(name|desc|say|to_chat|input|to_chat|visible_message|audible_message|examine|span)\b", line):
                continue
            for match in QUOTED.finditer(line):
                text = match.group(1)
                if is_candidate(text):
                    found[text] += 1
                    per_zone[zone][text] += 1
                    SOURCES[text].add(rel)
    return found, per_zone


def scan_strings() -> Counter:
    found = Counter()
    for path in (ROOT / "strings").rglob("*"):
        if not path.is_file() or path.suffix not in {".txt", ".json"}:
            continue
        rel = path.relative_to(ROOT).as_posix()
        if path.name in SKIP_FILES or any(part in SKIP_DIR_PARTS for part in path.parts):
            continue
        if path.name.endswith("_replacement.json"):
            continue
        try:
            raw = path.read_text(encoding="utf-8", errors="replace")
        except OSError:
            continue
        if path.suffix == ".json":
            try:
                data = json.loads(raw)
            except json.JSONDecodeError:
                continue
            def walk(node):
                if isinstance(node, str):
                    if is_candidate(node):
                        found[node] += 1
                        SOURCES[node].add(rel)
                elif isinstance(node, dict):
                    for v in node.values():
                        walk(v)
                elif isinstance(node, list):
                    for v in node:
                        walk(v)
            walk(data)
        else:
            for line in raw.splitlines():
                if is_candidate(line):
                    found[line.strip()] += 1
                    SOURCES[line.strip()].add(rel)
    return found


def count_russian_strings() -> int:
    total = 0
    for path in (ROOT / "code").rglob("*.dm"):
        try:
            total += len(CYR.findall(path.read_text(encoding="utf-8", errors="replace")))
        except OSError:
            pass
    return total


def json_check() -> int:
    bad = []
    for path in list((ROOT / "strings").rglob("*.json")) + list((I18N).glob("*.json")):
        # strings/books/*.json intentionally contain raw newlines in strings;
        # CI (ci.yml) excludes them too. They are game text, not strict JSON.
        if "strings/books/" in path.as_posix().replace("\\", "/"):
            continue
        try:
            json.loads(path.read_text(encoding="utf-8"))
        except (json.JSONDecodeError, OSError) as exc:
            bad.append(f"{path.relative_to(ROOT)}: {exc}")
    for line in bad:
        print("INVALID:", line)
    print(f"JSON check: {len(bad)} invalid file(s)")
    return 1 if bad else 0


def main() -> int:
    if "--json-check" in sys.argv:
        return json_check()

    code, per_zone = scan_code()
    strings = scan_strings()
    all_found = code + strings
    pending = [
        {"text": text, "count": count}
        for text, count in all_found.most_common()
    ]
    out = {
        "total_unique_untranslated": len(all_found),
        "total_occurrences": sum(all_found.values()),
        "code": {"unique": len(code), "occurrences": sum(code.values())},
        "strings": {"unique": len(strings), "occurrences": sum(strings.values())},
        "by_zone": {zone: {"unique": len(c), "occurrences": sum(c.values())} for zone, c in sorted(per_zone.items())},
        "top": pending[:40],
        "pending": pending,
    }
    (I18N / "pending.json").write_text(json.dumps(out, ensure_ascii=False, indent=2), encoding="utf-8")
    (I18N / "sources.json").write_text(
        json.dumps({k: sorted(v) for k, v in SOURCES.items() if k in all_found},
                   ensure_ascii=False, indent=2), encoding="utf-8"
    )

    print(f"Untranslated unique strings: {len(all_found)} ({sum(all_found.values())} occurrences)")
    print(f"  code/    : {len(code):6} unique / {sum(code.values()):6} occurrences")
    print(f"  strings/ : {len(strings):6} unique / {sum(strings.values()):6} occurrences")
    print(f"Russian chars already in code/: {count_russian_strings()}")
    print("\nTop zones:")
    for zone, info in sorted(out["by_zone"].items(), key=lambda kv: -kv[1]["occurrences"])[:12]:
        print(f"  {zone:45} {info['occurrences']:6} occurrences / {info['unique']:5} unique")
    print("\nMost frequent strings:")
    for item in pending[:12]:
        print(f"  {item['count']:4}x  {item['text'][:90]}")
    print(f"\nRegistry: {(I18N / 'pending.json').relative_to(ROOT)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
