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
| `app_tomcat_port`       | Port of Talend Tomcat                                    | Required if `app_use_talend_tomcat` is set to `yes`<br/>Default value: `8080`                               |
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

### Audit logging configuration parameters

| Parameter            | Description              | Value                                                                 |
| -------------------- | ------------------------ | --------------------------------------------------------------------- |
| `tac_audit_log_enabled`  | Whether to use LogServer | Supported values: `yes` or `no`                                       |

### Database

| Parameter         | Description               | Value                                                                       |
| ----------------- | ------------------------- | --------------------------------------------------------------------------- |
| `tac_database`    | Type of database          | Supported values: `mysql`, `h2`, `oracle`, `mssql`, `postgresql`, `mariadb` |
| `tac_db_host`     | Host of TAC database      | Default value: `localhost`                                                  |
| `tac_db_port`     | Description               | Default value: 3306                                                         |
| `tac_db_name`     | Name of database          | Example: `talend_administrator`                                             |
| `tac_db_user`     | User name                 | Default value: `talend`                                                     |
| `tac_db_password` | Password of database user | Default value: `talend`                                                     |
| `tac_db_driver`  | Database driver file (jar) | Required for non-H2 databases. Driver will be copied to a corresponding folder in tomcat |

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

### Http appender

| Parameter                    | Description                       | Value                                |
| ---------------------------- | --------------------------------- | ------------------------------------ |
| `tac_appender_http_host`     | Host of HTTP appender             | Required. Default value: `localhost` |
| `tac_appender_http_port`     | Port of HTTP appender             | Required. Default value: `8057`      |
| `tac_appender_http_username` | User name of HTTP appender user   | Default value: `talend`              |
| `tac_appender_http_password` | Password of of HTTP appender user | Default value: `talend`              |

### TAC repository connections

Talend Administration Center can be configured to connect to repositories. Up to 4 repositories can be configured:

- TAC Update repository connection. Used to download updates from Talend update site
- TAC Downloads (TAC Patch) repository connection. If configured, it will be used to store artifacts downloaded from Talend update site
- TAC Jobs repository connection. Used to store job artifacts
- TAC Custom libs repository

| Parameter                    | Description                       | Value                                |
| ---------------------------- | --------------------------------- | ------------------------------------ |
| `tac_repo_config` | A "master" switch for all repository connection configurations. If set to `no`, all repository connection configurations will be removed from TAC configuration file | `yes` (activate TAC repository configurations) or `no` (remove it from TAC configuration file) |
| `tac_updates_repository` | Whether to configure Talend update site connection (note that `tac_repo_config` must be set to `yes`, otherwise the value will be ignored) | `yes` or `no` |
| `tac_downloads_repository` | Whether to configure connection to Downloads (Path) repository (note that `tac_repo_config` must be set to `yes`, otherwise the value will be ignored). Also note that this value will be used only if `tac_updates_repository` also set to `yes` (as Talend update site is a source for Downloads repository | `yes` or `no` |
| `tac_jobs_repository`  | Whether to configure connection to Jobs repository (note that `tac_repo_config` must be set to `yes`, otherwise the value will be ignored) | `yes` or `no` |
| `tac_custom_libs_repository` | Whether to configure connection to Custom Libs repository (note that `tac_repo_config` must be set to `yes`, otherwise the value will be ignored) | `yes` or `no` |

If `tac_updates_repository` and `tac_repo_config` are both set to `yes`, the following parameters are used to specify update parameters:

| Parameter                    | Description                       | Value                                |
| ---------------------------- | --------------------------------- | ------------------------------------ |
| `tac_updates_repository_url` | Talend update site URL | Default value is `https://talend-update.talend.com/nexus` but it can be set to any local cache/proxy server |
| `tac_updates_repository_user` | User name | *Must be specified by user* |
| `tac_updates_repository_password` | Password | *Must be specified by user* |

If `tac_downloads_repository`, `tac_updates_repository` and `tac_repo_config` are all set to `yes`, the following parameters are used to specify Downloads repository connection:

| Parameter                    | Description                       | Value                                |
| ---------------------------- | --------------------------------- | ------------------------------------ |
| `tac_downloads_repository_type` | Repository type. Can be one of Nexus 2, Nexus 3 or Artifactory | Allowed values are `nexus2`, `nexus3` and `artifactory` |
| `tac_downloads_repository_url` | Access URL, a mandatory parameter | *Must be specified by user* |
| `tac_downloads_repository_user` | User name (for read/write access), a mandatory parameter | *Must be specified by user* |
| `tac_downloads_repository_password` | User password (for read/write access), a mandatory parameter | *Must be specified by user* |
| `tac_downloads_repository_reader_user` | User name (for read-only access), an optional parameter | *May be specified by user* |
| `tac_downloads_repository_reader_password` | User password (for read-only access), an optional parameter | *May be specified by user* |
| `tac_downloads_repository_repository_id` | Repository ID, a mandatory parameter | *Must be specified by user* |

If `tac_jobs_repository` and `tac_repo_config` are both set to `yes`, the following parameters are used to specify Jobs repository connection:

| Parameter                    | Description                       | Value                                |
| ---------------------------- | --------------------------------- | ------------------------------------ |
| `tac_jobs_repository_type` | Repository type. Can be one of Nexus 2, Nexus 3 or Artifactory | Allowed values are `nexus2`, `nexus3` and `artifactory` |
| `tac_jobs_repository_url` | Access URL, a mandatory parameter | *Must be specified by user* |
| `tac_jobs_repository_user` | User name, a mandatory parameter | *Must be specified by user* |
| `tac_jobs_repository_password` | User password, a mandatory parameter | *Must be specified by user* |
| `tac_jobs_repository_releases`  | Default repository for releases, an optional parameter | *May be specified by user* |
| `tac_jobs_repository_snapshots` | Default repository for snapshots, an optional parameter | *May be specified by user* |

If `tac_custom_libs_repository` and `tac_repo_config` are both set to `yes`, the following parameters are used to specify Custom Libs repository connection:

| Parameter                    | Description                       | Value                                |
| ---------------------------- | --------------------------------- | ------------------------------------ |
| `tac_custom_libs_repository_type` | Repository type. Can be one of Nexus 2, Nexus 3 or Artifactory | Allowed values are `nexus2`, `nexus3` and `artifactory` |
| `tac_custom_libs_repository_url` | Access URL, a mandatory parameter | *Must be specified by user* |
| `tac_custom_libs_repository_user` | User name, a mandatory parameter | *Must be specified by user* |
| `tac_custom_libs_repository_password` | User password, a mandatory parameter | *Must be specified by user* |
| `tac_custom_libs_repository_releases`  | Default repository for releases, an optional parameter | *May be specified by user* |
| `tac_custom_libs_repository_snapshots` | Default repository for snapshots, an optional parameter | *May be specified by user* |


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
