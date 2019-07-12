# Talend Tomcat

This role installs **Talend Tomcat**.

> **Note**: All Tomcat-based Talend applications (TAC, MDM, AMC, TDS, etc) must have a Tomcat server available. The server can either be this Talend-provided Tomcat, or a customer-provided Tomcat.

Make sure you completed the requirements listed in the [Root README](../../../README.md) file.

## Role variables

Before running the script, you can change the following variables in the *defaults/main.yml* file:

> **Note**: You can find details about each application installed using these Ansible roles in the corresponding RPM documentation on [Talend Help Center](https://help.talend.com/search/all?query=rpm&content-lang=en-US).

### Talend Tomcat RPM version

| Parameter                | Description               | Value               |
| ------------------------ | ------------------------- | ------------------- |
| `tomcat_rpm_pkg_version` | Talend Tomcat RPM version | Example: `9.0.10-1` |

## Example playbook

```yaml
- hosts: tac-host
  become: yes
  roles:
    - java
    - talend-repo
    - tomcat
    - tac
```
