# InfraDNA Bot 🧬

### **A Terraform fingerprinting bot to detect copy-pasted infrastructure, prevent configuration drift, and identify refactoring opportunities across multiple repositories.**

---

## The Problem

In large organizations, it's common for teams to copy-paste Terraform configurations for resources like VPCs, S3 buckets, or IAM roles. This leads to several critical issues:

- **Duplicated Misconfigurations:** A security vulnerability in one configuration gets copied to dozens of other places instantly.
- **Configuration Drift:** When the original configuration is updated or patched, the copies are often forgotten and left vulnerable.
- **Lack of Standardization:** It becomes impossible to enforce best practices or make architecture-wide changes efficiently.
- **Missed Updates:** Teams continue using outdated module versions or deprecated resources because there is no central visibility.

This project aims to solve these problems by automatically scanning all infrastructure code to find its "DNA" and flag these issues proactively.

---

## How It Works ⚙️

The bot follows a simple, powerful workflow to analyze infrastructure at scale:

1.  **SCAN:** Uses the GitHub CLI to discover all Terraform repositories within a specified organization or user account.
2.  **CLONE:** Downloads each repository to a temporary local workspace for analysis.
3.  **FINGERPRINT:** Parses `.tf` files to extract unique patterns ("fingerprints") based on resource configurations, provider versions, and naming conventions.
4.  **COMPARE & ALERT:** Compares all fingerprints stored in an SQLite database to find duplicates, outdated forks, and misconfigurations, then generates alerts and actionable insights.

---

## Tech Stack 🛠️

This bot is built with a simple, powerful, and ubiquitous tech stack.

- **Orchestration:** Bash
- **Repository Discovery:** GitHub CLI (`gh`)
- **Code Analysis:** Terraform & `jq`
- **Data Storage:** SQLite
- **Backend:** Python (Flask)
- **Frontend:** HTML, CSS, JavaScript
- **AI:** Open-Source LLM (e.g., Llama, BLOOM) for intelligent refactoring suggestions
- **Cloud:** Microsoft Azure

---

## Getting Started 🚀

### Prerequisites

Make sure you have the following tools installed on your local machine:

- **Git**
- **GitHub CLI (`gh`)**
- **Terraform**
- **jq**
- **Python 3.x**

### Setup & Usage

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/Puneetsharmatech/InfraDNA-bot.git](https://github.com/Puneetsharmatech/InfraDNA-bot.git)
    cd InfraDNA-bot
    ```

2.  **Authenticate with GitHub:** Make sure you are authenticated with the GitHub CLI.
    ```bash
    gh auth login
    ```

3.  **Install Python dependencies:**
    ```bash
    pip install -r requirements.txt
    ```

4.  **Run the bot:**
    ```bash
    chmod +x bot/infradna.sh
    ./bot/infradna.sh
    ```

---

## Roadmap 🗺️

This project is in active development. Future enhancements include:

- Implement the core fingerprinting logic.
- Integrate an open-source AI (LLM) model to provide intelligent refactoring suggestions and generate standardized module code.
- Build a simple dashboard using Python (Flask) to visualize findings and infrastructure patterns.
- Deploy the bot and dashboard to Microsoft Azure.
- Implement a CI/CD pipeline for continuous scanning.

---

## License 📄

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
