# Nexus

This role installs **Nexus**.

Make sure you have completed the requirements listed in the [Root README](../../../README.md) file.

## Requirements

Only used with TAC.

## Role variables

Before running the script, you can change the following variables in the *defaults/main.yml* file:

> **Note**: You can find details about each application installed using these Ansible roles in the corresponding RPM documentation on [Talend Help Center](https://help.talend.com/search/all?query=rpm&content-lang=en-US).

### Systemd

| Parameter             | Description                             | Value                           |
| --------------------- | --------------------------------------- | ------------------------------- |
| `app_install_systemd` | Whether to install as a systemd service | Supported values: `yes` or `no` |

### Nexus host and port

| Parameter    | Description   | Value                    |
| ------------ | ------------- | ------------------------ |
| `nexus_host` | Host of Nexus | Default value: `0.0.0.0` |
| `nexus_port` | Port of Nexus | Default value: `8081`    |

## Example playbook

```yaml
- hosts: tac-host
  become: yes
  roles:
    - java
    - talend-repo
    - tomcat
    - tac
    - nexus
```
