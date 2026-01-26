SSH – Initial Access, Key Setup & Hardening
Purpose

This repository hardens SSH by disabling password authentication and root login.

To avoid administrative lockout, SSH key-based authentication must be configured and verified before running any hardening scripts.

Hardening scripts are fully automated and do not create or deploy SSH keys.

Important – Read Before You Start

Before running SSH hardening, all of the following must be true:

You can log in using an SSH key

Login works without a password

You keep one active SSH session open during hardening

If these conditions are not met, you will lock yourself out.

Phase 0 – Install SSH (if not already installed)

On a fresh VPS, SSH may not be installed by default.
You need console access (VM console / provider console) for this step.

sudo apt update
sudo apt install -y openssh-server
sudo systemctl enable ssh
sudo systemctl start ssh


Verify that SSH is running:

systemctl status ssh

Phase 1 – Generate SSH Key (Local Machine)

Run this on your local machine, not on the VPS.

ssh-keygen -t ed25519 -C "server"


Use the default path: ~/.ssh/id_ed25519

Protect the private key with a strong passphrase

Phase 2 – Deploy Public Key to the VPS

At this stage, password-based login must still be enabled temporarily.

Windows (PowerShell)

ssh-copy-id is not available on Windows. Use this instead:

type $env:USERPROFILE\.ssh\id_ed25519.pub | ssh USER@SERVERIP "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"


You will be prompted for the password one last time.

Linux / macOS

Preferred method:

ssh-copy-id USER@SERVER_IP


If ssh-copy-id is not available:

cat ~/.ssh/id_ed25519.pub | ssh USER@SERVER_IP "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"

Phase 3 – Verify Key-Based Authentication

Open a new terminal and test:

ssh USER@SERVER_IP


Login must succeed without a password prompt.
If a password is requested, stop and fix this before continuing.

Phase 4 – Clone Repository

Once key-based authentication works, clone the repository on the VPS:

git clone https://github.com/YOUR-ORG/secure-vps-server.git
cd secure-vps-server


Verify required files:

ls scripts/hardening/ssh-hardening.sh
ls scripts/sec-configs/ssh/sshd_config

Phase 5 – Run SSH Hardening

From the repository root:

chmod +x scripts/hardening/ssh-hardening.sh
sudo ./scripts/hardening/ssh-hardening.sh

Verification (Recommended)
sudo sshd -T | grep -E "permitrootlogin|maxauthtries|passwordauthentication"


Also verify that a new SSH session still works.

Design Notes

SSH key generation is manual by design

Key deployment is documented, not automated

Hardening scripts are non-interactive, deterministic, and DR-safe