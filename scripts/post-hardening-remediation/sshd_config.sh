# Enter sshd_config file

Sudo nano /etc/ssh/sshd_config

# Add following

MACs hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,umac-128-etm@openssh.com
Compression no

# Reload SSH

sudo systemctl reload ssh
