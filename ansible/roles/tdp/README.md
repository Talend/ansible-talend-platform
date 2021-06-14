# Talend Data Preparation (TDP)

This role installs **Talend Data Preparation** server

Make sure you have completed the requirements listed in the [Root README](../../../README.md) file.

## Role Variables

Before running the script, you can change the following variables in the *defaults/main.yml* file:

> **Note**: You can find details about each application installed using these Ansible roles in the corresponding RPM documentation on [Talend Help Center](https://help.talend.com/search/all?query=rpm&content-lang=en-US).

### Systemd

| Parameter             | Description                             | Value                          |
| --------------------- | --------------------------------------- | ------------------------------ |
| `app_install_systemd` | Whether to install as a systemd service | Possible values: `yes` or `no` |

### Network configuration

| Parameter         | Description                  | Value                                                                                              |
| ----------------- | ---------------------------- | -------------------------------------------------------------------------------------------------- |
| `tdp_public_ip`   | Public address of TDP server | Default value: `localhost`<br/> Default value must be changed for use in a distributed environment |
| `tdp_server_port` | Port of TDP server           | Default value: `9999`                                                                              |

### Compression of responses

The following options increase network throughput and are activated by default:

| Parameter                           | Description                                                             | Value                                        |
| ----------------------------------- | ----------------------------------------------------------------------- | -------------------------------------------- |
| `tdp_server_compression_enabled`    | Whether to enable compression of responses                              | Possible values: `true` (default) or `false` |
| `tdp_server_compression_mime_types` | Comma-separated mime-types which are targets for compression operations | Default value: `text/plain,text/html,text/css,application/json,application/x-javascript,text/xml,application/xml,application/xml+rss,text/javascript,application/javascript,text/x-js` |

### Hybrid configuration

Talend Cloud lets you install and host Talend Data Preparation application on premises. This setup allows you to store sensitive data behind your firewall, while still managing your users and the rest of your platform from Talend Cloud.

| Parameter           | Description                            | Value               |
| ------------------- | -------------------------------------- | ------------------- |
| `tdp_hybrid_mode`   | Hybrid mode (`yes` or `no`)            | Default value: `no` |
| `tdp_hybrid_region` | The region to use (`us`, `eu` or `ap`) | Default value: `us` |

For hybrid mode, it is important to set up also these 2 variables:

| Parameter                                 | Description                                                               |
| ----------------------------------------- | ------------------------------------------------------------------------- |
| `tdp_security_oauth2_client_clientId`     | Client ID for your account (retrieved from Talend Management Console)     |
| `tdp_security_oauth2_client_clientSecret` | Client Secret for your account (retrieved from Talend Management Console) |
Note: in non-hybrid mode, these two variables should be set to Talend IAM OIDC client identifier and client secret.


### IAM configuration

| Parameter    | Description                   | Value                      |
| ------------ | ----------------------------- | -------------------------- |
| `tdp_iam_ip` | Host IP address of IAM server | Default value: `localhost` |

### Event propagation

| Parameter                     | Description                          | Value                                |
| ----------------------------- | ------------------------------------ | ------------------------------------ |
| `tdp_dataprep_event_listener` | Mechanism used for event propagation | Possible values: `spring` or `kafka` |

### Live datasets

The live dataset feature allows creating a job in Talend Studio, executing it on demand in the Talend Administration Center, and retrieving a dataset with the sample data directly in Talend Data Preparation.

| Parameter                      | Description                                                                                                                                                                                                              | Value                           |
| ------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------- |
| `tdp_live_dataset_location`    | Location of source                                                                                                                                                                                                       | Possible values: `tac` or `tic` |
| `tdp_live_dataset_url`         | URL to the Talend Administration Center instance used to list execution tasks as dataset sources                                                                                                                         |                                 |
| `tdp_live_dataset_task_prefix` | Prefix used to list Talend Administration Center tasks in the Talend Data Preparation interface and create live datasets. Only the tasks with this prefix will be listed when importing data with the Talend Job option. | Default value: `dataprep_`      |

### MongoDB connection settings

| Parameter                          | Description                                     | Value                                        |
| ---------------------------------- | ----------------------------------------------- | -------------------------------------------- |
| `tdp_mongodb_host`                 | Host of MongoDB                                 | Default value: `localhost`                   |
| `tdp_mongodb_port`                 | Port of MongoDB                                 | Default value: `27017`                       |
| `tdp_mongodb_database`             | MongoDB database                                | Default value: `dataprep`                    |
| `tdp_mongodb_user`                 | User name of MongoDB user                       | Default value: `dataprep-user`               |
| `tdp_mongodb_password`             | Password of MongoDB user                        |                                              |
| `tdp_multi_tenancy_mongodb_active` | Whether MongoDB is set up in multi-tenancy mode | Possible values: `false` (default) or `true` |

### Authentication parameters

| Parameter                          | Description                  | Value                         |
| ---------------------------------- | ---------------------------- | ----------------------------- |
| `tdp_security_provider`            | TDP security provider        | Only possible value: `oauth2` |
| `tdp_security_token_secret`        | Secret used to sign tokens   |                               |
| `tdp_security_token_renew_after`   | *Do not modify*              | Only possible value: `30`     |
| `tdp_security_token_invalid_after` | Session timeout (in seconds) | Default value: `3600`         |

### Spring framework settings

| Parameter                                  | Description                                          | Value                                                                            |
| ------------------------------------------ | ---------------------------------------------------- | -------------------------------------------------------------------------------- |
| `tdp_spring_profiles_active`               | Active Spring profile                                | Default value: `server-standalone`<br/>Do not modify unless instructed by Talend |
| `tdp_spring_http_multipart_maxFileSize`    | Maximum file size (in bytes) to transfer via HTTP    | Default value: `200000000` (200 MB)                                              |
| `tdp_spring_http_multipart_maxRequestSize` | Maximum request size (in bytes) to transfer via HTTP | Default value: `200000000` (200 MB)                                              |

### Dataset limits

| Parameter                           | Description                                                              | Value                                                                                                                  |
| ----------------------------------- | ------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------- |
| `tdp_dataset_records_limit`         | Maximum number of records in datasets. Additional records are truncated. | Default value: `10000`                                                                                                 |
| `tdp_dataset_local_file_size_limit` | Maximum file size of a locally stored dataset                            | Default value: `2000000000`                                                                                            |
| `tdp_dataset_imports`               | List of datasources available for the "dataset import" action            | Default value: `local,job,tcomp-JDBCDatastore,tcomp-SimpleFileIoDatastore,tcomp-SalesforceDatastore,tcomp-S3Datastore` |
| `tdp_dataset_list_limit`            | Maximum number of datasets listed                                        | Default value: `10`                                                                                                    |

### Cache management (location for cache and content storage)

| Parameter                              | Description                 | Value                        |
| -------------------------------------- | --------------------------- | ---------------------------- |
| `tdp_content_service_store`            | Content service store       | Only possible value: `local` |
| `tdp_content_service_store_local_path` | Path to store cache content | Default value: `data/`       |

### Preparation service configuration

| Parameter                            | Description                                    | Value               |
| ------------------------------------ | ---------------------------------------------- | ------------------- |
| `tdp_preparation_store_remove_hours` | Time (in hours) to keep preparation in storage | Default value: `24` |

### Lock on preparations (see documentation for details)

| Parameter                    | Description                 | Value                                |
| ---------------------------- | --------------------------- | ------------------------------------ |
| `tdp_lock_preparation_store` | Lock store for preparations | Possible values: `none` or `mongodb` |
| `tdp_lock_preparation_delay` | Delay in seconds            | Default value: `600` (10 minutes)    |

### Lucene index configuration

| Parameter                 | Description           | Value                                                                                           |
| ------------------------- | --------------------- | ----------------------------------------------------------------------------------------------- |
| `tdp_luceneIndexStrategy` | Lucene index strategy | Possible values: `singleton` (default) or `basic`<br/>Do not modify unless instructed by Talend |

### Parameters for asynchronous full run and sampling operations

| Parameter                            | Description                                                                                                                                                                                                                                                    | Value                                                                                                     |
| ------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- |
| `tdp_execution_store`                | Storage for async operations                                                                                                                                                                                                                                   | Possible values: `mongodb` (default), `in-memory`, `remote`<br/>Do not modify unless instructed by Talend |
| `tdp_async_operation_concurrent_run` | Maximum allowed concurrent runs. If there are more full runs than this parameter's value running in parallel, the remaining operations will be queued and resumed when there is an available slot. This value can be increased, according to the host capacity | Default value: `5`                                                                                        |

### Components Catalog configuration properties

| Parameter                                                   | Description                                                                                 | Value                                                  |
| ----------------------------------------------------------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------ |
| `tdp_tcomp_server_url`                                      | URL of the server hosting the Components Catalog, used to configure self service connectors | Default value: `http://localhost:8989/tcomp`           |
| `tdp_tcomp_SimpleFileIoDatastore_kerberosPrincipal_default` | *Do not modify*                                                                             | Only possible value: `${streams.kerberos.principal}`   |
| `tdp_tcomp_SimpleFileIoDatastore_kerberosKeytab_default`    | *Do not modify*                                                                             | Only possible value: `${streams.kerberos.keytab_path}` |
| `tdp_tcomp_SimpleFileIoDataset_path_default`                | *Do not modify*                                                                             | Only possible value: `${streams.hdfs.server.url}`      |
| `tdp_tcomp_SimpleFileIoDatastore_test_connection_visible`   | Whether to remove "test connection" step from Talend Components form                        | Possible values: `false` (default) or `true`           |

### Data Quality settings

| Parameter                                      | Description                                            | Value                                                              |
| ---------------------------------------------- | ------------------------------------------------------ | ------------------------------------------------------------------ |
| `tdp_dataquality_server_url`                   | URL of Data Quality server                             | Default value: `http://localhost:8187/`                            |
| `tdp_dataquality_indexes_file_location`        | Path to index storage                                  | Default value: `data/data-quality/org.talend.dataquality.semantic` |
| `tdp_dataquality_semantic_list_enable`         | Whether to display semantic types within dataprep UI   | Possible values: `true` (default) or `false`                       |
| `tdp_dataquality_semantic_update_enable`       | Whether to receive data quality updates (for 7.1 only) | Possible values: `true` (default) or `false`                       |
| `tdp_tsd_consumer_enabled`                     | Whether to receive data quality updates (for 7.2 only) | Possible values: `true` or `false` (default)                       |
| `tdp_dataquality_event_store`                  | *Do not modify*                                        | Only possible value: `mongodb`                                     |
| `tdp_spring_cloud_stream_kafka_binder_brokers` | Host of Kafka server                                   | Default value: `localhost`                                         |

### Streams Runner configuration parameters

To configure Talend Data Preparation with Big Data, use the following parameters:

| Parameter                          | Description                                                | Value                                        |
| ---------------------------------- | ---------------------------------------------------------- | -------------------------------------------- |
| `tdp_streams_enable`               | Whether to enable communication with Streams Runner server | Possible values: `true` (default) or `false` |
| `tdp_streams_flow_runner_url`      | URL of Streams Runner server                               | Default value: `http://localhost:9060`       |
| `tdp_streams_kerberos_principal`   | Kerberos principal                                         |                                              |
| `tdp_streams_kerberos_keytab_path` | Path of Kerveros keytab                                    |                                              |
| `tdp_streams_hdfs_server_url`      | URL of HDFS server                                         | Format: `hdfs://<host>:<port>/<filepath>`    |

### Single Sign-On (SSO) security configuration parameters

| Parameter                    | Description           | Value                                        |
| ---------------------------- | --------------------- | -------------------------------------------- |
| `tdp_security_basic_enabled` | Whether to enable SSO | Possible values: `false` (default) or `true` |

Do not modify the default settings of the following parameters unless instructed by Talend:

- `tdp_security_oidc_client_expectedIssuer`
- `tdp_iam_license_url`
- `tdp_security_oidc_client_keyUri`
- `tdp_security_oauth2_client_clientId`
- `tdp_security_oauth2_client_clientSecret`
- `tdp_security_oidc_client_claimIssueAtTolerance`
- `tdp_security_oauth2_resource_tokenInfoUri`
- `tdp_security_oauth2_resource_uri`
- `tdp_security_oauth2_resource_filter_order`
- `tdp_security_scim_enabled`
- `tdp_security_oauth2_client_access_token_uri`
- `tdp_security_oauth2_client_scope`
- `tdp_security_oauth2_client_user_authorization_uri`
- `tdp_security_oauth2_sso_login_use_forward`
- `tdp_server_session_cookie_name`
- `tdp_spring_session_store_type`
- `tdp_security_sessions`
- `tdp_security_user_password`
- `tdp_security_oidc_client_endSessionEndpoint`
- `tdp_security_oidc_client_logoutSuccessUrl`
- `tdp_security_oauth2_logout_uri`
- `tdp_security_oauth2_sso_login_path`
- `tdp_iam_scim_url`
- `tdp_security_oauth2_resource_tokenInfoUriCache_enabled`
- `tdp_tenant_account_cache_enabled`
- `tdp_gateway_api_service_url`
- `tdp_gateway_api_service_path`
- `tdp_zuul_servletPath`
- `tdp_zuul_routes_dq_path`
- `tdp_zuul_routes_dq_sensitiveHeaders`
- `tdp_zuul_routes_dq_url`
- `tdp_proxy_auth_routes_dq`
- `tdp_zuul_routes_api_path`
- `tdp_zuul_routes_api_sensitiveHeaders`
- `tdp_zuul_routes_api_url`
- `tdp_proxy_auth_routes_api`
- `tdp_zuul_sensitiveHeaders`
- `tdp_zuul_host_socket_timeout_millis`
- `tdp_zuul_host_connect_timeout_millis`

### Logging configuration parameters

| Parameter                                               | Description                                                                    | Value                                  |
| ------------------------------------------------------- | ------------------------------------------------------------------------------ | -------------------------------------- |
| `tdp_logging_file`                                      | Path to the logging file                                                       | Default value: `data/logs/app.log`     |
| `tdp_logging_pattern_level`                             | Level output pattern                                                           | Default value: `%5p [user %X{userId}]` |
| `tdp_logging_level_`                                    | Default logging level for all messages, not covered by specific logging levels | Default value: `WARN`                  |
| `tdp_logging_level_org_talend_dataprep`                 | Logging level for `org.talend.dataprep`                                        | Default value: `INFO`                  |
| `tdp_logging_level_org_talend_dataprep_api`             | Logging level for `org.talend.dataprep.api`                                    | Default value: `INFO`                  |
| `tdp_logging_level_org_talend_dataprep_dataset`         | Logging level for `org.talend.dataprep.dataset`                                | Default value: `INFO`                  |
| `tdp_logging_level_org_talend_dataprep_preparation`     | Logging level for `org.talend.dataprep.preparation`                            | Default value: `INFO`                  |
| `tdp_logging_level_org_talend_dataprep_transformation`  | Logging level for `org.talend.dataprep.transformation`                         | Default value: `INFO`                  |
| `tdp_logging_level_org_talend_dataprep_fullrun`         | Logging level for `org.talend.dataprep.fullrun`                                | Default value: `INFO`                  |
| `tdp_logging_level_org_talend_dataprep_api_dataquality` | Logging level for `org.talend.dataprep.api.dataquality`                        | Default value: `INFO`                  |
| `tdp_logging_level_org_talend_dataprep_configuration`   | Logging level for `org.talend.dataprep.configuration`                          | Default value: `INFO`                  |
| `tdp_logging_level_org_talend_dataquality_semantic`     | Logging level for `org.talend.dataquality.semantic`                            | Default value: `INFO`                  |

### Audit logging configuration parameters

| Parameter                         | Description                     | Value                                        |
| --------------------------------- | ------------------------------- | -------------------------------------------- |
| `tdp_audit_log_enabled`           | Whether to enable audit log     | Possible values: `true` (default) or `false` |
| `tdp_talend_logging_audit_config` | Configuration file of audit log | Default value: `config/audit.properties`     |

### CSV export settings

| Parameter                    | Description                 | Value                  |
| ---------------------------- | --------------------------- | ---------------------- |
| `tdp_default_text_enclosure` | Default enclosure character | Default value: `"`     |
| `tdp_default_text_escape`    | Default escape character    | Default value: `"`     |
| `tdp_default_text_encoding`  | Default encoding            | Default value: `UTF-8` |

### CSV import settings

| Parameter                           | Description                 | Value                        |
| ----------------------------------- | --------------------------- | ---------------------------- |
| `tdp_default_import_text_enclosure` | Default enclosure character | Default value: `"`           |
| `tdp_default_import_text_escape`    | Default escape character    | Default value: *empty value* |

### Dataset service provider setting

| Parameter                      | Description                                                                                                                                                                                                                                                                         | Value                         |
| ------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------- |
| `tdp_dataset_service_provider` | Service provider of datasets<br/>Data Preparation versions 7.1 and 7.2 only support `legacy` (embedded dataset service provider).<br/><br/>In future versions, `catalog` will also be supported, in which case "data catalog" or "TMC" will be used as the dataset service provider | Only possible value: `legacy` |

### Extra variables

| Parameter                              | Description                                    | Value                                                                              |
| -------------------------------------- | ---------------------------------------------- | ---------------------------------------------------------------------------------- |
| `tdp_async_runtime_contextPath`        | Runtime context path for async operations      | Default value: `/api`                                                                  |
| `tdp_spring_mvc_async_request_timeout` | Timeout (in milliseconds) for async executions | Default value: `600000`<br/>This value may need to be increased for large datasets |

### Logging properties

| Parameter                           | Description                                                                                                              | Value                                                                                                                                                                      |
| ----------------------------------- | ------------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `tdp_root_logger`                   | Logger name (SLF4J) prefix added to the event category                                                                   | Default value: `audit`                                                                                                                                                          |
| `tdp_backend`                       | Logging backend. If set to `auto`, the audit library will try to detect and use the logging library is present           | Possible values: `auto`, `logback`, `log4j1`                                                                                                                               |
| `tdp_encoding`                      | Encoding to use when writing events using appenders                                                                      | Default value: `UTF-8`                                                                                                                                                          |
| `tdp_application_name`              | Name of the application that logs audit events. This value will be put into MDC for each logged event                    | Default value: `Data Preparation`                                                                                                                                          |
| `tdp_instance_name`                 | Name of the instance of the service. This value will be put into MDC for each logged event                               | Default value: `DefaultInstance`                                                                                                                                           |
| `tdp_propagate_appender_exceptions` | Behaviour of API calls if one or more appenders could not process the event. *Only used in Data Preparation version 7.1* | Possible values: `all` (default), `none`                                                                                                                                   |
| `tdp_log_appender`                  | Comma-separated list of log appender types                                                                               | Possible values: `socket`, `file`, `console`, `http`<br/>Ansible only supports `http` or `file`. To use other settings, update the file `config/audit.properties` directly |

### Logging - File appender properties

The file appender puts log entries into a JSON file. In most cases, there should be a FileBeat instance that picks up new messages and sends them to Logstash.

| Parameter                     | Description                        | Value                                |
| ----------------------------- | ---------------------------------- | ------------------------------------ |
| `tdp_appender_file_path`      | Path to the log file               | Default value: `data/logs/audit.log` |
| `tdp_appender_file_maxsize`   | Maximum file size (in bytes)       | Default value: `52428800`            |
| `tdp_appender_file_maxbackup` | Maximum number of backup log files | Default value: `20`                  |

### Logging - HTTP appender properties

| Parameter                 | Description                                   | Value                                        |
| ------------------------- | --------------------------------------------- | -------------------------------------------- |
| `tdp_appender_http_url`   | URL of target where logging data will be sent | Default value: `http://localhost:8057/`                            |
| `tdp_appender_http_async` | Whether to use asynchronous mode              | Possible values: `true` (default) or `false` |

### Spark properties

Apache Spark is a fast and general-purpose cluster computing system. It provides high-level APIs in Java, Scala, Python and R, and an optimized engine that supports general execution graphs. The following properties can be set to be used by Spark:

| Parameter                      | Description                                                                    | Value               |
| ------------------------------ | ------------------------------------------------------------------------------ | ------------------- |
| `tdp_spark_executor_memory`    | Memory to use per executor process                                             | Default value: `3g` |
| `tdp_spark_executor_instances` | Number of executors requested                                                  | Default value: `10` |
| `tdp_spark_executor_cores`     | Number of cores to use on each executor. Used in YARN and standalone mode only | Default value: `4`  |

More information about Spark configuration properties can be found at https://spark.apache.org/docs/1.6.2/configuration.html

## Connection to AWS S3

**Talend Data Preparation** requires connection to Minio (or AWS S3) server to share semantic dictionary with **TSD**.
If you do not have an existing Minio / AWS S3 account, then embedded Minio server (**minio** role) can be used instead.

The following variables control the connection to Minio / AWS S3 and by default they are set to use embedded **minio** role:

| Parameter      | Description        | Default value                                                    |
|----------------|--------------------|------------------------------------------------------------------|
| tdp_s3endpoint | S3 endpoint URL    | `http://localhost:9000`                                          |
| tdp_s3bucket   | Bucket name        | `default-bucket`                                                 |
| tdp_s3region   | Used AWS S3 region | `us-east-1` (do not change it if using embedded **minio** role)  |
| tdp_s3user     | AWS S3 access key  | `usr7xJ0agsFq`                                                   |
| tdp_s3pass     | AWS S3 secret key  | `pwd9jYF26Van`                                                   |
| tdp_basepath   | The base path      | *(empty value)*                                                  |

## Dependencies

The following roles must be used to successfully install and deploy Talend Data Preparation:

- java
- talend-repo
- kafka (to use the Talend Kafka package, otherwise an external Kafka server must be used)
- mongodb (to use the Talend MongoDB package, otherwise an external MongoDB server must be used)

## Example Playbook

The dependency roles listed above must be defined before the **tdp** role in the playbook.

```yaml
- hosts: tdp-host
  become: yes
  roles:
    - java
    - talend-repo
    - kafka
    - mongodb
    - tdp
```

