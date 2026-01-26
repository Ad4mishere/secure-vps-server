## Config files

These files reflect real-world service configuration names
and formats, preserved for clarity and reproducibility.

Secure VPS Lab - End-to-End Infrastructure Security Project
Overview

This repository documents a complete end-to-end security project focused on securing, operating, and monitoring a public-facing Linux VPS.

The project follows the full lifecycle of infrastructure security:

initial deployment in an intentionally insecure state

baseline security assessment and attack surface mapping

systematic server hardening

verification through repeated security testing

backup and recovery validation

expansion into logging, monitoring, IDS/IPS, automation, and controlled attack simulation

The lab is designed to reflect real-world security engineering and operational practices, not theoretical or checklist-based security.

## Project status

This project is actively developed in phases.

Completed:
- Initial VPS deployment
- Baseline attack surface mapping
- Initial vulnerability assessment and documentation
- Server hardening after initial vulnerability assessment
- Post vulnerability assessment and documentation
- Post vulnerability remediation of left over security risks
- Backups and restoration


In progress:
- Logging and Monitoring
- IDS/IPS automation

Planned:
- SOAR-like response automation
- Owasp Juice Shop pentest
- Dokumentation of Results från Owasp pentest



Project goals

The primary goals of this project are to demonstrate the ability to:

deploy and operate a Linux server exposed to the internet

identify and analyze an attack surface

reduce risk through targeted hardening measures

verify security improvements using consistent testing

automate security-critical operations

design for availability and recovery

extend the environment into monitoring, detection, and response

document security work clearly and professionally

This repository represents a hands-on security lab, built to showcase practical IT-security competence.

Environment

Virtual Private Server (VPS)

Linux (Ubuntu)

Publicly exposed services (SSH, HTTP/HTTPS)

Nginx web server

Internet-reachable attack surface

The environment is intentionally designed to be realistic and production-like.

Scope and focus
In scope

Server and operating system security

Network exposure and firewalling

Secure remote access (SSH)

Web server hardening

Vulnerability assessment and verification

Security automation

Logging, monitoring, and alerting

IDS / IPS deployment

SOAR-like response automation

Backup and restore testing

Controlled attack simulation in isolated environments

Out of scope (by design)

Application-layer vulnerability research (e.g. SQL injection, XSS)

Exploit development

Production exploitation of vulnerabilities

These boundaries are intentional to maintain focus on infrastructure and operational security.

Tools and technologies

The project makes use of commonly used, industry-relevant tools:

Nmap

OpenVAS / Greenbone

Lynis

curl

UFW / iptables

OpenSSH

Fail2ban

Certbot (Let’s Encrypt)

rsync / tar / cron

Docker

OWASP Juice Shop

Suricata or Snort

Grafana / ELK / Loki (logging & monitoring)

Bash scripting

## Repository structure

```text
secure-vps-lab/
├── README.md
├── docs/
│   ├── 00-scope-and-planning.md
│   ├── 01-initial-installation.md
│   ├── 02-baseline-pentest.md
│   ├── 03-server-hardening.md
│   ├── 04-post-hardening-pentest.md
│   ├── 05-backup-and-restore.md
│   ├── 06-logging-and-monitoring.md
│   ├── 07-ids-ips.md
│   ├── 08-soar-automation.md
│   ├── 09-owasp-juice-shop-lab.md
│   └── 10-portfolio-presentation.md
├── scripts/
│   ├── hardening/
│   ├── backup/
│   ├── monitoring/
│   └── automation/
├── configs/
├── screenshots/
├── diagrams/
└── assets/
```

Documentation guide:

Screenshots are used as primary evidence for executed commands and validation steps, while selected commands are included inline where they support methodological clarity.

Each document in the docs/ directory represents a distinct phase of the project:

Scope & Planning
Defines objectives, boundaries, and methodology.

Initial Installation
Documents the deployment of the VPS and services in an intentionally insecure baseline state.

Baseline Pentest
Maps the initial attack surface using port scanning, vulnerability scanning, and system analysis.

Server Hardening
Details all security improvements applied to reduce exposure and mitigate identified risks.

Post-Hardening Pentest
Repeats the same security tests to verify the effectiveness of hardening measures.

Backup & Restore
Demonstrates operational resilience through automated backups and restore testing.

Logging & Monitoring
Introduces centralized logging, dashboards, and alerting.

IDS / IPS
Adds network-based intrusion detection and prevention.

SOAR-Like Automation
Implements automated response actions based on detected events.

OWASP Juice Shop Lab
Uses an isolated, intentionally vulnerable application to validate detection and response mechanisms.

Portfolio Presentation
Summarizes the project for CVs, interviews, and technical discussions.

What this project demonstrates

This lab demonstrates the ability to:

think in terms of attack surfaces and risk

work methodically rather than reactively

validate security improvements with evidence

automate security-critical operations

design for recovery and availability

extend a secure baseline into detection and response

communicate security work clearly and professionally

Disclaimer

This repository is intended for educational and portfolio purposes only.
All sensitive information has been removed or anonymized.
No unauthorized testing has been performed against third-party systems.