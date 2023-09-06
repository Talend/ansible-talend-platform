# Ansible framework for Talend Platform (deprecated)

*Deprecation: Installing Talend products using RPM is deprecated from the R2023-03 release. Use Talend Installer instead. For more information, see [Installing your Talend products using Talend Installers](https://help.talend.com/r/en-US/8.0/installation-guide-windows/installing-talend-installers).*

This repository contains [Ansible](https://www.ansible.com/) roles and playbooks to deploy, manage, and configure the [Talend](https://www.talend.com) Platform services.

> **Note**: These playbooks are provided without support and are intended to be a guideline. Any issue encountered can be reported via Talend Support and will be addressed on a best effort basis. Pull requests are also encouraged.

Specifically, this repository, through its playblooks:

* Installs Talend 7.2, 7.3 or 8.0 RPM packages.
* Starts services using systemd scripts.
* Provides configuration options for Talend packages.

You can find detailed documentation about each RPM package delivered by Talend and their related services in [Talend Help Center](https://help.talend.com/search/all?query=rpm&content-lang=en-US).

## Prerequisites

To be able to install applications using Ansible, you need to setup your environment as follows:

1. Install Extra Packages for Enterprise Linux: <br/> `sudo yum install epel-release`
2. Install [Ansible](https://www.ansible.com/) on the master host used for the deployment: <br/> `sudo yum install ansible`
3. All hosts need to be reachable via SSH from the master node. Hosts must be defined in `/etc/ansible/hosts` on the master node. Note that provided default playbook `talend.yml` uses host group `tac-group`
4. Install git: `sudo yum install git`
5. Make sure you have at least 2GB free disk space in `/var`.
6. Ansible typically requires a password-less SSH access from master to a target host and a password-less "sudo" on a target host.

Installing Talend applications using RPM/Ansible require RHEL/CentOS 7.X or 8.X or Rocky 8.X as operating system.

## Installing applications using Ansible

1. Perform a Git checkout the tagged release `release/X.Y.Z` of the Talend version you are installing.
2. Specify your credentials and the version of Talend applications to install in the *ansible/group_vars/all* file. These parameters are used to access the RPM repository.
To change the RPM version to install, edit the following parameters:

   * 7.2 applications:

    ```yaml
    rpm_base_version: 7.2
    rpm_patch_version: 1
    rpm_build_number: 201906201446
    ```

   * 7.3 applications:

    ```yaml
    rpm_base_version: 7.3
    rpm_patch_version: 1
    rpm_build_number: 202002191130
    ```

   * 8.0 applications:

    ```yaml
    rpm_base_version: 8.0
    rpm_patch_version: 1
    rpm_build_number: 202211231200
    ```

3. Configure the playbook you want to install by specifying:
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

    Sample playbooks are available [here](ansible/examples) or [here](ansible/talend.yml).

4. Configure the installation parameters as well as the configuration of each role using their respective *defaults/main.yml* file. <br/> Variables can be overwritten if they are set differently directly in the playbook.
5. Run the playbook: <br/> `ansible-playbook <playbook>.yml`

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
| [logserver](ansible/roles/logserver)           | Talend Log Server                                                                                                                          |
| [jobserver](ansible/roles/jobserver)           | Talend Job Server                                                                                                                          |
| [runtime](ansible/roles/runtime)               | Talend Runtime server                                                                                                                      |
| [tdp](ansible/roles/tdp)                       | Talend Data Preparation (requires [tcomp](ansible/roles/tcomp)) |
| [tcomp](ansible/roles/tcomp)                   | Talend Component Server                                                                                                                    |
| [tds](ansible/roles/tds)                       | Talend Data Stewardship (TDS)                                                                                                              |
| [tsd](ansible/roles/tsd)                       | Talend Dictionary Service (TSD)                                                                                                            |
| [sap-rfc-server](ansible/roles/sap-rfc-server) | Talend SAP RFC Server                                                                                                                      |
| [filebeat](ansible/roles/filebeat)             | Talend Filebeat service                                                                                                                    |

The following roles install third-party components:

| Role                             | Application                                                                                                                                 |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| [tomcat](ansible/roles/tomcat)   | Apache Tomcat server (required by [tac](ansible/roles/tac), [iam](ansible/roles/iam), [tds](ansible/roles/tds), [tsd](ansible/roles/tsd) and [mdm](ansible/roles/mdm)) |
| [mongodb](ansible/roles/mongodb) | MongoDB server (required by [tds](ansible/roles/tds), [tdp](ansible/roles/tdp) and [tsd](ansible/roles/tsd))                                   |
| [kafka](ansible/roles/kafka)     | Apache Kafka server (required by [tds](ansible/roles/tds) and [tdp](ansible/roles/tdp))                              |
| [minio](ansible/roles/minio)     | MinIO server (required by [tsd](ansible/roles/tsd))                                    |

## List of applications compatible with Talend Cloud Hybrid setup

Talend Cloud lets you install and host Talend Data Preparation ([tdp](ansible/roles/tdp)), Talend Data Stewardship ([tds](ansible/roles/tds)) and Talend Dictionary Service ([tsd](ansible/roles/tsd)) on premises. This setup allows you to store sensitive data behind your firewall, while still managing your users and the rest of your platform from Talend Cloud.

Ansible roles corresponding to these applications are compatible with the Hybrid setup for Talend Cloud. See dedicated hybrid parameters in the details of each role.

To learn more about it, refer to [Talend Help Center](https://help.talend.com/r/en-US/Cloud/hybrid-installation-guide-linux/what-is-hybrid-for-talend-cloud).

## List of ports to open

Each application requires some TCP/IP ports to be open by default:

* tac: 8080 (parameter `app_tomcat_port` in [tac defaults](ansible/roles/tac/defaults/main.yml) )
* iam: 9080 (parameter `app_tomcat_port` in [iam defaults](ansible/roles/iam/defaults/main.yml) )
* mdm: 8180 (parameter `app_tomcat_port` in [mdm defaults](ansible/roles/mdm/defaults/main.yml) )
* runtime: 1099, 8000, 8001, 8040, 8101, 8555, 8888, 9001, 44444 (look for parameters in [runtime defaults](ansible/roles/runtime/defaults/main.yml) )
* jobserver: 8000, 8001, 8555, 8888 (look for parameters in [jobserver defaults](ansible/roles/jobserver/defaults/main.yml) )
* tdp: 9999 (parameter `tdp_server_port` in [tdp defaults](ansible/roles/tdp/defaults/main.yml) )
* tcomp: 8989 (parameter `tcomp_server_port` in [tcomp defaults](ansible/roles/tcomp/defaults/main.yml) )
* tds: 19999 (parameter `app_tomcat_port` in [tds defaults](ansible/roles/tds/defaults/main.yml) )
* tdq: 8187 (parameter `app_tomcat_port` in [tsd defaults](ansible/roles/tsd/defaults/main.yml) )
* logserver: 9200 and 9300 for Elastic Search; 5601 for Kibana; 5044, 8057 and 9600 for LogStash (some ports can be configured in [logserver defaults](ansible/roles/logserver/defaults/main.yml), others are hard-coded)

In addition, service components (Kafka, MongoDB and Minio) require open ports when accessed from other hosts:

* kafka: 2181, 9092 (parameters `zook_clientPort` and `kafka_listeners` in [kafka defaults](ansible/roles/kafka/defaults/main.yml) )
* mongodb: 27017 (parameter `mongodb_port` in [mongodb defaults](ansible/roles/mongodb/defaults/main.yml) )
* minio: 9000 (parameter `minio_port` in [minio defaults](ansible/roles/minio/defaults/main.yml) )

To open a port, you can use one of the methods described below:

* By directly opening ports. For example:

  ```bash
  sudo firewall-cmd --add-port=8080/tcp --permanent
  sudo firewall-cmd --add-port=9080/tcp --permanent
  sudo firewall-cmd --reload
  ```

* By creating Talend network service files in /etc/firewalld/services. For example:

  Create the following xml file in the folder `/etc/firewalld/services` with file name `Talend-TAC.xml`:
  ```xml
  <?xml version="1.0" encoding="utf-8"?>
  <service>
    <short>Talend Administration Center</short>
    <description>Talend Administration Center is a web-based application allowing data integration project managers to administrate users and projects. It also controls and monitors the execution of Jobs.</description>
    <port protocol="tcp" port="8080"/>
  </service>
  ```

  After that you can activate Talend-TAC service with commands:
  ```bash
  sudo firewall-cmd --add-service=Talend-TAC --permanent
  sudo firewall-cmd --reload
  ```

## Issues

Issues are tracked through Talend Support.

## Licence

Apache license
