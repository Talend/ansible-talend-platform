# Ansible framework for Talend Platform

This repository contains [Ansible](https://www.ansible.com/) roles and playbooks to deploy, manage, and configure the [Talend](https://www.talend.com) Platform services.

> **Note**: These playbooks are provided without support and are intended to be a guideline. Any issue encountered can be reported via GitHub and will be addressed on a best effort basis. Pull requests are also encouraged.

Specifically, this repository, through its playblooks:

* Installs Talend 7.1, 7.2 or 7.3 RPM packages.
* Starts services using systemd scripts.
* Provides configuration options for Talend packages.

You can find detailed documentation about each RPM package delivered by Talend and their related services in [Talend Help Center](https://help.talend.com/search/all?query=rpm&content-lang=en-US).

## Prerequisites

To be able to install applications using Ansible, you need to setup your environment as follows:

1. Install Extra Packages for Enterprise Linux: <br/> `sudo yum install epel-release`
2. Install [Ansible](https://www.ansible.com/) on the master host used for the deployment: <br/> `sudo yum install ansible`
3. All hosts need to be reachable via SSH from the master node. Hosts must be defined in `/etc/ansible/hosts` on the master node.

Installing Talend applications using Ansible require CentOS 7.X as operating system.

## Installing applications using Ansible

1. Specify your credentials and the version of Talend applications to install in the *ansible/group_vars/all* file. These parameters are used to access the RPM repository.
To change the RPM version to install, edit the following parameters:
    * 7.1 applications:
    ```
    rpm_base_version: 7.1
    rpm_patch_version: 1
    rpm_build_number: 201810261147
    ```
    * 7.2 applications:
    ```
    rpm_base_version: 7.2
    rpm_patch_version: 1
    rpm_build_number: 201906201446
    ```
    * 7.3 applications:
    ```
    rpm_base_version: 7.3
    rpm_patch_version: 1
    rpm_build_number: 202002191130
    ```

2. Configure the playbook you want to install by specifying:
    1. the **hosts** to install the roles on. Hosts must be defined in `/etc/ansible/hosts` on the master node.
    2. the **remote_user** name. Make sure that the user has the required permissions to install applications on all hosts.
    3. the **roles** to install, by installation order.
    4. the **vars** to overwrite with a new value for that specific playbook. Adding variables to the playbook is optional.

    For example:

    ```yml
      hosts: tac-group
      remote_user: root
      roles:
        - java
        - talend-repo
        - runtime
      vars:
        rt_http_port: 8041
        rt_https_port: 9002
        rt_ssh_port: 8102
        rt_rmi_registry_port: 1100
        rt_rmi_server_port: 44445
        rt_js_command_server_port: 8010
        rt_js_file_server_port: 8011
        rt_js_monitoring_port: 8898
        rt_js_process_message_port: 8556
        rt_master_password: 'password'
    ```

    Sample playbooks are available [here](ansible/examples) or [here](ansible).

3. Configure the installation parameters as well as the configuration of each role using their respective *defaults/main.yml* file. <br/> Variables can be overwritten if they are set differently directly in the playbook.
4. Run the playbook: <br/> `ansible-playbook <playbook>.yml`

> **Important**: Always include **java** and then **talend-repo** roles in as first roles in playbooks. If Tomcat is needed for the set of roles that are installed, also include the **tomcat** role between **talend-repo** and the following roles.


## Uninstalling applications

You can remove installed applications using `sudo yum remove <list_of_packages>` manually on every host.

The list of packages can be received by executing the command `rpm -qa | grep talend`.

## List of applications

The following applications can be installed from this repository using their dedicated Ansible role:

| Role                                           | Application                                                                                                                                |
| ---------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| [tac](ansible/roles/tac)                       | Talend Administration Center (TAC)                                                                                                         |
| [iam](ansible/roles/iam)                       | Talend Identity and Access Management (IAM) service                                                                                        |
| [mdm](ansible/roles/mdm)                       | Talend Master Data Management (MDM)                                                                                                        |
| [amc](ansible/roles/amc)                       | Talend Activity Monitoring Console (AMC)                                                                                                   |
| [logserver](ansible/roles/logserver)           | Talend Log Server                                                                                                                          |
| [jobserver](ansible/roles/jobserver)           | Talend Job Server                                                                                                                          |
| [repo-mgr](ansible/roles/repo-mgr)             | Talend Repository Manager                                                                                                                  |
| [runtime](ansible/roles/runtime)               | Talend Runtime server                                                                                                                      |
| [tdp](ansible/roles/tdp)                       | Talend Data Preparation (requires [sjs](ansible/roles/sjs), [tcomp](ansible/roles/tcomp) and [streamsrunner](ansible/roles/streamsrunner)) |
| [sjs](ansible/roles/sjs)                       | Spark Job Server                                                                                                                           |
| [streamsrunner](ansible/roles/streamsrunner)   | Streams Runner                                                                                                                             |
| [tcomp](ansible/roles/tcomp)                   | Talend Component Server                                                                                                                    |
| [tds](ansible/roles/tds)                       | Talend Data Stewardship (TDS)                                                                                                              |
| [tsd](ansible/roles/tsd)                       | Talend Dictionary Service (TSD)                                                                                                            |
| [sap-rfc-server](ansible/roles/sap-rfc-server) | Talend SAP RFC Server                                                                                                                      |
| [filebeat](ansible/roles/filebeat)             | Talend Filebeat service                                                                                                                    |

The following roles install third-party components:

| Role                             | Application                                                                                                                                 |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| [tomcat](ansible/roles/tomcat)   | Apache Tomcat server (required by [tac](ansible/roles/tac), [iam](ansible/roles/iam), [tds](ansible/roles/tds), [tsd](ansible/roles/tsd)) |
| [mongodb](ansible/roles/mongodb) | MongoDB server (required by [tds](ansible/roles/tds), [tdp](ansible/roles/tdp), [tsd](ansible/roles/tsd))                                   |
| [kafka](ansible/roles/kafka)     | Apache Kafka server (required by [tds](ansible/roles/tds), [tdp](ansible/roles/tdp), [tsd](ansible/roles/tsd))                              |
| [nexus](ansible/roles/nexus)     | Nexus Repository Manager                                                                                                                    |
| [minio](ansible/roles/minio)     | MinIO server (required by [tsd](ansible/roles/tsd), [tds](ansible/roles/tds), [tdp](ansible/roles/tdp) )                                    |

## List of applications compatible with Talend Cloud Hybrid setup

Talend Cloud lets you install and host Talend Data Preparation ([tdp](ansible/roles/tdp)), Talend Data Stewardship ([tds](ansible/roles/tds)) and Talend Dictionary Service [tsd](ansible/roles/tsd) on premises. This setup allows you to store sensitive data behind your firewall, while still managing your users and the rest of your platform from Talend Cloud.

Ansible roles corresponding to these applications are compatible with the Hybrid setup for Talend Cloud. See dedicated hybrid parameters in the details of each role.

To learn more about it, refer to [Talend Help Center](https://help.talend.com/access/sources/content/map?pageid=cloud_hybrid_install&afs:lang=en&EnrichVersion=Cloud).


## List of ports to open

Each application requires some TCP/IP ports to be open by default:

* tac: 8080
* nexus: 8081
* iam: 9080
* mdm: 8180
* mwfl: 8280
* runtime: 1099, 8000, 8001, 8040, 8101, 8555, 8888, 9001, 44444
* jobserver: 8000, 8001, 8555, 8888
* tdp: 9999
* tds: 19999
* tdq: 8187
* logserver: 9200 and 9300 for Elastic Search; 5601 for Kibana; 5044, 8057 and 9600 for LogStash.

In addition, service components (Kafka, MongoDB and Minio) require open ports when accessed from other hosts:

* kafka: 2181, 9092
* mongodb: 27017
* minio: 9000

To open a port, you can use one of the methods described below:

* By directly opening ports. For example:
```bash
sudo firewall-cmd --add-port=8080/tcp --permanent
sudo firewall-cmd --add-port=9080/tcp --permanent
sudo firewall-cmd --reload
```

* By creating Talend network service files in /etc/firewalld/services. For example:
```bash
sudo firewall-cmd --add-service=Talend-TAC --permanent
sudo firewall-cmd --add-service=Talend-IAM --permanent
sudo firewall-cmd --reload
```

## Issues

Issues are tracked in the [Installer (TINSTL)]((https://jira.talendforge.org/browse/TINSTL)) project on Jira.

## Licence

Apache license
