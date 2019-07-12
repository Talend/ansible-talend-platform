# Talend AMC

This role installs **Talend AMC**.

Make sure you have completed the requirements listed in the [Root README](../../../README.md) file.

## Role variables

Before running the script, you can change the following variables in the *defaults/main.yml* file:

> **Note**: You can find details about each application installed using these Ansible roles in the corresponding RPM documentation on [Talend Help Center](https://help.talend.com/search/all?query=rpm&content-lang=en-US).

### Install into TAC

| Parameter              | Description                     | Value                                                                                                                               |
| ---------------------- | ------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| `amc_install_into_tac` | Whether to install AMC into TAC | Supported values: `yes` (recommended) or `no`<br/>If set to `no`, AMC will be installed as separate systemd service (`talend-amc`). |

### Tomcat

| Parameter               | Description                                              | Value                                                                                                      |
| ----------------------- | -------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `app_use_talend_tomcat` | Use the Talend Tomcat in shared mode (default setting)   | Supported values: `yes` (default) or `no`<br/>If set to `yes`, the parameter `app_tomcat_port` must be set |
| `app_tomcat_port`       | Port of Talend Tomcat                                    | Required if `app_use_talend_tomcat` is set to `yes`<br/>Default value: `8080`                              |
| `app_tomcat_home`       | Home directory of customer Tomcat                        | Required if `app_use_talend_tomcat` is set to `no`<br/>Example: `/opt/tomcat`                              |
| `app_tomcat_mode`       | Tomcat mode                                              | Required if `app_use_talend_tomcat` is set to `no`<br/>Supported values: `direct` or `shared`              |
| `app_tomcat_setup`      | Whether to update the customer Tomcat port configuration | Required if `app_use_talend_tomcat` is set to `no`<br/>Supported values: `yes` or `no`                     |

### Systemd

| Parameter             | Description                             | Value                           |
| --------------------- | --------------------------------------- | ------------------------------- |
| `app_install_systemd` | Whether to install as a systemd service | Supported values: `yes` or `no` |

## Example playbook

```yaml
- hosts: tac-host
  become: yes
  roles:
    - java
    - talend-repo
    - tomcat
    - tac
    - amc
```
