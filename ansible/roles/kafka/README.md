# Apache Kafka

This role installs **Apache Kafka**. This is an auxiliary role that may be needed by other roles, such as `tds` and `tdp`.

Make sure you have completed the requirements listed in the [Root README](../../../README.md) file.

## Role variables

Before running the script, you can change the following variables in the *defaults/main.yml* file:

> **Note**: You can find details about each application installed using these Ansible roles in the corresponding RPM documentation on [Talend Help Center](https://help.talend.com/search/all?query=rpm&content-lang=en-US).

### Systemd

| Parameter             | Description                             | Value                           |
| --------------------- | --------------------------------------- | ------------------------------- |
| `app_install_systemd` | Whether to install as a systemd service | Supported values: `yes` or `no` |

### ZooKeeper Access Control List (ACL) support

This implementation supports the Access Control List feature for ZooKeeper (see [ZooKeeper ACL](https://zookeeper.apache.org/doc/r3.1.2/zookeeperProgrammers.html#sc_ZooKeeperAccessControl) for more details). When enabled, it will create JAAS configuration file (`jaas_config.conf`) in `kafka/config` folder. The access passwords will be generated on the fly during the creation of the JAAS configuration file.

The implementation supports both activation and de-activation of ACL-based ZooKeeper access. To change the status, update the parameter below and re-run the Ansible playbook.

| Parameter         | Description                                  | Value                      |
| ----------------- | -------------------------------------------- | -------------------------- |
| `zook_setacl`  | Whether to set ACL-based access to ZooKeeper | `yes` (default) or `no`  |

For security reasons, it is recommended to keep the value for parameter `zook_setacl` set to `yes`.


### Zookeeper variables

| Parameter             | Description                            | Value                                                                    |
| --------------------- | -------------------------------------- | ------------------------------------------------------------------------ |
| `zook_datadir`        | Directory where the snapshot is stored |                                                                          |
| `zook_clientPort`     | TCP/IP ports for incoming connections  | Default value: `2181`                                                    |
| `zook_macClientCnxns` | aximum client connections              | If set to `0`, an unlimited number of client connections will be allowed |

### Kafka variables - Server basics

| Parameter         | Description      | Value                                           |
| ----------------- | ---------------- | ----------------------------------------------- |
| `kafka_broker_id` | ID of the broker | Must be set to a unique integer for each broker |

### Kafka variables - Socket server

| Parameter                              | Description                                                                                                         | Value                                                                                                                                                                 |
| -------------------------------------- | ------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `kafka_listeners`                      | Address on which the socket server listens                                                                          | If not set, it will get the value returned from `java.net.InetAddress.getCanonicalHostName()`                                                                         |
| `kafka_advertised_listeners`           | Host and port that the broker will advertise to producers and consumers                                             | If not set, it uses the value for `kafka_listeners`, if it is configured.  Otherwise, it will use the value returned by `java.net.InetAddress.getCanonicalHostName()` |
| `kafka_listener_security_protocol_map` | Maps listener names to security protocols                                                                           | The default is for them to be the same. See Apache Kafka config documentation for more details                                                                        |
| `kafka_num_network_threads`            | Number of threads that the server uses for receiving requests from the network and sending responses to the network |                                                                                                                                                                       |
| `kafka_num_io_threads`                 | Number of threads that the server uses for processing requests, which may include disk I/O                          |                                                                                                                                                                       |
| `kafka_socket_send_buffer_bytes`       | Send buffer (`SO_SNDBUF`) used by the socket server                                                                 |                                                                                                                                                                       |
| `kafka_socket_receive_buffer_bytes`    | Receive buffer (`SO_RCVBUF`) used by the socket server                                                              |                                                                                                                                                                       |
| `kafka_socket_request_max_bytes`       | Maximum size of a request that the socket server will accept (protection against out-of-memory)                     |                                                                                                                                                                       |

### Kafka variables - Log basics

| Parameter                                 | Description                                                                                                                                                    |
| ----------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `kafka_log_dirs`                          | Comma-separated list of directories under which to store log files                                                                                             |
| `kafka_num_partitions`                    | Default number of log partitions per topic. More partitions allow greater consumer parallelisation, but this will also result in more files across the brokers |
| `kafka_num_recovery_threads_per_data_dir` | Number of threads per data directory to be used for log recovery at startup and flushing at shutdown                                                           |

### Kafka variables - Internal topics

| Parameter                                        | Description                                                                                | Value                                                                                                                       |
| ------------------------------------------------ | ------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------- |
| `kafka_offsets_topic_replication_factor`         | Replication factor for the group metadata internal topic `__consumer_offsets`              | For cases other than development testing, a value greater than `1` is recommended to ensure availability. <br/>Example: `3` |
| `kafka_transaction_state_log_replication_factor` | Replication factor for the group metadata internal topic `__transaction_state`             | For cases other than development testing, a value greater than `1` is recommended to ensure availability. <br/>Example: `3` |
| `kafka_transaction_state_log_min_isr`            | Minimum in-sync replicas (ISR) for the group metadata internal topic `__transaction_state` | For cases other than development testing, a value greater than `1` is recommended to ensure availability. <br/>Example: `3` |

### Kafka variables - Log flush policy

| Parameter                           | Description                                                                                |
| ----------------------------------- | ------------------------------------------------------------------------------------------ |
| `kafka_log_flush_interval_messages` | Number of messages to accept before forcing a flush of data to disk                        |
| `kafka_log_flush_interval_ms`       | Maximum amount of time (in milliseconds) a message can sit in a log before forcing a flush |

### Kafka variables - Log Retention Policy

The following configurations control the disposal of log segments. The policy can be set to delete segments after a period of time, or after a given size has accumulated. A segment will be deleted whenever *either* of these criteria are met. Deletion always happens from the end of the log.

| Parameter                   | Description                                                                                                                                                                               |
| --------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `kafka_log_retention_hours` | Minimum age of a log file to be eligible for deletion due to age                                                                                                                          |
| `kafka_log_retention_bytes` | Size-based retention policy for logs. Segments are pruned from the log unless the remaining segments drop below `log.retention.bytes`. Functions independently from `log.retention.hours` |
| `kafka_log_segment_bytes`   | Maximum size of a log segment file. When this size is reached a new log segment will be created                                                                                           |
### Kafka variables - Zookeeper settings for Kafka

| Parameter                               | Description                               | Value                                         |
| --------------------------------------- | ----------------------------------------- | --------------------------------------------- |
| `kafka_zookeeper_connect`               | Zookeeper connection string               | Port should match parameter `zook_clientPort` |
| `kafka_zookeeper_connection_timeout_ms` | Timeout in ms for connecting to Zookeeper |                                               |

### Kafka variables - Group Coordinator Settings

| Parameter                                | Description                                                                                                                                        |
| ---------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| `kafka_group_initial_rebalance_delay_ms` | Delay, in milliseconds, used by the GroupCoordinator before the initial consumer rebalance. See Apache Kafka config documentation for more details |

## Dependencies

The `kafka` role installs a local Kafka/Zookeeper server and may be a dependency for the following roles:

- tds
- tsd

If the `kafka` role is not installed, these roles must use an externally provided Zookeeper/Kafka server.

> **Note:** If using non-standard ports for Kafka (`9092`) and Zookeeper (`2181`), remember to update the Kafka and Zookeeper ports in `tds` and `tsd`.

## Example playbook

When using the `kafka` role, it must be used *before* the `tds` and/or `tsd` role(s). For example:

```yaml
- hosts: tds-host
  become: yes
  roles:
    - java
    - talend-repo
    - tomcat
    - kafka
    - mongodb
    - tds
```
