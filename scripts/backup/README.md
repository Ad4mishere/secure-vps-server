# Backup Script - Local and External Backup

This directory contains the backup automation script used to perform both local
and external backups of a hardened VPS server.

The backup process is intentionally simple, transparent, and deterministic.
All logic is executed from the primary server. The backup server acts only as
a passive storage endpoint.

---

## Script Overview

Script name:
- `backup.sh`

Execution context:
- Must be executed as root
- Intended to be run manually or via cron

The script performs the following actions:

1. Creates a date-based local backup snapshot
2. Updates a `latest` symlink pointing to the newest backup
3. Enforces a fixed retention policy (default: 7 days)
4. Replicates the latest backup to an external backup server using rsync over SSH

---

## Mandatory Configuration (Before First Run)

Before running the script, you **must** edit the configuration section at the top
of `backup.sh`.

Open the script:

```bash
nano scripts/backup/backup.sh
Verify and update the following variables:

REMOTE_USER="backupuser"
REMOTE_HOST="BACKUP_SERVER_IP"
REMOTE_BASE="/backup/vps-server"
REMOTE_USER
Dedicated non-privileged user on the backup server

REMOTE_HOST
IP address or hostname of the backup server

REMOTE_BASE
Target directory on the backup server (must exist and be owned by REMOTE_USER)

The script will fail if these values are incorrect.

SSH Authentication Requirements
SSH key-based authentication must be configured

Password-based authentication should be disabled after key deployment

The backup server must not require sudo access for the backup user

The primary server initiates all connections.

Local Backup Structure
Local backups are stored under:

/backup/daily/YYYY-MM-DD
A symbolic link is maintained:

/backup/latest -> /backup/daily/YYYY-MM-DD
This simplifies verification and restore operations.

Data Included in Backup
The script backs up only persistent and non-regenerable data, including:

/etc/nginx

/etc/ssl/private

/etc/letsencrypt (if present)

/home

/root

/var/www

/usr/local

/backup/package-list.txt

Dynamic system paths are explicitly excluded.

Retention Policy
Backups are retained for 7 days

Older backups are automatically deleted

Retention is enforced on every run

Automation (Optional)
The script is designed to be executed via cron.

Example cron configuration:

0 02 * * * /scripts/backup/backup.sh
Ensure the script is executable:

chmod 700 scripts/backup/backup.sh
Logging and Verification
The script outputs clear status messages to stdout.
When executed via cron, execution can be verified through system logs.

Design Philosophy
No backup logic runs on the backup server

No runtime-generated data is preserved

Configuration and data are restored separately

Predictability and auditability are prioritized over complexity

# Restore Procedure – Manual Disaster Recovery

This directory documents the restore process for the backup system.

The restore phase is intentionally **not fully automated**. While automation is appropriate for backups, restoration is performed manually to ensure safety, flexibility, and administrative control.

## Why Restore Is Manual

Restore operations vary significantly depending on:

- System architecture
- Installed services
- File ownership models
- Security controls
- Deployment context

Automating restore logic could introduce risks such as:
- Overwriting valid system data
- Incorrect permissions
- Service misconfiguration
- Irreversible system state changes

For these reasons, restore is documented as a **guided manual process**.

---

## restore.sh – Reference Script

The `restore.sh` file serves as a **reference checklist**, not a one-click restore script.

It contains:
- Ordered restore steps
- Example commands
- Validation checks

Administrators are expected to:
- Review each command
- Adjust paths and values to their environment
- Execute commands manually

---

## Typical Restore Flow

1. Install required packages (nginx, rsync, etc.)
2. Retrieve backup from backup server
3. Restore application data
4. Restore service configuration
5. Restore certificates
6. Validate configuration
7. Start services
8. Verify functionality

---

## Important Notes

- Paths and service names may differ between systems
- Certificates may vary (self-signed vs Let's Encrypt)
- Permissions must always be validated manually
- Restore should be tested before production use

This approach prioritizes correctness and security over automation convenience.
