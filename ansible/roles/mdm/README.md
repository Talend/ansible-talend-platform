# Talend MDM

This role installs **Talend MDM**.

Make sure you have completed the requirements listed in the [Root README](../../../README.md) file.

## Role variables

Before running the script, you can change the following variables in the *defaults/main.yml* file:

> **Note**: You can find details about each application installed using these Ansible roles in the corresponding RPM documentation on [Talend Help Center](https://help.talend.com/search/all?query=rpm&content-lang=en-US).

### Tomcat

| Parameter               | Description                                              | Value                                                                                                      |
| ----------------------- | -------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `app_use_talend_tomcat` | Use the Talend Tomcat in shared mode (default setting)   | Supported values: `yes` (default) or `no`<br/>If set to `yes`, the parameter `app_tomcat_port` must be set |
| `app_tomcat_port`       | Port of Talend Tomcat                                    | Required if `app_use_talend_tomcat` is set to `yes`<br/>Default value: `8180`                              |
| `app_tomcat_home`       | Home directory of customer Tomcat                        | Required if `app_use_talend_tomcat` is set to `no`<br/>Example: `/opt/tomcat`                              |
| `app_tomcat_mode`       | Tomcat mode                                              | Required if `app_use_talend_tomcat` is set to `no`<br/>Supported values: `direct` or `shared`              |
| `app_tomcat_setup`      | Whether to update the customer Tomcat port configuration | Required if `app_use_talend_tomcat` is set to `no`<br/>Supported values: `yes` or `no`                     |

### Systemd

| Parameter             | Description                             | Value                           |
| --------------------- | --------------------------------------- | ------------------------------- |
| `app_install_systemd` | Whether to install as a systemd service | Supported values: `yes` or `no` |

### MDM Web application name

| Parameter         | Description                     | Value                      |
| ----------------- | ------------------------------- | -------------------------- |
| `mdm_webapp_name` | Name of the MDM Web application | Default value: `talendmdm` |

### MDM configuration updates

| Parameter               | Description                                          | Value                           |
| ----------------------- | ---------------------------------------------------- | ------------------------------- |
| `mdm_use_audit`         | Whether to use Audit enablement for Talend LogServer | Supported values: `yes` or `no` |
| `mdm_audit_server_host` | Host of Audit server                                 | Default value: `localhost`      |
| `mdm_audit_server_port` | Port of Audit server                                 | Default value: `8057`           |

### IAM
| Parameter               | Description                     | Value                                   |
| ----------------------- | ------------------------------- | --------------------------------------- |
| `mdm_iam_url`           | URL of IAM                      | Default value: `http://localhost:9080`  |
| `mdm_oidc_url`          | URL of OIDC                     | Default value: `{{ mdm_iam_url }}/oidc` |
| `mdm_oidc_userauth_url` | URL of OIDC user authentication | Default value: `{{ mdm_iam_url }}/oidc` |
| `mdm_scim_url`          | URL of SCIM                     | Default value: `{{ mdm_iam_url }}/scim` |

### TDS
| Parameter          | Description           | Value                                   |
| ------------------ | --------------------- | --------------------------------------- |
| `mdm_tds_root_url` | Root URL of TDS       | Default value: `http://localhost:19999` |
| `mdm_tds_user`     | User name of TDS user | Example: `administrator@company.com`    |
| `mdm_tds_password` | Password of TDS user  |                                         |

### Database configuration

  | Parameter              | Description                           | Value                                                                                                                                                |
  | ---------------------- | ------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
  | `mdm_database`         | Type of database                      | Supported values: `h2`, `mysql8`, `mysql`, `oracle`, `mssql`, `postgresql`, and `db2`                                                                |
  | `mdm_db_name`          | Name of database                      | `TMDM_DB` for Oracle and DB2, `${container}` for all other databases                                                                                 |
  | `mdm_db_host`          | Host of database                      | Default: `localhost`                                                                                                                                 |
  | `mdm_db_port`          | Port of database                      | Default values:<br/>- `mysql8` and `mysql` = `3306`<br/>- `oracle` = `1521`<br/>- `mssql` = `1433`<br/>- `postgresql` = `5432`<br/>- `db2` = `50000` |
  | `mdm_db_user`          | User name of database user            | Default values:<br/>- `oracle` = `mdm_master` (for Master)<br/>- Others = `system`                                                                   |
  | `mdm_db_password`      | Password of database user             | Default value: `oracle` = `mdm_master` (for Master)                                                                                                  |
  | `mdm_db_driver`        | Location of database driver JAR       | Required for non-H2 databases                                                                                                                        |
  | `mdm_db_driver_extra1` | Location of extra database driver JAR | Required for DB2 only. Example:<br/>`/root/jdbc-lib/db2jcc_license_cisuz.jar`                                                                        |
  | `mdm_db_driver_extra2` | Location of extra database driver JAR | Required for DB2 only. Example:<br/>`/root/jdbc-lib/db2jcc_license_cu.jar`                                                                           |

### Database configuration for Oracle and DB2
  The following parameters configure Oracle and DB2 databases.
  ```
  mdm_db_schema: "mdm_master"
  mdm_db_staging_schema: "mdm_staging"
  mdm_db_staging_user: "mdm_staging"
  mdm_db_staging_password: "mdm_staging"
  mdm_db_system_schema: "mdm_system"
  mdm_db_system_user: "mdm_system"
  mdm_db_system_password: "mdm_system"
  ```



## Example playbook

```yaml
- hosts: tac-host
  become: yes
  roles:
    - java
    - talend-repo
    - tomcat
    - tac
    - mdm
```
