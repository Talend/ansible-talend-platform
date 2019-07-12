# Job Server

This role installs **Talend Job Server**.

Make sure you have completed the requirements listed in the [Root README](../../../README.md) file.

## Role variables

Before running the script, you can change the following variables in the *defaults/main.yml* file:

> **Note**: You can find details about each application installed using these Ansible roles in the corresponding RPM documentation on [Talend Help Center](https://help.talend.com/search/all?query=rpm&content-lang=en-US).

### Systemd

| Parameter             | Description                             | Value                           |
| --------------------- | --------------------------------------- | ------------------------------- |
| `app_install_systemd` | Whether to install as a systemd service | Supported values: `yes` or `no` |

### Network configuration

| Parameter                       | Description                                                                                                        | Value                                                                                          |
| ------------------------------- | ------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------- |
| `js_command_server_port`        | TCP/IP port used to launch commands                                                                                | Default value: `8000`                                                                          |
| `js_file_server_port`           | TCP/IP port used for file transfers                                                                                | Default value: `8001`                                                                          |
| `js_monitoring_port`            | TCP/IP port used for monitoring the server state                                                                   | Default value: `8888`                                                                          |
| `js_process_message_port`       | TCP/IP port used for the execution of process messages publisher                                                   | Default value: `8555`                                                                          |
| `js_enabled_process_message`    | Whether to enable the process message publisher                                                                    | Supported values: `true` (default) or `false`                                                  |
| `js_local_host`                 | Host used by Log Server                                                                                            | Default value: `localhost`                                                                     |
| `js_use_ssl`                    | Whether to use SSL (Secure Sockets Layer) to establishing an encrypted link between the Job Server and its clients | Supported values: `false` (default) or `true`                                                  |
| `js_disabled_cipher_suites`     | Comma-separated list of disabled cipher suites to improve security.                                                | Supported values: `yes` or `no`<br/>Used when `js_use_ssl` is set to `true`, otherwise ignored |
| `js_max_concurrent_connections` | Number of concurrent connections                                                                                   | Default value: `1000`                                                                          |

### User control

It is possible have finer-grained control of the users who run jobs with the following parameters:

| Parameter                          | Description                                                     | Value                                                                                                                                                 |
| ---------------------------------- | --------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| `js_run_as_whitelist`              | Comma-separated list of OS users allowed to run jobs            | If the list of allowed users is specified, all other users will not be allowed to run jobs<br/>An empty string (default) allows all users to run jobs |
| `js_run_as_user_validation_regexp` | Regular expression for the validation of the user name variable |                                                                                                                                                       |

### Job run configuration

| Parameter                       | Description                                                                                                                                                                          | Value                                                                           |
| ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------- |
| `js_root_path`                  | Path to the directory with Talend Job Server input files                                                                                                                             | Default value: `./TalendJobServersFiles`                                        |
| `js_checkFileCountBeforeFire`   | Maximum number of times Job Server scans the files in `js_root_path` (once a second). The file will be processed by Job Server when this maximum number is reached                   | Default value: `10` (sufficient in most cases)                                  |
| `js_execute_unsigned_job_token` | Token allowing Job Server to execute unsigned jobs                                                                                                                                   |                                                                                 |
| `js_force_load`                 | Whether to force the loading of native libraries. This should generally only be used for the testing of native libraries, and not in production environments                         | Supported values: `true` or `false` (recommended for production environments)   |
| `js_launch_shell_script`        | Whether to use a shell for running jobs. In most cases, this is not required (Job Server uses a direct call to Java)<br/>Note: Using a shell prevents jobs from terminating properly | Supported values: `false` (default) or `true`                                   |
| `js_shell_linux`                | Path to shell                                                                                                                                                                        | Only used when `js_launch_shell_script` is set to `true`<br/>Example: `/bin/sh` |
| `job_launcher_path`             | Java executable path used to run jobs                                                                                                                                                | An empty string (default) uses auto-detection. Example: `/usr/bin/java`         |

### Temporary data cleaning

| Parameter                                                    | Description                                                                                 | Value                                                                   |
| ------------------------------------------------------------ | ------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------- |
| `js_frequency_clean_action`                                  | Time in seconds between each cleaning action                                                | Default value: `600`<br/>Set to `0` to disable cleaning                 |
| `js_min_number_job_executions_before_release`                | Number of executions after which the job execution release process occurs                   | Default value: `50`                                                     |
| `js_max_duration_before_job_execution_release_normal_case`   | Duration (in milliseconds) of a normal execution before it is ready to be released          | Default value: `300000` (5 min)                                         |
| `js_max_duration_before_job_execution_release_abnormal_case` | Duration (in milliseconds) of an *abnormal* execution before it is ready to be released     | Default value: `86400000` (24 hours)<br/>Set to `0` to disable cleaning |
| `js_max_duration_before_cleaning_old_executions_logs`        | Duration (in seconds from the creation date) before cleaning executions logs                | Default value: `7776000` (3 months)<br/>Set to `0` to disable cleaning  |
| `js_max_old_executions_logs`                                 | Maximum number of execution logs to keep                                                    | Default value: `1000`<br/>Set to `0` to disable cleaning                |
| `js_max_duration_before_cleaning_old_jobs`                   | Duration (in seconds from the creation date) before cleaning *archived* and *deployed* jobs | Default value: `7776000` (3 months)<br/>Set to `0` to disable cleaning  |
| `js_max_old_jobs`                                            | Maximum *archived* and *deployed* jobs to keep                                              | Default value: `200`<br/>Set to `0` to disable cleaning                 |

### TAC authorization

| Parameter          | Description                                                   | Value                                                                                                                                                |
| ------------------ | ------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| `js_security_mode` | Whether to activate authorization for all Job Server commands | Supported values: `true` or `false`                                                                                                                  |
| `js_tac_urls`      | Comma-separated list of TAC servers used for authorization    | Required if `js_security_mode` is set to `true`<br/>Example: `http://host1:8080/org.talend.administrator,http://host2:8080/org.talend.administrator` |

### SSL for Job Server

| Parameter                                    | Description                                                              | Value                                                           |
| -------------------------------------------- | ------------------------------------------------------------------------ | --------------------------------------------------------------- |
| `js_remote_server_ssl_authenticate`          | Whether to enforce certificate-based client authorization for Job Server | Supported values: `false` (default) or `true`. Unset is `false` |
| `js_remote_server_ssl_keyStore`              | Path to the file with SSL keystore                                       |                                                                 |
| `js_remote_server_ssl_keyStorePassword`      | Password of the SSL keystore                                             |                                                                 |
| `js_remote_server_ssl_trustStore`            | Path to the file with SSL truststore                                     |                                                                 |
| `js_remote_server_ssl_trustStorePassword`    | Password of the SSL truststore                                           |                                                                 |
| `js_remote_server_ssl_enabled_cipher_suites` | Cipher suites used while negotiating SSL connection                      | An empty value (default) means no limitation from Job Server    |

### SSL for JMX monitoring port

| Parameter                            | Description                                                                                                                               | Value                                                                             |
| ------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------- |
| `js_jmxmp_useSSL`                    | Whether to enforce using SSL for JMX monitoring server                                                                                    | Supported values: `false` (default) or `true`                                     |
| `js_jmxmp_ssl_authenticate`          | Whether to enforce using authorization with SSL for JMX monitoring server (in this case user needs to setup keystore/truststore properly) | Supported values: `false` (default) or `true`                                     |
| `js_jmxmp_ssl_keyStore`              | Path to the file with SSL keystore                                                                                                        |                                                                                   |
| `js_jmxmp_ssl_keyStorePassword`      | Password of the SSL keystore                                                                                                              |                                                                                   |
| `js_jmxmp_ssl_keyStoreType`          | Type of keystore                                                                                                                          | Examples: `JKS` (default), `PKCS12`                                               |
| `js_jmxmp_ssl_trustStore`            | Path to the file with SSL truststore                                                                                                      |                                                                                   |
| `js_jmxmp_ssl_trustStorePassword`    | Password of the SSL truststore                                                                                                            |                                                                                   |
| `js_jmxmp_ssl_trustStoreType`        | Type of truststore                                                                                                                        | Examples: `JKS` (default), `PKCS12`                                               |
| `js_jmxmp_ssl_enabled_protocols`     | Available SSL protocols to use for connection establishing phase                                                                          | An empty value (default) means no limitation from Job Server<br/>Example: `TLSv1` |
| `js_jmxmp_ssl_enabled_cipher_suites` | Cipher suites used while negotiating SSL connection                                                                                       | An empty value (default) means no limitation from Job Server                      |


## Dependencies

The following roles must be used to successfully install and deploy Job Server:

- java
- talend-repo

## Example playbook

The dependency roles listed above must be defined before the **jobserver** role in the playbook For example:

  ```yaml
  - hosts: jobserver-host
    become: yes
    roles:
      - java
      - talend-repo
      - jobserver
  ```
