# Talend Spark Job Server

This role installs **Talend Spark Job Server (SJS)**.

Make sure you have completed the requirements listed in the [Root README](../../../README.md) file.

## Role variables

Before running the script, you can change the following variables in the *defaults/main.yml* file:

> **Note**: You can find details about each application installed using these Ansible roles in the corresponding RPM documentation on [Talend Help Center](https://help.talend.com/search/all?query=rpm&content-lang=en-US).

### Systemd

| Parameter             | Description                             | Value                          |
| --------------------- | --------------------------------------- | ------------------------------ |
| `app_install_systemd` | Whether to install as a systemd service | Possible values: `yes` or `no` |

### Configuration updates

The following parameters can be used for on-the-fly configuration updates:

| Parameter                   | Description                                          | Value                                                                                                                                                                                                                                 |
| --------------------------- | ---------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `sjs_host`                  | Host of SJS server                                   | Default value: `localhost`                                                                                                                                                                                                            |
| `sjs_server_port`           | Port of SJS server                                   | Default value: `8090`                                                                                                                                                                                                                 |
| `sjs_log_dir`               | Directory of logs                                    | Default value: `$install_dir/logs`                                                                                                                                                                                                    |
| `sjs_pidfile`               | PID file of SJS                                      | Default value: `spark-jobserver.pid`                                                                                                                                                                                                  |
| `sjs_jobserver_memory`      | Amount of memory to give to SJS                      | Default value: `1G`                                                                                                                                                                                                                   |
| `sjs_context_per_jvm`       | Whether to use a context per JVM                     | Possible values: `true` (default) or `false`                                                                                                                                                                                          |
| `sjs_database_root_dir`     | Root directory of SJS database                       | Default value: `$install_dir/database`                                                                                                                                                                                                |
| `sjs_h2_tcp_host`           | Host of H2 TCP server                                | Default value: `localhost`                                                                                                                                                                                                            |
| `sjs_h2_tcp_port`           | Port of H2 TCP server                                | Default value: `8099`                                                                                                                                                                                                                 |
| `sjs_deploy_templates`      | Directory of deployment templates                    | Default value: `$install_dir`                                                                                                                                                                                                         |
| `sjs_datastreams_deps_jars` | Directory of Data Streams dependency JARs            | Default value: `$install_dir/datastreams-deps`                                                                                                                                                                                        |
| `sjs_datastreams_job_jar`   | Data Streams job JAR                                 | Default value: `$install_dir/datastreams.jar"`                                                                                                                                                                                        |
| `sjs_spark_home`            | Home directory of Spark                              | Default value: `$install_dir/spark`                                                                                                                                                                                                   |
| `sjs_spark_conf_dir`        | Configuration directory of Spark                     | Default value: `$spark_home/conf`                                                                                                                                                                                                     |
| `sjs_spark_master`          | Spark master to use                                  | Required. Possible values: `yarn-client` (default) or `local[*]`<br/>When set to `yarn-client`, jobs will submitted to the configured Hadoop cluster.<br/>When set to `local[*]`, submitted jobs will be run on a local Spark cluster |
| `sjs_hadoop_conf_dir`       | Configuration directory of Hadoop                    | Default value: `/path/to/hadoop/conf`                                                                                                                                                                                                 |
| `sjs_yarn_conf_dir`         | Configuration directory of Yarn                      | Default value: `$hadoop_conf_dir`                                                                                                                                                                                                     |
| `sjs_spark_driver_memory`   | Amount of memory to use for the Spark driver process | Default value: `1G`                                                                                                                                                                                                                   |
| `sjs_krb5_config`           | Configuration file of Kerberos                       | Default value: `/etc/krb5.conf`                                                                                                                                                                                                       |

### Google Dataflow

| Parameter                            | Description                                |
| ------------------------------------ | ------------------------------------------ |
| `sjs_google_application_credentials` | Credentials of Google Dataflow application |

### Advanced configuration

| Parameter                           | Description                                     | Value                                        |
| ----------------------------------- | ----------------------------------------------- | -------------------------------------------- |
| `sjs_jmx_port`                      | Port of SJS JMX                                 | Default value: `9998`                        |
| `sjs_max_direct_memory`             | SJS max direct memory                           | Default value:  `512M`                       |
| `sjs_akka_jvm_exit_on_fatal_error`  | Whether to shut down AKKA JVM on fatal error    | Possible values: `true` (default) or `false` |
| `sjs_short_timeout`                 | Job Server timeout (in seconds)                 | Default value: `10`                          |
| `sjs_context_creation_timeout`      | Timeout (in seconds) for context creation       | Default value:  `120`                        |
| `sjs_yarn_context_creation_timeout` | Timeout (in seconds) for Yarn context creation  | Default value: `120`                         |
| `sjs_default_sync_timeout`          | Default timeout (in seconds) for sync           | Default value: `20`                          |
| `sjs_context_init_timeout`          | Timeout (in seconds) for context initialization | Default value:  `120`                        |
| `sjs_spray_request_timeout`         | Spray request timeout (in seconds)              | Default value: `200`                         |
| `sjs_spray_idle_timeout`            | Spray idle timeout (in seconds)                 | Default value: `220`                         |
| `sjs_dao_ask_timeout`               | Timeout (in seconds) for DAO ask                | Default value:  `10`                         |

## Example playbook

```yaml
- hosts: sjs-host
  become: yes
  roles:
    - java
    - talend-repo
    - sjs
```
