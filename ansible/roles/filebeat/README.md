# Filebeat

This role installs **Filebeat**.

Make sure you have completed the requirements listed in the [Root README](../../../README.md) file.

## Requirements

Only used with TAC and/or MDM.

## Role variables

Before running the script, you can change the following variables in the *defaults/main.yml* file:

> **Note**: You can find details about each application installed using these Ansible roles in the corresponding RPM documentation on [Talend Help Center](https://help.talend.com/search/all?query=rpm&content-lang=en-US).

### Systemd

| Parameter             | Description                             | Value                           |
| --------------------- | --------------------------------------- | ------------------------------- |
| `app_install_systemd` | Whether to install as a systemd service | Supported values: `yes` or `no` |

### Logstash hosts

| Parameter                 | Description            | Value                                                               |
| ------------------------- | ---------------------- | ------------------------------------------------------------------- |
| `filebeat_logstash_hosts` | List of Logstash hosts | Format `host1:port1, host2:port2 ...`<br/>Example, `localhost:5044` |

> **Note**: Currently, only Logstash hosts are supported as output; Elasticsearch hosts are not supported.

## Example playbook

```yaml
- hosts: tac-host
  become: yes
  roles:
    - java
    - talend-repo
    - tomcat
    - tac
    - filebeat
```
