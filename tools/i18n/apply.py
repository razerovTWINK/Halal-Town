#!/usr/bin/env python3
"""Apply Russian localization to the DATA zone only (strings/ + 2 config texts).

- full_files.json : path -> list of fully translated lines (whole-file rewrite)
- ru-dict.json    : exact source string -> Russian (line replacement in .txt,
                    quoted-value replacement in .json)

Never touches code/, *.dm, roguetown.dme/dmb, or the Claude Code zone.
Preserves UTF-8 and the original CRLF/LF style. Verifies strict JSON files.

Usage: python tools/i18n/apply.py [--dry-run]
"""
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
I18N = ROOT / "tools" / "i18n"
STRINGS = ROOT / "strings"

SKIP_NAMES = {
    "1000_most_common.txt", "numbers_as_words.txt", "greek_letters.txt",
    "phonetic_alphabet.txt", "round_start_sounds.txt", "spellcheck.json",
    "sillytips.txt", "clockwork_cult_changelog.txt", "roundid.txt",
    "accent_universal.json", "proper_replacement.json",
}
SKIP_SUFFIX = "_replacement.json"
STRICT_JSON_EXEMPT = "strings/books/"  # raw newlines inside strings; CI excludes them
QUOTED = re.compile(r'"((?:[^"\\]|\\.)*)"', re.DOTALL)


def load_json(name):
    return json.loads((I18N / name).read_text(encoding="utf-8"))


def newline_style(raw: bytes) -> str:
    return "\r\n" if b"\r\n" in raw else "\n"


def decode(raw: bytes):
    nl = newline_style(raw)
    text = raw.decode("utf-8")
    if nl == "\r\n":
        text = text.replace("\r\n", "\n")
    return text, nl


def encode(text: str, nl: str, had_trailing_newline: bool) -> bytes:
    if had_trailing_newline and not text.endswith("\n"):
        text += "\n"
    if nl == "\r\n":
        text = text.replace("\n", "\r\n")
    return text.encode("utf-8")


def apply_full_files(files: dict, dry_run: bool) -> dict:
    result = {}
    for rel, lines in files.items():
        path = ROOT / rel
        if not path.exists():
            result[rel] = "MISSING"
            continue
        raw = path.read_bytes()
        nl = newline_style(raw)
        trailing = raw.endswith(b"\n") or raw.endswith(b"\r\n")
        new_text = "\n".join(lines)
        new_raw = encode(new_text, nl, trailing)
        if new_raw == raw:
            result[rel] = 0
            continue
        if not dry_run:
            path.write_bytes(new_raw)
        result[rel] = len(lines)
    return result


def allowed_data_files():
    out = []
    for path in STRINGS.rglob("*"):
        if not path.is_file() or path.suffix not in {".txt", ".json"}:
            continue
        rel = path.relative_to(ROOT).as_posix()
        if path.name in SKIP_NAMES or path.name.endswith(SKIP_SUFFIX):
            continue
        if "strings/names/" in rel or "strings/rt/names/" in rel:
            continue
        out.append(path)
    for rel in ("config/motd.txt", "config/silicon_laws.txt"):
        p = ROOT / rel
        if p.exists():
            out.append(p)
    return out


def translate_txt(text: str, dictionary: dict):
    lines = text.split("\n")
    n = 0
    for i, line in enumerate(lines):
        stripped = line.strip()
        if not stripped or stripped not in dictionary:
            continue
        ru = dictionary[stripped]
        if stripped == line:
            lines[i] = ru
        else:
            lines[i] = line.replace(stripped, ru, 1)
        n += 1
    return "\n".join(lines), n


def translate_json(text: str, dictionary: dict):
    """Replace quoted JSON *values* only; keys are detected by a following colon."""
    n = 0
    out = []
    last = 0
    for m in QUOTED.finditer(text):
        tail = text[m.end():]
        is_key = tail.lstrip().startswith(":")
        if is_key or m.group(1) not in dictionary:
            continue
        ru = dictionary[m.group(1)]
        # Keep escape style: dictionary values contain no quotes/backslashes here,
        # but escape defensively so the JSON stays valid.
        ru_escaped = ru.replace("\\", "\\\\").replace('"', '\\"')
        out.append(text[last:m.start()])
        out.append('"' + ru_escaped + '"')
        last = m.end()
        n += 1
    if not n:
        return text, 0
    out.append(text[last:])
    return "".join(out), n


def main() -> int:
    dry_run = "--dry-run" in sys.argv
    full_files = load_json("full_files.json")
    dictionary = {}
    for dict_path in sorted(I18N.glob("ru-dict*.json")):
        for k, v in load_json(dict_path.name).items():
            if not k.startswith("_"):
                dictionary[k] = v

    report = {"dry_run": dry_run, "full_files": {}, "dictionary": {}, "errors": []}
    report["full_files"] = apply_full_files(full_files, dry_run)

    for path in allowed_data_files():
        raw = path.read_bytes()
        text, nl = decode(raw)
        trailing = raw.endswith(b"\n") or raw.endswith(b"\r\n")
        if path.suffix == ".json":
            new_text, n = translate_json(text, dictionary)
            if n and "strings/books/" not in path.as_posix().replace("\\", "/"):
                try:
                    json.loads(new_text)
                except json.JSONDecodeError as exc:
                    report["errors"].append(f"{path.relative_to(ROOT).as_posix()}: {exc}")
                    continue
        else:
            new_text, n = translate_txt(text, dictionary)
        if not n:
            continue
        rel = path.relative_to(ROOT).as_posix()
        report["dictionary"][rel] = n
        if not dry_run:
            path.write_bytes(encode(new_text, nl, trailing))

    (I18N / "report.json").write_text(
        json.dumps(report, ensure_ascii=False, indent=2), encoding="utf-8"
    )
    full_changed = sum(1 for v in report["full_files"].values() if isinstance(v, int) and v > 0)
    dict_occurrences = sum(report["dictionary"].values())
    print(f"Full files rewritten : {full_changed} / {len(full_files)}")
    print(f"Dictionary hits      : {dict_occurrences} in {len(report['dictionary'])} file(s)")
    for rel, n in sorted(report["dictionary"].items(), key=lambda kv: -kv[1])[:12]:
        print(f"  {n:4}  {rel}")
    if report["errors"]:
        print("ERRORS (file kept unchanged):")
        for e in report["errors"]:
            print("  ", e)
    print(f"Report: {(I18N / 'report.json').relative_to(ROOT)}")
    return 1 if report["errors"] else 0


if __name__ == "__main__":
    raise SystemExit(main())
