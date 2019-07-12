# Talend SAP RFC Server

This role installs **Talend SAP RFC Server**.

## Requirements

Make sure you have completed the requirements listed in the [Root README](../../../README.md) file.

## Role variables

Before running the script, you can change the following variables in the *defaults/main.yml* file:

> **Note**: You can find details about each application installed using these Ansible roles in the corresponding RPM documentation on [Talend Help Center](https://help.talend.com/search/all?query=rpm&content-lang=en-US).

### Prerequisites

  SAP RFC Server will not be usable without `sapjco3.jar`.
  You may download it separately for automatic deployment during installation with the following parameters:

  | Parameter                 | Description                                                           | Value                                                                 |
  | ------------------------- | --------------------------------------------------------------------- | --------------------------------------------------------------------- |
  | `sap_install_sapjco3_jar` | Controls whether to deploy `sapjco3.jar` automatically or not         | Default value: `no`                                                   |
  | `sap_sapjco3_jar_path`    | Sets the path to the `sapjc03.jar` on the local (Ansible master) host | For example: `/mnt/share/sapjc03.jar`<br/>Default value: empty string |

### Systemd

| Parameter             | Description                             | Value                           |
| --------------------- | --------------------------------------- | ------------------------------- |
| `app_install_systemd` | Whether to install as a systemd service | Supported values: `yes` or `no` |

### SAP JCO server

  | Parameter                                | Description                                                          | Value                                         |
  | ---------------------------------------- | -------------------------------------------------------------------- | --------------------------------------------- |
  | `sap_jco_server_gwhost`                  | Host of the SAP gateway on which the RFC server should be registered | Default value: `127.0.0.1`                    |
  | `sap_jco_server_gwserv`                  | Port used for registration                                           | Default value: `sapgw00`                      |
  | `sap_jco_server_progid`                  | Program ID with which the registration is done                       | Default value: `TALEND`                       |
  | `sap_jco_server_progid_idoc`             | IDoc service                                                         | Default value: `TALEND`                       |
  | `sap_jco_server_progid_bw`               | ID of BW service                                                     | Default value: `TALENDBW1`                    |
  | `sap_jco_server_connection_count`        | Number of connections registered at the gateway                      | Default value: `2`                            |
  | `sap_jco_server_worker_thread_count`     | Number of threads that can be used by the JCoServer instance         | Default value: same as connection count       |
  | `sap_jco_server_worker_thread_min_count` | Number of threads kept running by JCoServer instance                 | Default value: same as connection count       |
  | `sap_jco_server_trace`                   | Enables or disables RFC trace                                        | `1` = on or `0` = off<br/> Default value: `0` |

### SAP JCO client

  | Parameter               | Description                                        | Value                       |
  | ----------------------- | -------------------------------------------------- | --------------------------- |
  | `sap_jco_client_ashost` | Host of the SAP ABAP application server            | Default value: `127.0.0.1`  |
  | `sap_jco_client_client` | SAP client                                         | Default value: `800`        |
  | `sap_jco_client_lang`   | Sets the logon language                            | Default value: `en`         |
  | `sap_jco_client_user`   | Logon user name to authenticate this server to SAP | Default value: empty string |
  | `sap_jco_client_passwd` | Password to authenticate this server to SAP        | Default value: empty string |
  | `sap_jco_client_sysnr`  | System number of the SAP ABAP application serverS  | Default value: `00`         |

### Server management

  | Parameter                         | Description                                                  | Value                      |
  | --------------------------------- | ------------------------------------------------------------ | -------------------------- |
  | `sap_rfc_server_thread_pool_size` | Number of threads in the fixed size pool servicing SAP IDocs | Default value: `5`         |
  | `sap_rfc_server_user_lib_folder`  | Path to the folder containing user libraries                 | Default value: `user/lib`. |
  | `sap_rfc_server_shutdown_address` | IP address to listen for shutdown commands                   | Default value: `localhost` |
  | `sap_rfc_server_shutdown_port`    | Shutdown port                                                | Default value: `16161`     |
  | `sap_rfc_server_shutdown_command` | Shutdown command                                             | Default value: `SHUTDOWN`  |
  | `sap_rfc_server_shutdown_timout`  | Time (in milliseconds) to wait for shutdown                  | Default value: `60000`     |

### IDocs receiver

  | Parameter                                | Description                                                                                                     | Value                       |
  | ---------------------------------------- | --------------------------------------------------------------------------------------------------------------- | --------------------------- |
  | `sap_receiver_server_factory_class_name` | Class name of a substitute receiver factory, primarily used for testing                                         | Default value: empty string |
  | `sap_receiver_transactional`             | Switch on the transactional mode                                                                                | Default value: `false`      |
  | `sap_api_idoc_transaction_wait_timout`   | set the timeout in milliseconds waiting for the IDoc package to get processed (only used in transactional mode) | Default value: empty string |

### JMS broker

  | Parameter                                            | Description                                                                    | Value                       |
  | ---------------------------------------------------- | ------------------------------------------------------------------------------ | --------------------------- |
  | `sap_rfc_server_jms_login_config`                    | Path to AAS authentication configuration                                       | Default value: empty string |
  | `sap_rfc_server_jms_login_username`                  | JAAS username used to authenticate a publisher or sender                       | Default value: empty string |
  | `sap_rfc_server_jms_login_password`                  | JAAS password used to authenticate a publisher or sender                       | Default value: empty string |
  | `sap_rfc_server_jms_ssl_keystore_path`               | Path to a key store for SSL                                                    | Default value: empty string |
  | `sap_rfc_server_jms_ssl_keystore_password`           | Password for a key store used for SSL                                          | Default value: empty string |
  | `sap_rfc_server_jms_replicate_in_durable_queues`     | Whether JMS messages should be replicated in durable queues                    | Default value: `false`      |
  | `sap_rfc_server_jms_durable_queues_retention_period` | ISO-8601 retention period (in milliseconds) for JMS messages in durable queues | Default value: `604800000`  |

### Embedded broker

  | Parameter                           | Description                                                                 | Value                                                              |
  | ----------------------------------- | --------------------------------------------------------------------------- | ------------------------------------------------------------------ |
  | `sap_rfc_server_jms_bind_address`   | Host address and port for the JMS broker to listen for incoming connections | Default value: `tcp://localhost:61616`                             |
  | `sap_rfc_server_jms_persistence`    | Whether JMS messages are persisted or not                                   | Supported values are `true` or `false`.<br/>Default value: `false` |
  | `sap_rfc_server_jms_data_directory` | File system location used by JMS broker to persist data                     | Default value: empty string                                        |
  | `sap_rfc_server_jms_jmx`            | Whether the broker's services should be exposed to JMX                      | Default value: `false`                                             |

### Remote broker

  | Parameter                          | Description                                                   | Value                                  |
  | ---------------------------------- | ------------------------------------------------------------- | -------------------------------------- |
  | `sap_rfc_server_remote_broker_url` | URL to a remote broker instead of an embedded one (if active) | Default value: `tcp://localhost:61616` |

## Dependencies

The following roles must be used to successfully install and deploy Talend SAP RFC Server:

- java
- talend-repo

## Example playbook

The dependency roles listed above must be defined before the **sap-rfc-server** role in the playbook. For example:

```yaml
- hosts: sap-host
  become: yes
  roles:
    - java
    - talend-repo
    - sap-rfc-server
```
