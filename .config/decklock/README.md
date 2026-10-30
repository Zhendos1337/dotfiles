# Burning Crusade lock screen

DeckLock 0.3.6 with a looping, muted 1920×1080 Dark Portal video (58 seconds),
a small translucent password panel near the bottom and a muted red submit button.
The local variant fades the scene in/out over opaque black in 550 ms. The video and binaries
are local assets excluded from Git. No system packages or PAM files are changed.

Manual locking through `Super+X` → **Lock** and `Super+Alt+L` starts DeckLock.
The menu keeps **Lock (Noctalia, backup)** (shortcut `6`). Noctalia continues to
handle **Lock and Suspend**, sleep locking and its other built-in lock requests.
Its lock screen stays enabled as a fallback. The wrapper falls back to Noctalia
if the local executable/video is missing or DeckLock configuration is invalid.

## Preview and rollback

From the repository root:

```sh
.config/decklock/bin/decklock --preview --preview-fullscreen
# Escape closes the preview. Authentication and power actions are disabled.

.config/decklock/bin/rollback
# Restores the original menu entry, Hyprlock hotkey and BINDS.md row.

.config/decklock/bin/rollback-look
# Restore the larger panel and release binary used before the transition change.

python3 .config/decklock/bin/integration.py enable
# Re-enable the prepared replacement.

python3 .config/decklock/bin/integration.py status
```

Switching creates timestamped copies of affected files in `backups/`. Rollback
reverts only the exact lock-related edits, preserving unrelated configuration
changes. If those exact blocks have since been edited, it refuses to overwrite
them and points to the backups. Niri reloads its configuration automatically;
the script also asks Noctalia to reload. Rollback changes future lock requests;
it cannot unlock a session which is already locked.

## Dependencies and local installation

This installation targets the current Arch Linux x86_64 desktop: GTK4 4.24,
GStreamer 1.28.8, glibc 2.44 and the existing `/etc/pam.d/system-auth` auth/account
stack. The PAM service is equivalent to the includes in DeckLock's Arch package.
Passwords are handled by DeckLock/PAM, never by the shell wrappers.

```sh
.config/decklock/bin/install-runtime
.config/decklock/bin/build-transitions
```

The installer verifies pinned package hashes, extracts DeckLock,
`gtk4-layer-shell` and `gst-libav` under `runtime/`, and downloads the background.
Failed downloads are retried using `proxychains4`. GTK and the other base runtime
libraries come from the installed system. The integration paths point to this
checkout, `/home/zhendos/.dotfiles`; re-run integration setup if relocating it.

`build-transitions` builds a pinned source archive with `patches/transitions.patch`.
It needs Rust/Cargo, GTK4/GStreamer development files, pkg-config, patch, Xvfb,
xauth and dbus-run-session. It runs library/session tests and an isolated GTK
transition test before installing `runtime/usr/bin/decklock-animated`. The original
release binary remains alongside it. The wrapper selects the variant when present.

The patch anchors this theme's form to the bottom rather than applying a fixed
pixel offset. It animates only the scene inside an opaque black surface: lock
ownership is retained during the exit fade. The existing authentication success
path is the only route to an unlock, and the delayed callback checks that its
authorization has not been revoked by termination. When outputs stop producing
frames, a bounded timer still completes the authorized exit. Preview uses the
same fade on close without invoking authentication. These are fades to/from black,
not a crossfade of the live desktop.

`bin/decklock` disables GTK's OpenGL support for this process (`GDK_DISABLE=gl`),
using the video sink's CPU fallback while keeping GTK's Vulkan renderer. The
default GL video sink segfaulted during preview shutdown on this machine.

## Validation

Configuration validation, a real Niri preview and changing video frames can be
checked without locking. Preview does not test successful password authentication
or unlocking; those require an actual lock and the account owner's password.

Transition variant validation (source snapshot `7a8af6b` in the temporary build):

- Rustfmt, Clippy for Wayland and X11, Rust library/CLI/session tests, and package
  contract checks passed.
- The new isolated GTK check passed: intermediate entry/exit frames, opaque base
  and window, delayed completion, disabled input during exit, and hidden outputs.
- The isolated Wayland protocol check passed with transitions enabled: lock
  acquisition, monitor changes, SIGTERM without unlock, second lock refusal.
- `scripts/check --all` did **not** pass completely: its GTK gate requires the
  unavailable `xfwm4` executable. Earlier GUI checks in that gate passed; the
  later gates were not run by that command. Logs are under local
  `state/transition-checks/`. No real password or real-session lock was tested.

## Sources

- [DeckLock release](https://github.com/yan-vidal/DeckLock/releases/tag/v0.3.6)
- [Video source and preview](https://www.desktophut.com/PC-The-Burning-Crusade-WOW-Live-Wallpaper-Free)
- [GTK renderer controls](https://docs.gtk.org/gtk4/running.html)

World of Warcraft imagery belongs to Blizzard Entertainment. The downloaded
video is used as a personal local wallpaper and is not included in Git.
