0. Scope and Planning

0.1 Project Scope

This project focuses on practical infrastructure and operational security in a production-like Linux server environment. The work examines how a server exposed to realistic network conditions can be secured, monitored, and operated using security-first and defense-in-depth principles.

All project activities are conducted in locally hosted virtual machines. The virtualized environment is intentionally designed to replicate a real-world Virtual Private Server (VPS) scenario, including public-facing services, realistic network exposure, and operational security controls. This approach enables controlled experimentation, repeatability, and safe execution of security testing while maintaining relevance to real production environments where web services and applications are deployed.

The project covers the full lifecycle of infrastructure security, including initial deployment, baseline assessment, hardening, verification, monitoring, detection, response, and recovery.

The primary scope of the project includes:

Deployment and operation of a Linux-based server environment

Configuration and exposure of core services such as SSH and a web server

Identification and analysis of the system’s attack surface

Security assessment of the environment in an initial, un-hardened state

Implementation of targeted hardening measures at the operating system, network, and service levels

Verification of security improvements through repeated testing using consistent methods

Implementation of logging, monitoring, and alerting mechanisms

Deployment of intrusion detection and prevention mechanisms

Automation of selected security and response actions

Implementation and validation of backup and recovery procedures

The project is iterative in nature, and the depth of individual components may vary depending on progress, while maintaining a consistent and methodical approach.

0.2 Out of Scope

The project does not aim to perform comprehensive application security assessments or detailed vulnerability research at the application level. The following activities are explicitly out of scope as primary objectives:

Source code review or application logic analysis

Secure software development or remediation of application vulnerabilities

Detailed exploitation of application-layer vulnerabilities

Development of custom exploits

Unauthorized testing of third-party systems

Application security is not evaluated as a standalone goal, and no conclusions are drawn regarding the security posture of specific applications.

0.3 Application-Layer Activity and Controlled Attack Simulation

Although application security is not a primary focus, controlled application-layer attack simulations may be performed in isolated test environments.

These activities are used exclusively to:

Generate realistic malicious or suspicious traffic

Validate intrusion detection and prevention mechanisms

Verify logging, alerting, and automated response capabilities

Observe how infrastructure-level security controls react to attack patterns

The objective of these simulations is not to assess or improve application security, but to evaluate the effectiveness of infrastructure-level detection and response mechanisms. The application environments used for this purpose are treated as disposable and interchangeable and serve only as traffic generators for security testing.

0.4 Definition of “Pentest” in This Project

In this project, the term penetration testing (pentest) refers to a controlled, non-destructive security assessment of the server environment. Pentest activities are used to identify exposure, misconfigurations, and weaknesses at the infrastructure level without performing full exploitation.

Pentest activities may include:

Port and service scanning

Service and version identification

Vulnerability scanning

System and configuration analysis

Controlled attack simulations designed to test detection and response

All pentest activities are conducted solely against environments owned and operated as part of the project and are intended to support risk assessment, hardening decisions, and verification of security controls.

0.5 Objectives and Expected Outcomes

The primary objective of the project is to demonstrate practical competence in securing, operating, and monitoring a Linux-based server environment under realistic conditions.

The project aims to demonstrate the ability to:

Identify and reason about attack surfaces and infrastructure-level risk

Apply targeted hardening measures based on observed weaknesses

Verify security improvements through repeatable testing

Detect, log, and respond to suspicious or malicious activity

Automate selected security and response mechanisms

Design for availability, resilience, and recovery

The expected outcomes of the project include:

A measurable reduction of the system’s exposed attack surface

Improved resilience against common attack techniques

Verified detection and response to simulated attacks

Documented logs, alerts, and response actions

A functional and tested backup and recovery solution

Clear and reproducible documentation of methods and results 