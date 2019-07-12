# Talend Runtime

This role installs **Talend Runtime**.

Make sure you have completed the requirements listed in the [Root README](../../../README.md) file.

## Role variables

Before running the script, you can change the following variables in the *defaults/main.yml* file:

> **Note**: You can find details about each application installed using these Ansible roles in the corresponding RPM documentation on [Talend Help Center](https://help.talend.com/search/all?query=rpm&content-lang=en-US).

### Systemd

| Parameter             | Description                             | Value                           |
| --------------------- | --------------------------------------- | ------------------------------- |
| `app_install_systemd` | Whether to install as a systemd service | Supported values: `yes` or `no` |

### OSGI HTTP/HTTPS Service (PID: `org.ops4j.pax.web.cfg`)

| Parameter       | Description              | Value                 |
| --------------- | ------------------------ | --------------------- |
| `rt_http_port`  | OSGI HTTP service ports  | Default value: `8040` |
| `rt_https_port` | OSGI HTTPS service ports | Default value: `9001` |

### Karaf SSH shell (PID: `org.apache.karaf.shell.cfg`)

| Parameter     | Description             | Value                 |
| ------------- | ----------------------- | --------------------- |
| rt_ssh_port`` | Port of Karaf SSH shell | Default value: `8101` |

### JMX Management (PID: `org.apache.karaf.management.cfg`)

| Parameter              | Description                  | Value                  |
| ---------------------- | ---------------------------- | ---------------------- |
| `rt_rmi_registry_port` | JMX Management registry port | Default value: `1099`  |
| `rt_rmi_server_port`   | JMX Management server port   | Default value: `44444` |

### Jobserver (PID: `org.talend.remote.jobserver.server.cfg`)

| Parameter                                      | Description                   | Value                 |
| ---------------------------------------------- | ----------------------------- | --------------------- |
| `rt_js_command_server_port`                    | Port used for commands        | Default value: `8000` |
| `rt_js_file_server_port`                       | Port of Jobserver file server | Default value: `8001` |
| `rt_js_monitoring_port`                        | Port used for monitoring      | Default value: `8888` |
| `rt_rmi_servrt_js_process_message_porter_port` | Port used for messages        | Default value: `8555` |

### Default user master password (PID: `users.properties`)

| Parameter            | Description                       | Value                                         |
| -------------------- | --------------------------------- | --------------------------------------------- |
| `rt_master_password` | Master password for default users | An empty (default) leaves passwords unchanged |

## Example playbook

```yaml
- hosts: tac-group
  become: yes
  roles:
    - java
    - talend-repo
    - tomcat
    - tac
    - talend-runtime
```
