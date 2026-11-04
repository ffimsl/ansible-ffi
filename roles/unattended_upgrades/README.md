# unattended_upgrades

Installiert `unattended-upgrades` und konfiguriert automatische Updates.

Die Paketdatei `/etc/apt/apt.conf.d/50unattended-upgrades` wird **nicht** mehr angefasst. Eigene Einstellungen liegen in `/etc/apt/apt.conf.d/52unattended-upgrades-local`. Apt liest die Dateien alphabetisch, die 52 kommt also nach der 50: einfache Werte überschreiben, Listen (z. B. `Origins-Pattern`) werden *angehängt*. Soll eine Liste ersetzt werden, steht davor ein `#clear`. Die Rolle macht das **immer** und listet alle Quellen anhand der `include_*`-Schalter explizit auf. Die 52 ist damit die vollständige Liste der erlaubten Quellen, unabhängig vom Inhalt der Paketdatei.

Was die Rolle verwaltet:

| Datei | Zweck |
|---|---|
| `/etc/apt/apt.conf.d/20auto-upgrades` | Aktivierung (wie `dpkg-reconfigure -plow unattended-upgrades`). Die Intervalle stehen auf `always`, weil die Timer mehrmals täglich laufen. Bei `1` würde apt nur den ersten Lauf pro Tag ausführen. |
| `/etc/apt/apt.conf.d/52unattended-upgrades-local` | Quellen, Verhalten, Mail, Reboot |
| `/etc/systemd/system/apt-daily{,-upgrade}.timer.d/override.conf` | Zeitpunkt von Update und Upgrade |

Bei Konfig-Konflikten bleibt apt nie hängen (`Dpkg::Options --force-confdef --force-confold`).

## Konfiguration

Alles über **ein Dict `unattended_upgrades`**. Es müssen nur die Keys angegeben werden, die vom Default abweichen. Defaults stehen in `defaults/main.yml` (`unattended_upgrades_defaults`) und werden zu Beginn der Rolle gemergt. Unbekannte Keys (Tippfehler) und ungültige Werte für `reboot_mode`/`mail_report` brechen mit einer Fehlermeldung ab.

> **Wichtig:** Ansible merged Dicts nicht (`hash_behaviour=replace`). Wird `unattended_upgrades` in `group_vars` **und** `host_vars` gesetzt, ersetzt das Dict aus `host_vars` das aus `group_vars` vollständig. Die Rollen-Defaults gelten trotzdem. Keys aus `group_vars` müssen in `host_vars` also wiederholt werden.

| Key | Default | Bedeutung |
|---|---|---|
| `enabled` | `true` | `false` = deaktivieren (`20auto-upgrades` auf `0`, Timer-Drop-ins und Cronjob entfernt). Paket bleibt installiert. |
| `include_security` | `true` | Security-Updates (Debian-Security bzw. Ubuntu `-security` und ESM) |
| `include_updates` | `true` | `${distro_codename}-updates` |
| `include_point_releases` | `true` | Point-Releases (Debian `label=Debian`, Ubuntu Hauptarchiv) |
| `origins_pattern` | `[]` | weitere Origins, z. B. `"site=ftp.ripe.net"` |
| `package_blacklist` | `[]` | Python-Regex, diese Pakete werden nie automatisch aktualisiert |
| `minimal_steps` | `true` | Upgrade in kleinsten Schritten (unterbrechbar) |
| `dpkg_force_confold` | `true` | `Dpkg::Options` mit `--force-confdef`/`--force-confold`. Gilt global, auch für manuelle apt-Läufe. |
| `remove_unused_dependencies` | `true` | automatisches `autoremove` |
| `remove_unused_kernel_packages` | `true` | alte Kernel entfernen |
| `autoclean_interval` | `7` | `APT::Periodic::AutocleanInterval` (Tage) |
| `mail` | `""` | Empfänger, leer = keine Mail. Ein funktionierender MTA mit `mailx` wird vorausgesetzt. |
| `mail_report` | `only-on-error` | `always` \| `on-change` \| `only-on-error` |
| `reboot_mode` | `unattended` | `none` oder `unattended` (siehe unten) |
| `reboot_with_users` | `false` | Reboot auch bei angemeldeten Benutzern (nur `unattended`) |
| `reboot_time` | `01:00` | Uhrzeit für `unattended` |
| `timer_update` | `*-*-* 23,05,11,17:00` | `OnCalendar` von `apt-daily.timer` |
| `timer_upgrade` | `*-*-* 00/6:00` | `OnCalendar` von `apt-daily-upgrade.timer` |
| `timer_randomized_delay` | `"0"` | `RandomizedDelaySec` beider Timer |

### Reboot-Modi

- `none`: kein automatischer Reboot. Anstehende Reboots stehen in `/run/reboot-required` und müssen selbst geprüft werden.
- `unattended`: `Unattended-Upgrade::Automatic-Reboot` zur Uhrzeit `reboot_time`.

## Beispiele (host_vars)

Nur abweichende Werte angeben. Die Defaults sind: alle Quellen an, Reboot `unattended` zur gestaffelten Uhrzeit.

```yaml
# nur Security
unattended_upgrades:
  include_updates: false
  include_point_releases: false

# Defaults, aber Reboot um 04:00
unattended_upgrades:
  reboot_time: "04:00"

# Host mit Fremdrepo, kein Auto-Reboot, Mail bei Fehlern
unattended_upgrades:
  origins_pattern:
    - "site=ftp.ripe.net"
  reboot_mode: none
  mail: "root"

# komplett aus
unattended_upgrades:
  enabled: false
```

## Prüfen

- Origins ermitteln: `apt-cache policy`
- Wirksame Konfiguration: `apt-config dump | grep -i unattended`
- Trockenlauf: `unattended-upgrade --dry-run --debug`
- Timer: `systemctl list-timers 'apt-daily*'`
- Anstehende Reboots (v. a. bei `reboot_mode: none`): `ls /run/reboot-required`

## Hinweis zu eigenen systemd-Units

Dienste mit eigenen systemd-Units neben paketierten Units (z. B. eine zweite BIND-Instanz) können bei einem Upgrade gestoppt und nicht neu gestartet werden. Abhilfe: im Unit-Drop-in `PartOf=<paketierte Unit>` setzen.

## Verhaltensänderungen gegenüber der alten Rolle

- Die alte Rolle hat alle Quellen inkl. `-proposed-updates` installiert. Jetzt gibt es Security, `-updates` und Point-Releases (je einzeln abschaltbar), aber kein `-proposed-updates` mehr (per `origins_pattern` nachrüstbar). Der frühere Key `security_only` entfällt.
- Reboot: Default ist `reboot_mode: unattended` um 01:00, ohne angemeldete Benutzer (`reboot_with_users: false`). Wer nie automatisch rebooten will, setzt `reboot_mode: none`.
- Der Zeitpunkt richtet sich nach den systemd-Timern statt nach apt-Periodic.
