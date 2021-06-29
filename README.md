# HighROI
Port based secured app high availability 24/7 by using IBM Cloud services
## Details of Proposed Solution and Outcome
This infrastructure on cloud is a working solution illustration used by many IBM financial domain customers. The solution demonstrates an Infrastructure as Code by using IBM Cloud services to setup any highly available application that always on file transfer operations between nodes and data centres through secured File Gateway.
Challenge/Problem statement


**Architecture**
Solution architecture by using IBM Cloud services:

![Arch_design](/diagrams/Arch_design.png)

Architecture flow:

- User access the application through URL.
- Watchdog is the monitor tool that runs as part of the OS monitoring agent process for the two hosts. Watchdog agent is named as proxy agent service for AppReplica1 and AppRelica2 hosts.  The watchdog starts by default when the hosts are started. If the AppReplica1 process or connection fails watchdog monitors the logs and automatically redirects to the AppReplica2 host to process.
- GPFS is a high performance computing file system distributes and manage the data across multiple servers, and is implemented by python (Terraform) resources.

## Technologies/Skills required
Following IBM Cloud offerings and technologies are used for the solution.

- IBM Cloud Provider for Terraform
- IBM Cloud VSI using RedHat OpenShift
- IBM HTTPd server
- Python and Flask app 
- IBM GPFS (Spectrum Scale) service


## How does this impact client/business?
- High time to value add to our financial customer and IBM solution team, for example, can be used in FS Cloud regulations and by other financial customers.
### Github Repository for Solution

Solution Git: https://github.com/VaishnaviGopal/HighROI 

### Team Name: HighROI
1. @ggovindraj
2. @guvaish1
3. @deepusi1
4. @hariharan
