# Secure VPS Infrastructure - From Baseline Exposure to Automated Response

## Overview

This project documents the design and implementation of a publicly accessible Linux VPS, built and secured through a structured, end-to-end security lifecycle.

The objective was not only to harden a server, but to:

- Identify weaknesses through baseline testing
- Apply systematic hardening
- Verify improvements through re-testing
- Implement monitoring and intrusion detection
- Automate incident response
- Validate backup and recovery procedures

The result is a layered, production-inspired security architecture.

---

# Project Phases

## 1. Baseline Assessment

The VPS was initially deployed in a minimal configuration and assessed using penetration testing techniques.

The purpose was to:

- Identify exposed services
- Evaluate default configurations
- Document attack surface
- Establish a measurable security baseline

Findings from this phase guided the hardening strategy.

---

## 2. Server Hardening

Security improvements included:

- Secure SSH configuration and access restrictions
- Firewall enforcement using UFW
- Removal of unnecessary services
- Principle of least exposure
- Reverse proxy architecture with TLS termination

After hardening, a second penetration test was performed to validate improvements and confirm risk reduction.

---

## 3. Logging and Monitoring

Centralized monitoring was implemented using Grafana dashboards and alerting rules.

Features include:

- Threshold-based alert logic
- Email notifications
- Structured log visibility
- Clear separation between detection and enforcement

This established visibility before introducing automation.

---

## 4. Intrusion Detection and SOAR Automation

Suricata IDS was deployed to detect suspicious traffic patterns.

A Python-based webhook service was implemented to enable automated response:

- Receives alert payload from Grafana
- Validates API key
- Extracts source IP
- Inserts dynamic deny rule into UFW
- Logs incident locally
- Runs as a systemd-managed service

```text
This creates a complete detection-to-response pipeline:

Detection → Alert → Webhook → Firewall Enforcement
```

The enforcement is persistent and survives system reboot.

---

## 5. Reverse Proxy and Service Isolation

To enforce proper perimeter architecture:

- Nginx acts as a single ingress point on port 443
- TLS termination is centralized
- All internal services bind to 127.0.0.1
- No management ports are publicly exposed

This ensures clear segmentation between public access and internal components.

---

## 6. Backup and Disaster Recovery

A backup and restore procedure was implemented and tested.

The recovery process was verified to ensure:

- Data integrity
- Service continuity
- Operational resilience

Security controls were therefore complemented by recovery capability.

---

# Security Design Principles Applied

- Defense in depth
- Separation of responsibilities
- Least privilege / least exposure
- Persistent enforcement
- Verification through re-testing
- Observable and auditable response

---

# Technologies Used

- Ubuntu Linux
- Nginx
- UFW
- Suricata
- Grafana
- Docker
- Python (Flask)
- systemd

---

# Outcome

The final system demonstrates:

- Measurable security improvement from baseline to hardened state
- Continuous monitoring and alerting
- Automated firewall-level incident response
- Segmented reverse proxy architecture
- Tested backup and recovery capability
- Full documentation of security decisions and validation steps

This project reflects practical application of infrastructure security, monitoring, and automated response in a controlled but realistic VPS environment.