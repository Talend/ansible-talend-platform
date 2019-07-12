# Talend Components

This role installs **Talend Components**.

Make sure you have completed the requirements listed in the [Root README](../../../README.md) file.

## Role variables

Before running the script, you can change the following variables in the *defaults/main.yml* file:

> **Note**: You can find details about each application installed using these Ansible roles in the corresponding RPM documentation on [Talend Help Center](https://help.talend.com/search/all?query=rpm&content-lang=en-US).

### Systemd

| Parameter             | Description                             | Value                           |
| --------------------- | --------------------------------------- | ------------------------------- |
| `app_install_systemd` | Whether to install as a systemd service | Supported values: `yes` or `no` |

### Components server port

| Parameter           | Description                        | Value                 |
| ------------------- | ---------------------------------- | --------------------- |
| `tcomp_server_port` | Port used by the Components server | Default value: `8989` |

## Example playbook

```yaml
- hosts: tac-host
  become: yes
  roles:
    - java
    - talend-repo
    - tomcat
    - talend-tcomp
```
