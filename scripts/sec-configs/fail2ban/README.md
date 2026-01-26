Fail2Ban – SSH Brute-Force Protection
Purpose

Fail2Ban provides reactive protection against brute-force attacks by monitoring authentication failures and temporarily banning offending IP addresses.

In this repository, Fail2Ban is configured with a minimal, explicit policy focused on protecting SSH only.
The configuration is designed to be deterministic, systemd-based, and safe for Disaster Recovery.

What This Configuration Does

Enables Fail2Ban with a minimal configuration

Protects SSH (sshd) only

Uses systemd journal as log backend (no dependency on log files)

Automatically bans IPs after repeated failed login attempts

Policy Summary

Backend: systemd journal

Protected service: SSH

Max retries: 5 failed attempts

Find time: 10 minutes

Ban time: 1 hour

Prerequisites

Before applying Fail2Ban hardening:

SSH must already be hardened and working

Firewall (UFW) must already allow SSH

You must have active SSH access to the server

Fail2Ban does not replace SSH hardening or firewall rules. It complements them.

Repository Files

This setup uses the following files:

scripts/sec-configs/fail2ban/jail.local
Minimal Fail2Ban policy (SSHD only)

scripts/hardening/fail2ban-hardening.sh
Installs Fail2Ban and applies the configuration

No changes are made to /etc/fail2ban/jail.conf.

Apply Fail2Ban Hardening

From the repository root on the server:

chmod +x scripts/hardening/fail2ban-hardening.sh
sudo ./scripts/hardening/fail2ban-hardening.sh


The script will:

Install Fail2Ban if it is not present

Apply the repository-managed jail.local

Enable and restart the Fail2Ban service

Verify that the SSH jail is active

Verification

Check overall Fail2Ban status:

sudo fail2ban-client status


Verify that the SSH jail is active:

sudo fail2ban-client status sshd


Expected output includes:

Status for the jail: sshd

Currently banned: (0 or more)

Total banned: (increases during attacks)

Notes on Logging

This configuration uses the systemd journal backend.

This is expected behavior on modern Ubuntu systems and means:

No log files such as /var/log/auth.log are required

fail2ban-client get sshd logpath may show
No file is currently monitored

Fail2Ban reads logs via journalctl -u sshd

This is correct and intentional.

Safety Notes

Fail2Ban does not affect active SSH sessions

Bans are temporary and automatically expire

In the unlikely event of self-ban, access can be restored via console access

Design Decisions

Only SSH is protected to keep the baseline predictable

Defaults are overridden explicitly to avoid hidden behavior

Configuration is repository-managed and reproducible

No manual editing on the server is required

This approach ensures consistent behavior across restores and environments.

Result

After applying this configuration:

SSH brute-force attempts are automatically mitigated

Bans are enforced at the firewall level

The system remains fully accessible for legitimate users

The setup is suitable for long-term operation and Disaster Recovery