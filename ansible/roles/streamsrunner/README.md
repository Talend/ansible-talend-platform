# Talend Streamsrunner

This role installs **Talend Streamsrunner**.

Make sure you have completed the requirements listed in the [Root README](../../../README.md) file.

**Attention:** Talend Streamsrunner RPM requires Java 8 (Oracle Java or OpenJDK). It will **not** work with Java 11.

## Role variables

Before running the script, you can change the following variables in the *defaults/main.yml* file:

> **Note**: You can find details about each application installed using these Ansible roles in the corresponding RPM documentation on [Talend Help Center](https://help.talend.com/search/all?query=rpm&content-lang=en-US).

### Systemd

| Parameter             | Description                             | Value                           |
| --------------------- | --------------------------------------- | ------------------------------- |
| `app_install_systemd` | Whether to install as a systemd service | Supported values: `yes` or `no` |

### Basic configuration

| Parameter                   | Description                  | Value                                         |
| --------------------------- | ---------------------------- | --------------------------------------------- |
| `streamsrunner_server_host` | Host of Streamsrunner server | Default value: `localhost`                    |
| `streamsrunner_server_port` | Port of Streamsrunner server | Default value: `9060`                         |
| `sjs_host`                  | Host of Spark Job Server     | Default value: `localhost`                    |
| `sjs_port`                  | Port of Spark Job Server     | Default value: `8090`                         |
| `sjs_protocol`              | Protocol of Spark Job Server | Supported values: `http` (default) or `https` |

### Advanced configuration

| Parameter                             | Description                                | Value                                         |
| ------------------------------------- | ------------------------------------------ | --------------------------------------------- |
| `streamsrunner_max_json_payload_size` | Maximum payload size for Streamsrunner     | Default value: `100M`                         |
| `streamsrunner_request_compression`   | Whether to compress Streamsrunner requests | Supported values: `true` (default) or `false` |
| `runner_id`                           | ID of runner                               | Default value: `standard-spark-runner`        |
| `runner_type`                         | Type of runner                             | Default value: `SparkRunner`                  |
| `runner_properties`                   | Properties for runner                      |                                               |
| `runner_tuning_properties`            | Tuning properties for runner               |                                               |

### Default Spark runner properties

| Parameter                | Description                                                         | Value                                          |
| ------------------------ | ------------------------------------------------------------------- | ---------------------------------------------- |
| `sparkrunner_properties` | Default Spark runner properties in the format `key=value;key=value` | Default value: `usesProvidedSparkContext=true` |

## Example playbook

```yaml
- hosts: streams-host
  become: yes
  roles:
    - java
    - talend-repo
    - streamsrunner
```
