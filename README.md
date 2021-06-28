# HighROI
Application high availability in 24 hours by using IBM Cloud services

## Details of Proposed Solution and Outcome
This infrastructure on cloud is a working solution illustration used by many IBM financial domain customers. The solution demonstrates an Infrastructure as Code by using IBM Cloud services to setup [IBM Sterling B2B Integrator](https://www.ibm.com/products/global-mailbox) supporting Global Mailbox. Once of the main feature of the Global Mailbox is to achieve highly available, always-on file transfer operations  between nodes and data centres. The product also administers the transaction mailboxes, messages, permissions, virtual routes, event rules.

**Architecture**
Solution architecture by using IBM Cloud services:

![HackathonArch_design](/HackathonArch_design.png)

Architecture flow:

- User access the application through URL.
- Watchdog is the monitor tool that runs as part of the OS monitoring agent process for the two hosts. Watchdog agent is named as proxy agent service for AppReplica1 and AppRelica2 hosts.  The watchdog starts by default when the hosts are started. If the AppReplica1 process or connection fails watchdog monitors the logs and automatically redirects to the AppReplica2 host to process.
- GPFS is a high performance computing file system distributes and manage the data across multiple servers, and is implemented by python (Terraform) resources.

## Technologies/Skills required
Following IBM Cloud offerings and technologies are used for the solution.

- IBM Cloud Provider for Terraform
- IBM Cloud VSI using RedHat OpenShift
- IBM Cloud Kubernetes
- IBM HTTPd server
- GoLang
- Python and Flask app 
- IBM GPFS (Spectrum Scale) service


## How does this impact client/business?
- High time to value add to our financial customer and to our IBM Sterling B2B Integrator solution team.
- This product is currently used by more than 30000 customers, first highest clients in US and second higher clients in Japan.

### Github Repository for Solution

Solution Git: https://github.com/VaishnaviGopal/HighROI 

### Team Name: HighROI
1. @ggovindraj
2. @guvaish1
3. @deepusi1
4. @hariharan
