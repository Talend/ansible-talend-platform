# Talend IAM (Identity and Access Management)

This role installs **Talend IAM**. This service is based on standard specifications and protocols like OIDC, OAuth2, WS-Federation and WS-Trust. It is a mandatory service for using Talend Data Preparation and Talend Data Stewardship as it provides authentication and SSO for these Applications using TAC as the Identity provider. It also provides authentication to ESB REST clients based on OAuth2 standards.

Make sure you have completed the requirements listed in the [Root README](../../../README.md) file.

## Role variables

Before running the script, you can change the following variables in the *defaults/main.yml* file:

> **Note**: You can find details about each application installed using these Ansible roles in the corresponding RPM documentation on [Talend Help Center](https://help.talend.com/search/all?query=rpm&content-lang=en-US).

### Tomcat

| Parameter               | Description                                                                                                         | Value                                                                                                      |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `app_use_talend_tomcat` | Use the Talend Tomcat in shared mode                                                                                | Supported values: `yes` (default) or `no`<br/>If set to `yes`, the parameter `app_tomcat_port` must be set |
| `app_tomcat_port`       | Port of Talend Tomcat<br/>*(required if `app_use_talend_tomcat` is set to `yes`)*                                   | Default value: `9080`                                                                                      |
| `app_tomcat_home`       | Home directory of customer Tomcat<br/>*(required if `app_use_talend_tomcat` is set to `no`)*                        | Example: `/opt/tomcat`                                                                                     |
| `app_tomcat_mode`       | Tomcat mode<br/>*(required if `app_use_talend_tomcat` is set to `no`)*                                              | Supported values: `direct` or `shared`                                                                     |
| `app_tomcat_setup`      | Whether to update the customer Tomcat port configuration<br/>*(required if `app_use_talend_tomcat` is set to `no`)* | Supported values: `yes` or `no`                                                                            |

### Systemd

| Parameter             | Description                             | Value                           |
| --------------------- | --------------------------------------- | ------------------------------- |
| `app_install_systemd` | Whether to install as a systemd service | Supported values: `yes` or `no` |

### Communication with TAC

IAM needs to communicate with Talend Administrator Center (TAC); TAC acts as the identity provider for IAM.

| Parameter          | Description                                 | Value                                                           |
| ------------------ | ------------------------------------------- | --------------------------------------------------------------- |
| `iam_tac_url`      | TAC URL *(required)*                        | Default value: `http://localhost:8080/org.talend.administrator` |
| `iam_tac_user`     | User name of TAC administrator *(required)* |                                                                 |
| `iam_tac_password` | Password of TAC administrator *(required)*  |                                                                 |

### IAM configuration

| Parameter      | Description                | Value                                                                                       |
| -------------- | -------------------------- | ------------------------------------------------------------------------------------------- |
| `iam_hostname` | IAM host name *(required)* | Default value: `localhost`<br/>Note: `localhost` will not work in a distributed environment |

### IAM user interface language

| Parameter      | Description                    | Value                                                                                         |
| -------------- | ------------------------------ | --------------------------------------------------------------------------------------------- |
| `iam_language` | Language of IAM user interface | Supported values:<br/>`en` (English)<br/>`fr` (French)<br/>`ja` (Japanese)<br/>`zh` (Chinese) |

### Post-logout URLs

To communicate properly with applications (TDS, TDP and MDM), IAM requires the post-logout URLs for these applications.

| Parameter                | Description             | Value                                    |
| ------------------------ | ----------------------- | ---------------------------------------- |
| `iam_tds_postlogout_url` | Post-logout URL for TDS | Default value: `http://localhost:19999/` |
| `iam_tdp_postlogout_url` | Post-logout URL for TDP | Default value: `http://localhost:9999/`  |
| `iam_mdm_postlogout_url` | Post-logout URL for MDM | Default value: `http://localhost:8180/`  |

## Dependencies

The following roles must be used to successfully install and deploy IAM role:

- java
- talend-repo
- tomcat (required if `app_use_talend_tomcat: 'yes'`)

## Example playbook
The dependency roles listed above must be defined before the **iam** role in the playbook. For example:
  ```
  - hosts: iam-host
    become: yes
    roles:
      - java
      - talend-repo
      - tomcat
      - tac
      - iam
  ```
