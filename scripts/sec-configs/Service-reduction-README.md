# Service Reduction – Baseline Hardening

## Purpose

This step reduces the system attack surface by disabling services that are unnecessary on a VPS or server environment.

Only services that are clearly non-essential are disabled.  
Core system, network, and security services are intentionally left untouched.

The goal is stability, predictability, and safe Disaster Recovery.

---

## What This Script Does

The script disables services that are typically:

- Desktop-related
- Consumer-oriented
- Irrelevant on a server or VPS

Examples include printing, mDNS discovery, crash reporting, and desktop remote services.

No services are removed or uninstalled.

---

## Disabled Services

The following services are disabled if present:

- cups / cups-browsed
- avahi-daemon
- bluetooth
- ModemManager
- whoopsie
- apport (all related units)
- gnome-remote-desktop
- switcheroo-control

Additionally, the following services are treated as optional and disabled only if active:

- power-profiles-daemon
- wpa_supplicant

---

## Prerequisites

- SSH access must be working
- No desktop usage is expected on the server
- This script is intended for VPS / server environments

---

## Run Service Reduction

From the repository root:

```bash
chmod +x scripts/hardening/service-reduction-safe.sh
sudo ./scripts/hardening/service-reduction-safe.sh
