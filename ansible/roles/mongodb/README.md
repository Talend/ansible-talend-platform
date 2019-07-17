# MongoDB

This role installs **MongoDB**.

Make sure you have completed the requirements listed in the [Root README](../../../README.md) file.

## Role variables

Before running the script, you can change the following variables in the *defaults/main.yml* file:

> **Note**: You can find details about each application installed using these Ansible roles in the corresponding RPM documentation on [Talend Help Center](https://help.talend.com/search/all?query=rpm&content-lang=en-US).

### MongoDB RPM version

| Parameter             | Description         | Value                         |
| --------------------- | ------------------- | ----------------------------- |
| `mongodb_pkg_version` | MongoDB RPM version | Example: `{{ rpm_version }}-1` |

### Systemd

| Parameter             | Description                             | Value                           |
| --------------------- | --------------------------------------- | ------------------------------- |
| `app_install_systemd` | Whether to install as a systemd service | Supported values: `yes` or `no` |

### MongoDB port

| Parameter      | Description                        | Value                  |
| -------------- | ---------------------------------- | ---------------------- |
| `mongodb_port` | TCP/IP port used by MongoDB daemon | Default value: `27017` |

### MongoDB enhanced security

| Parameter                  | Description                          | Value                           |
| -------------------------- | ------------------------------------ | ------------------------------- |
| `mongodb_enhancedsecurity` | Whether to install enhanced security | Supported values: `yes` or `no` |

> **Note**: This value only takes effect at installation time. Changing it after installation will not modify the setting.

### User configuration for TDS, TDP and TSD

| Parameter              | Description           | Value                    |
| ---------------------- | --------------------- | ------------------------ |
| `mongodb_tds_user`     | User name of TDS user | Example: `tds-user`      |
| `mongodb_tds_password` | Password of TDS user  | Example: `duser`         |
| `mongodb_tdp_user`     | User name of TDP user | Example: `dataprep-user` |
| `mongodb_tdp_password` | Password of TDP user  | Example: `duser`         |
| `mongodb_tsd_user`     | User name of TSD user | Example: `tsd-user`      |
| `mongodb_tsd_password` | Password of TSD user  | Example: `duser`         |

If you do not want to use a particular user, set `-` as both the user name and password. For example:

```yaml
mongodb_tdp_user: "-"
mongodb_tdp_password: "-"
```

> **Note**: These values only take effect at installation time. Changing them after installation will not modify the settings.


## Example playbook

```yaml
- hosts: tds-host
  become: yes
  roles:
    - java
    - talend-repo
    - tomcat
    - tac
    - mongodb
    - tds
```
