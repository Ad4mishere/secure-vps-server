# Auditd – System Auditing Baseline

## Purpose

Auditd provides low-level system auditing by recording security-relevant events at the kernel level.

This configuration establishes a **conservative audit baseline** focused on:
- identity changes
- privilege escalation
- SSH configuration changes
- system binary modifications

The goal is accountability and forensic visibility without excessive noise.

---

## What This Configuration Audits

### Identity and Authentication
- `/etc/passwd`
- `/etc/group`
- `/etc/shadow`
- `/etc/gshadow`

### Privilege Escalation
- `/etc/sudoers`
- `/etc/sudoers.d/`

### Remote Access Configuration
- `/etc/ssh/sshd_config`

### Core System Binaries
- `/bin`
- `/sbin`
- `/usr/bin`
- `/usr/sbin`

All rules monitor **write and attribute changes only**.

---

## Prerequisites

- Root access is required
- The system should already be hardened (SSH, firewall)
- This configuration is intended for VPS / server environments

---

## Repository Files

- `scripts/sec-configs/auditd/hardening.rules`  
  Persistent audit rules

- `scripts/hardening/auditd-hardening.sh`  
  Applies and loads the audit configuration

No changes are made to `/etc/audit/auditd.conf`.

---

## Apply Auditd Hardening

From the repository root:

```bash
chmod +x scripts/hardening/auditd-hardening.sh
sudo ./scripts/hardening/auditd-hardening.sh
