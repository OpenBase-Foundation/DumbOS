# Security Policy

## Supported Versions

Use this section to tell people about which versions of your project are
currently being supported with security updates.

| Version | Supported          |
| ------- | ------------------ |
| 5.1.x   | :white_check_mark: |
| 5.0.x   | :x:                |
| 4.0.x   | :white_check_mark: |
| < 4.0   | :x:                |

> Note: The versions above are an example table provided in the request. If you
> want this project to list specific DumbOS versions, we can replace the table
> with the actual supported versions (for example: `1.1.x`, `1.0.x`, etc.).

## Reporting a Vulnerability

If you believe you've found a security vulnerability in DumbOS, please report it
privately so we can investigate and fix it before details are publicly disclosed.

Preferred reporting methods (in order):

1. GitHub Security Advisories
   - If you have access to create a security advisory for this repository,
     please use GitHub Security Advisories: https://github.com/OpenBase-Foundation/DumbOS/security/advisories
   - This allows us to triage the issue privately and coordinate disclosure.

2. Email (private)
   - Send an email to: security@openbase.foundation
   - Please include:
     - Affected version(s) of DumbOS
     - Clear, reproducible steps to trigger the issue
     - Impact or severity assessment (remote code execution, local privilege
       escalation, data leak, etc.)
     - Any proof-of-concept (PoC) code or logs (if available)
     - How we can contact you for clarifying questions (optional)

3. If neither option is available, open a private issue (marked "security") or
   create a normal GitHub issue but DO NOT include exploit code or PoC publicly.
   After creating the issue, email `security@openbase.foundation` with the issue
   link and mark it as Security.

### What to expect after reporting

- Acknowledgement: We will acknowledge receipt of your report within 48 hours.
- Triage: We will triage the issue and provide an initial severity assessment within
  5 business days (often sooner).
- Communication: We will keep you updated on progress at least weekly while the
  issue is being investigated and fixed.
- Fix and Disclosure: We will coordinate a responsible disclosure timeline. For
  accepted vulnerabilities, we aim to provide a fix or mitigation within 90 days
  depending on complexity and severity. If a faster timeline is required due to
  high severity, we'll prioritize accordingly.
- Credit: If you request to be credited and provided a public handle or name, we
  will include you in the acknowledgements unless you ask to remain anonymous.

## Severity & CVE

- For issues that meet criteria for a CVE, we will request a CVE identifier and
  include it in the advisory and release notes.
- Severity will be determined using CVSS v3 where applicable, and we will share
  our CVSS assessment in the advisory.

## Disclosure Policy

- We follow a coordinated disclosure process. We will not publicly disclose
  technical details until a fix or mitigation is available, except in cases of
  imminent public risk where emergency disclosure is necessary.
- If you are planning to disclose an issue publicly, please contact us first so
  we can coordinate and ensure users have mitigations or fixes available.

## Contact & Response Times (Summary)

- Acknowledgement: within 48 hours
- Initial triage/assessment: within 5 business days
- Regular status updates: at least weekly
- Target for fix/mitigation: within 90 days for typical issues (may vary)

---

If you'd like the e-mail address or timeframes changed, or prefer to only accept
reports via GitHub Security Advisories, tell me which method and I'll update the
file accordingly.
