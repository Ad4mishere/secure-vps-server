# Kernel / OS Hardening

## Purpose

This step hardens the Linux kernel and network stack by applying a minimal,
server-safe set of sysctl parameters.

The goal is to reduce information leakage and common network attack vectors
without impacting system stability or services.

---

## What Is Hardened

### Kernel Protections
- Kernel pointer exposure is restricted
- dmesg output is limited to privileged users
- Performance event access is restricted

### Network Protections
- Reverse path filtering enabled (anti-spoofing)
- ICMP redirects disabled
- Source routing disabled

No experimental or aggressive kernel settings are used.

---

## Repository Files

- `sec-configs/sysctl/99-hardening.conf`  
  Persistent kernel hardening policy

- `scripts/hardening/sysctl-hardening.sh`  
  Applies the sysctl configuration safely

---

## Apply Kernel Hardening

From the repository root:

```bash
chmod +x scripts/hardening/sysctl-hardening.sh
sudo ./scripts/hardening/sysctl-hardening.sh
