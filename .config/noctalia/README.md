# Noctalia v5 and AirPods

`config.toml` replaces the legacy Noctalia v4 JSON configuration and QML plugins.
The configured official and community sources provide the enabled plugins.
Niri starts Noctalia with `NOCTALIA_CONFIG_HOME=$HOME/.dotfiles/.config`
(the current Niri config uses the absolute path for user `zhendos`).

## Set up AirPods on another machine

The config enables `harveywuk/airpods` and places its widget beside Bluetooth.
The widget is hidden while the headphones are disconnected. Left-click opens
the controls; right-click cycles listening modes.

The plugin requires the patched `harveywuk/librepods` daemon, installed separately
on each machine. On Arch Linux, with Noctalia v5 installed:

```sh
sudo pacman -S --needed cmake ninja pkgconf qt6-connectivity qt6-tools qt6-declarative libpulse openssl
git clone https://github.com/harveywuk/librepods ~/librepods-airpods
cd ~/librepods-airpods
git checkout 4ed49df0b301ac3e6fba9c81dfbbb6726cc52201
cmake -B build -G Ninja -DBUILD_TESTING=OFF
cmake --build build --parallel 2
cmake --install build --prefix "$HOME/.local"
systemctl --user daemon-reload
systemctl --user enable --now librepods.service
noctalia msg config-reload
noctalia msg plugins enable harveywuk/airpods
```

This pins the daemon to the revision used on the work machine. Pair the AirPods
using your usual Bluetooth settings. Adjust `plugin_settings."harveywuk/airpods".ctl_path`
if your home directory is not `/home/zhendos`.

## Verify

```sh
noctalia config validate "$HOME/.dotfiles/.config/noctalia"
systemctl --user status librepods.service
"$HOME/.local/bin/librepods-ctl" status
```

See the [plugin documentation](https://github.com/noctalia-dev/community-plugins/tree/main/airpods)
for requirements and settings.

## Realtek Bluetooth repeatedly turns on and off

On the work machine, the USB adapter `0bda:a725` resets while AirPods are
disconnected. Disabling USB autosuspend stopped the repeated notifications.
The repository's udev rule keeps only this adapter awake, including after
reboot or reconnect. Install it on machines with the same adapter:

```sh
sudo install -m 0644 "$HOME/.dotfiles/udev/99-realtek-bluetooth-no-autosuspend.rules" /etc/udev/rules.d/
sudo udevadm control --reload-rules
sudo udevadm trigger --action=change --subsystem-match=usb --attr-match=idVendor=0bda --attr-match=idProduct=a725
```

Verify that the adapter's `/sys/bus/usb/devices/<device>/power/control` reads
`on`. Other USB devices retain their existing power settings.
