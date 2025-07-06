# InfraDNA Bot 

A Terraform fingerprinting bot to detect copy-pasted infrastructure, prevent configuration drift, and identify refactoring opportunities across multiple repositories.

---

## The Problem

In large organizations, it's common for teams to copy-paste Terraform configurations for resources like VPCs, S3 buckets, or IAM roles. This leads to several critical issues:

* **Duplicated Misconfigurations:** A security vulnerability in one configuration gets copied to dozens of other places instantly.
* **Configuration Drift:** When the original configuration is updated or patched, the copies are often forgotten and left vulnerable.
* **Lack of Standardization:** It becomes impossible to enforce best practices or make architecture-wide changes efficiently.
* **Missed Updates:** Teams continue using outdated module versions or deprecated resources because there is no central visibility.

This project aims to solve these problems by automatically scanning all infrastructure code to find its "DNA" and flag these issues proactively.

---

## How It Works

The bot follows a simple, powerful workflow to analyze infrastructure at scale:

1.  **SCAN:** Uses the GitHub CLI to discover all Terraform repositories within a specified organization or user account.
2.  **CLONE:** Downloads each repository to a temporary local workspace for analysis.
3.  **FINGERPRINT (In Development):** Parses `.tf` files to extract unique patterns ("fingerprints") based on resource configurations, provider versions, and naming conventions.
4.  **COMPARE & ALERT (In Development):** Compares all fingerprints stored in a database (CSV/SQLite) to find duplicates, outdated forks, and misconfigurations, then generates alerts.

---

## Tech Stack

This bot is built with simple, powerful, and ubiquitous command-line tools.

* **Orchestration:** `Bash`
* **Repository Discovery:** `GitHub CLI`
* **Code Analysis:** `Terraform` & `jq`
* **Version Control:** `Git`

---

## Getting Started

### Prerequisites

Make sure you have the following tools installed on your local machine:

* [Git](https://git-scm.com/downloads)
* [GitHub CLI (`gh`)](https://cli.github.com/)
* [Terraform](https://developer.hashicorp.com/terraform/downloads)
* [jq](https://jqlang.github.io/jq/download/)

### Setup & Usage

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/Puneetsharmatech/InfraDNA-bot.git](https://github.com/Puneetsharmatech/InfraDNA-bot.git)
    cd InfraDNA-bot
    ```

2.  **Authenticate with GitHub:**
    Make sure you are authenticated with the GitHub CLI.
    ```bash
    gh auth login
    ```

3.  **Run the bot:**
    Make the script executable and run it.
    ```bash
    chmod +x bot/infradna.sh
    ./bot/infradna.sh
    ```

---

## Roadmap

This project is currently in its initial development phase. Future enhancements include:

* [ ] Implement core fingerprinting logic using `terraform plan` and `jq`.
* [ ] Store and compare fingerprints in a simple database (CSV or SQLite).
* [ ] Generate alerts for duplicate and outdated infrastructure.
* [ ] **Integrate an AI (LLM) model** to provide intelligent refactoring suggestions and generate standardized module code.
* [ ] Build a simple dashboard to visualize findings and infrastructure patterns.

---

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.
