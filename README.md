# HighROI
Application high availability data centers in 24 hours by using IBM cloud services

## Details of Proposed Solution and Outcome
This infrastructure on cloud is a working solution illustration used by many IBM financial domain customers. The solution create an Infrastructure as Code by using IBM Cloud services to setup IBM Sterling B2B Integrator supporting Global Mailbox.  Once of the main feature of the Global Mailbox is supporting the replication of the files between data centres and administers the transaction mailboxes, messages, permissions, virtual routes, event rules. For more information, about the product, refer to  Global Mailbox management tool. 

**Architecture**
Solution architecture by using IBM Cloud offerings:

![HackathonArch_design](/HackathonArch_design.png)

Detailed architecture flow:

- User access the application through URL.
- Watchdog is the monitor tool that runs as part of the OS monitoring agent process for the two hosts. Watchdog agent is named as proxy agent service for AppReplica1 and AppRelica2 hosts.  The watchdog starts by default when the hosts are started. If the AppReplica1 process or connection fails watchdog monitors the logs and automatically redirects to the AppReplica2 host to process.
- GPFS is a high performance computing file system distributes and manage the data across multiple servers, and is implemented by python (Terraform) resources.

## Technologies/Skills required
Following IBM Cloud offerings and technologies are used for the solution.
- IBM Cloud Provider for Terraform
- IBM Cloud Kubernetes
- IBM HTTPd server
- GoLang/Python
- IBM GPFS service


## How does this impact client/business?
This infrastructure can be used by the banking solution team at IBM to cater their financial customers such as Banks without any interruption during the failure in the data centers.
### Github Repository for Solution
<!-- When available, provide a link to your GitHub repository that will hold your solution assets; code, documentation, data set, design thinking artifacts, etc. -->
### Team Name: HighROI
1. @ggovindraj
2. @guvaish1
3. @deepusi1
4. @hariharan
