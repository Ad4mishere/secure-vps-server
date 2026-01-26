# AppArmor Hardening

## Purpose

AppArmor is used to provide **mandatory access control (MAC)** for system services and applications.

The purpose of this hardening step is to:

- Ensure AppArmor is enabled and enforced
- Load and apply existing, vendor-provided profiles
- Avoid breaking production services by over-restricting applications

This configuration prioritizes **stability and maintainability** over aggressive confinement.

---

## Scope

This hardening step:

- Verifies that AppArmor is enabled at boot
- Ensures AppArmor profiles are loaded
- Enforces existing profiles where available
- Uses distribution-provided profiles only

This hardening does **not**:

- Create custom AppArmor profiles
- Force all applications into enforce mode
- Modify or weaken existing profiles
- Attempt blanket confinement of user applications

These exclusions are **intentional design decisions**.

---

## Current State

AppArmor is:

- Enabled and loaded at boot
- Actively enforcing profiles for core system services
- Running with a mix of:
  - `enforce` mode (critical services)
  - `complain` mode (known compatibility cases)
  - `unconfined` mode (desktop and non-critical applications)

This reflects the default, supported security posture of Ubuntu.

Verification command:

```bash
sudo aa-status
