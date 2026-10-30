#!/usr/bin/env python3
"""Switch manual lock entry points; preserve unrelated edits on rollback."""
import datetime
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile

HOME = Path(__file__).resolve().parent.parent
ROOT = HOME.parent.parent
MANIFEST = HOME / "backups" / "integration.json"


def write(path, content):
    mode = path.stat().st_mode & 0o777
    with tempfile.NamedTemporaryFile(mode="w", dir=path.parent, delete=False) as file:
        file.write(content)
        temporary = Path(file.name)
    temporary.chmod(mode)
    os.replace(temporary, path)


def replacements():
    original_action = '''        [[shell.session.actions]]
        action = "lock"
        command = ""
        countdown_seconds = 0.0
        enabled = true
        glyph = ""
        label = ""
        shortcut = "1"
        variant = "default"'''
    custom_action = original_action.replace('action = "lock"', 'action = "command"').replace(
        'command = ""', f'command = "bash {HOME}/bin/lock-screen"'
    ).replace('glyph = ""', 'glyph = "lock"').replace('label = ""', 'label = "Lock"')
    backup_action = original_action.replace('label = ""', 'label = "Lock (Noctalia, backup)"').replace(
        'shortcut = "1"', 'shortcut = "6"'
    )
    original_bind = '  Mod+Alt+L hotkey-overlay-title="Lock the Screen: hyprlock" { spawn "hyprlock"; }'
    custom_bind = f'  Mod+Alt+L hotkey-overlay-title="Lock: Burning Crusade" {{ spawn "bash" "{HOME}/bin/lock-screen"; }}'
    original_doc = '| **Блокировка экрана**  | Блокирует сессию                         | `Super+Alt+L` (swaylock)       | `Super+Alt+L` (hyprlock) | Заменен локер на hyprlock.    |'
    custom_doc = '| **Блокировка экрана** | Анимированный Тёмный портал (DeckLock) | `Super+Alt+L` (swaylock) | `Super+Alt+L` | Также `Super+X` → Lock; резерв: Lock (Noctalia, backup). |'
    return [
        {"path": ".config/noctalia/config.toml", "before": original_action, "after": custom_action + "\n\n" + backup_action},
        {"path": ".config/niri/config.kdl", "before": original_bind, "after": custom_bind},
        {"path": ".config/niri/BINDS.md", "before": original_doc, "after": custom_doc},
    ]


def main():
    if len(sys.argv) != 2 or sys.argv[1] not in ("enable", "disable", "status"):
        raise SystemExit("Usage: integration.py enable|disable|status")
    action = sys.argv[1]
    changes = json.loads(MANIFEST.read_text()) if MANIFEST.exists() else replacements()
    if action == "status":
        for change in changes:
            content = (ROOT / change["path"]).read_text()
            state = "DeckLock" if change["after"] in content else "original" if change["before"] in content else "modified"
            print(f'{change["path"]}: {state}')
        return
    source, target = ("before", "after") if action == "enable" else ("after", "before")
    pending = []
    for change in changes:
        path = ROOT / change["path"]
        content = path.read_text()
        if content.count(change[source]) == 1:
            pending.append((path, content, content.replace(change[source], change[target], 1)))
        elif content.count(change[target]) != 1:
            raise SystemExit(f"Refusing to overwrite edited lock settings in {path}; compare with {MANIFEST.parent}")
    if pending:
        backup = MANIFEST.parent / datetime.datetime.now().strftime("%Y%m%d-%H%M%S-%f")
        backup.mkdir(parents=True)
        for path, content, _ in pending:
            (backup / path.name).write_text(content)
        if not MANIFEST.exists():
            MANIFEST.write_text(json.dumps(changes, ensure_ascii=False, indent=2) + "\n")
        completed = []
        try:
            for path, content, updated in pending:
                write(path, updated)
                completed.append((path, content))
            subprocess.run(["niri", "validate", "-c", str(ROOT / ".config/niri/config.kdl")], check=True)
            subprocess.run(["noctalia", "config", "validate", str(ROOT / ".config/noctalia")], check=True)
        except BaseException:
            for path, content in completed:
                write(path, content)
            raise
        print(f"Backups: {backup}")
    print("DeckLock enabled for manual locks." if action == "enable" else "Original manual lock settings restored.")
    result = subprocess.run(["noctalia", "msg", "config-reload"], check=False)
    if result.returncode:
        print("Saved; run 'noctalia msg config-reload' from your desktop session.", file=sys.stderr)


if __name__ == "__main__":
    main()
