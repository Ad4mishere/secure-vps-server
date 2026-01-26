# AIDE – File Integrity Monitoring

## Purpose

AIDE (Advanced Intrusion Detection Environment) is used to detect unauthorized
changes to critical system files after system hardening is complete.

This repository uses AIDE to:
- Monitor system binaries and libraries
- Detect changes to configuration files
- Support incident response and disaster recovery

---

## Scope

Monitored paths include:
- System binaries and libraries
- Core configuration files
- Boot-related files

The following are intentionally excluded:
- Logs
- Runtime directories
- Temporary files
- Cache directories

This reduces false positives on VPS systems.

---

## Repository Files

- `scripts/sec-configs/aide/aide.conf`  
  Deterministic AIDE policy

- `scripts/hardening/aide-installation.sh`  
  Installs AIDE and initializes the baseline

---

## Installation & Baseline Creation

Run **after all system hardening is complete**.

From the repository root:

```bash
chmod +x scripts/hardening/aide-installation.sh
sudo ./scripts/hardening/aide-installation.sh
