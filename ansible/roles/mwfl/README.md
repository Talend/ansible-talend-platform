# Talend MDM Workflow Server

This role installs **Talend MDM Workflow Server**.

Make sure you have completed the requirements listed in the [Root README](../../../README.md) file.

## Requirements

Only used with MDM.

## Role variables

Before running the script, you can change the following variables in the *defaults/main.yml* file:

> **Note**: You can find details about each application installed using these Ansible roles in the corresponding RPM documentation on [Talend Help Center](https://help.talend.com/search/all?query=rpm&content-lang=en-US).

### MWFL port

| Parameter   | Description                  | Value                 |
| ----------- | ---------------------------- | --------------------- |
| `mwfl_port` | Port used by the MWFL server | Default value: `8280` |

## Example playbook

```yaml
- hosts: mdm-host
  become: yes
  roles:
    - java
    - talend-repo
    - tomcat
    - tac
    - mdm
    - mwfl
```
