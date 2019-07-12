# Talend Administrator Center (TAC)

This role installs **Talend Administrator Center** (TAC).

Make sure you have completed the requirements listed in the [Root README](../../../README.md) file.

## Role variables

Before running the script, you can change the following variables in the *defaults/main.yml* file:

> **Note**: You can find details about each application installed using these Ansible roles in the corresponding RPM documentation on [Talend Help Center](https://help.talend.com/search/all?query=rpm&content-lang=en-US).

### Tomcat

| Parameter               | Description                                              | Value                                                                                                       |
| ----------------------- | -------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| `app_use_talend_tomcat` | Use the Talend Tomcat in shared mode (default setting)   | Supported values: `yes` (default) or `no`<br/>If set to `yes`, the parameter `app_tomcat_port` must be set. |
| `app_tomcat_port`       | Port of Talend Tomcat                                    | Required if `app_use_talend_tomcat` is set to `yes`<br/>Default value: `9080`                               |
| `app_tomcat_home`       | Home directory of customer Tomcat                        | Required if `app_use_talend_tomcat` is set to `no`<br/>Example: `/opt/tomcat`                               |
| `app_tomcat_mode`       | Tomcat mode                                              | Required if `app_use_talend_tomcat` is set to `no`<br/>Supported values: `direct` or `shared`               |
| `app_tomcat_setup`      | Whether to update the customer Tomcat port configuration | Required if `app_use_talend_tomcat` is set to `no`<br/>Supported values: `yes` or `no`                      |

### Systemd

| Parameter             | Description                             | Value                           |
| --------------------- | --------------------------------------- | ------------------------------- |
| `app_install_systemd` | Whether to install as a systemd service | Supported values: `yes` or `no` |

### Web-application name

| Parameter         | Description          | Value                                     |
| ----------------- | -------------------- | ----------------------------------------- |
| `tac_webapp_name` | Web-application name | Default value: `org.talend.administrator` |

### Admin username/password

| Parameter        | Description                     | Value                           |
| ---------------- | ------------------------------- | ------------------------------- |
| `tac_admin_user` | User name of administrator user | Example: `security@company.com` |
| `tac_admin_pass` | Password of administrator user  | Example: `admin`                |

### SSO

| Parameter     | Description        | Value                           |
| ------------- | ------------------ | ------------------------------- |
| `tac_use_sso` | Whether to use SSO | Supported values: `yes` or `no` |

### LogServer

| Parameter            | Description              | Value                                                                 |
| -------------------- | ------------------------ | --------------------------------------------------------------------- |
| `tac_use_logserver`  | Whether to use LogServer | Supported values: `yes` or `no`                                       |
| `tac_logserver_host` | Host of LogServer        | Required if `tac_use_logserver` is set to `yes`. Example: `localhost` |
| `tac_logserver_port` | Port of LogServer        | Required if `tac_use_logserver` is set to `yes`. Example: `5044`      |

### Database

| Parameter         | Description               | Value                                                                       |
| ----------------- | ------------------------- | --------------------------------------------------------------------------- |
| `tac_database`    | Type of database          | Supported values: `mysql`, `h2`, `oracle`, `mssql`, `postgresql`, `mariadb` |
| `tac_db_host`     | Host of TAC database      | Default value: `localhost`                                                  |
| `tac_db_port`     | Description               | Default value: 3306                                                         |
| `tac_db_name`     | Name of database          | Example: `talend_administrator`                                             |
| `tac_db_user`     | User name                 | Default value: `talend`                                                     |
| `tac_db_password` | Password of database user | Default value: `talend`                                                     |

> **Note:**  If you set `tac_database` to `h2`, all the other parameters are optional.

### JobServer

| Parameter             | Description                    | Value                           |
| --------------------- | ------------------------------ | ------------------------------- |
| `tac_setup_jobserver` | Whether to configure Jobserver | Supported values: `yes` or `no` |

If `tac_setup_jobserver` is set to `yes`, the following parameters are used:

| Parameter                          | Description                  | Value                      |
| ---------------------------------- | ---------------------------- | -------------------------- |
| `tac_jobserver_name`               | Name of Jobserver            | Default value: `jobserver` |
| `tac_jobserver_host`               | Host of Jobserver            | Default value: `localhost` |
| `tac_jobserver_command_port`       | Port used for commands       | Default value: `8000`      |
| `tac_jobserver_file_transfer_port` | Port used for file transfers | Default value: `8001`      |
| `tac_jobserver_monitoring_port`    | Port used for moniforing     | Default value: `8888`      |
| `tac_jobserver_username`           | User name of Jobserver user  | Default value: `talend`    |
| `tac_jobserver_password`           | Password of Jobserver user   | Default value: `talend`    |

### Socket appender

| Parameter                  | Description             | Value                      |
| -------------------------- | ----------------------- | -------------------------- |
| `tac_appender_socket_host` | Host of socket appender | Default value: `localhost` |
| `tac_appender_socket_port` | Port of socket appender | Default value: `8056`      |

### Http appender

| Parameter                    | Description                       | Value                                |
| ---------------------------- | --------------------------------- | ------------------------------------ |
| `tac_appender_http_host`     | Host of HTTP appender             | Required. Default value: `localhost` |
| `tac_appender_http_port`     | Port of HTTP appender             | Required. Default value: `8057`      |
| `tac_appender_http_username` | User name of HTTP appender user   | Default value: `talend`              |
| `tac_appender_http_password` | Password of of HTTP appender user | Default value: `talend`              |

### License

| Parameter             | Description                                                      | Value                                                                                             |
| --------------------- | ---------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- |
| `tac_install_license` | Whether to automatically install a license during the deployment | Supported values: `yes` or `no`                                                                   |
| `tac_license_file`    | Path to license file                                             | Required if `tac_install_license` is set to `yes`<br/>Example: `/mnt/share/licenses/last.license` |

## Dependencies

The following roles must be used to successfully install and deploy Talend Administrator Center:

- java
- talend-repo
- tomcat (must be used if `app_use_talend_tomcat: 'yes'`)

## Example playbook

The dependency roles listed above must be defined before the **tac** role in the playbook For example:

```yaml
- hosts: tac-host
  become: yes
  roles:
    - java
    - talend-repo
    - tomcat
    - tac
```
