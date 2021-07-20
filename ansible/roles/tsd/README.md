# Talend Dictionary Service

This role installs **Talend Dictionary Service**.

Make sure you have completed the requirements listed in the [Root README](../../../README.md) file.

## Role variables

Before running the script, you can change the following variables in the *defaults/main.yml* file:

> **Note**: You can find details about each application installed using these Ansible roles in the corresponding RPM documentation on [Talend Help Center](https://help.talend.com/search/all?query=rpm&content-lang=en-US).

The following table lists the configurable parameters for the TDS playbook and their default values.
The parameters with `First Install Only` as `Yes` can only be set at initial installation. Any subsequent changes to the values are not taken into account during an update.

| Parameter               | First Install Only | Description                                                                                                                | Default                      |
| ----------------------- | ------------------ | -------------------------------------------------------------------------------------------------------------------------- | ---------------------------- |
| `app_install_systemd`   | Yes                | Installation of the service in systemd: `yes` or `no`                                                                      | `yes`                        |
| `app_use_talend_tomcat` | Yes                | Use Talend Tomcat: `yes` or `no`                                                                                           | `yes`                        |
| `app_tomcat_port`       | Yes                | Port of Tomcat                                                                                                             | `19999`                      |
| `app_tomcat_home`       | Yes                | Path to Tomcat home (only if using a custom Tomcat - `app_use_talend_tomcat` = `no`)                                       | `/opt/tomcat`                |
| `app_tomcat_mode`       | Yes                | Tomcat mode: `direct` or `shared` (only if using a custom tomcat - `app_use_talend_tomcat` = `no`)                         | `direct`                     |
| `app_tomcat_setup`      | Yes                | Let RPM update customer's Tomcat configuration like ports (only if using a custom Tomcat - `app_use_talend_tomcat` = `no`) | `no`                         |
| `tsd_kafka_host`        | No                 | Host of Kafka broker                                                                                                       | `localhost`                  |
| `tsd_kafka_port`        | No                 | Port of Kafka broker                                                                                                       | `9092`                       |
| `tsd_zookeeper_host`    | No                 | Host of Zookeeper                                                                                                          | `localhost`                  |
| `tsd_zookeeper_port`    | No                 | Port of Zookeeper broker                                                                                                   | `2181`                       |
| `tsd_mongo_host`        | No                 | Host of MongoDM                                                                                                            | `localhost`                  |
| `tsd_mongo_port`        | No                 | Port of MongoDB                                                                                                            | `27017`                      |
| `tsd_mongo_database`    | No                 | Name of the TSD MongoDB database                                                                                           | `dqdict`                     |
| `tsd_mongo_username`    | No                 | User name of the TSD MongoDB database                                                                                      | `tsd-user`                   |
| `tsd_mongo_password`    | No                 | Password of the TSD MongoDB database. Default values for security settings must be changed                                 | `duser`                      |
| `tsd_security_scim_url` | No                 | URL to Talend Identity and Access Management SCIM                                                                          | `http://localhost:9080/scim` |
| `tsd_security_oidc_url` | No                 | URL to Talend Identity and Access Management                                                                               | `http://localhost:9080/oidc` |
| `tsd_oidc_id`           | No                 | Talend Identity and Access Management OIDC client identifier.<br>For Hybrid mode: Client ID for your account (retrieved from Talend Management Console) | `tl6K6ac7tSE-LQ`             |
| `tsd_oidc_secret`       | No                 | Talend Identity and Access Management OIDC password.<br>For Hybrid mode: Client Secret for your account (retrieved from Talend Management Console)     | `sLbyFKTzM8F0dTL10mHd3A`     |
| `tsd_hybrid_mode`       | No                 | Installation in Hybrid mode (see docs for details), available values are `yes` or `no`                                     | `no`                         |
| `tsd_hybrid_region`     | No                 | For Hybrid mode, specifies a region to use, available values are `us`, `eu` or `ap`                                        | `us`                         |

## Connection to Minio / AWS S3 service

**Talend Dictionary Service** new architecture relies on Minio (or AWS S3) server to share semantic dictionaries.
If you do not have an existing Minio (or AWS S3) account, then embedded Minio server (**minio** role) can be used instead.

The following variables control the connection to Minio / AWS S3 and by default they are set to use embedded **minio** role:

| Parameter      | Description         | Default value                                                    |
|----------------|---------------------|------------------------------------------------------------------|
| tsd_s3endpoint | AWS S3 endpoint URL | `http://localhost:9000`                                          |
| tsd_s3bucket   | Bucket name         | `default-bucket`                                                 |
| tsd_s3region   | Used AWS S3 region  | `us-east-1` (do not change it if using embedded **minio** role)  |
| tsd_s3user     | AWS S3 access key   | `usr7xJ0agsFq`                                                   |
| tsd_s3pass     | AWS S3 secret key   | `pwd9jYF26Van`                                                   |
| tsd_basepath   | The base path       | *(empty value)*                                                  |

## Dependencies

The following roles must be used to successfully install TSD:

Roles listed above must be defined before the **tsd** role in the playbook.

## Example playbook

The dependency roles listed above must be defined before the **tsd** role in the playbook For example:

```yaml
- hosts: tsd-host
  become: yes
  roles:
    - java
    - talend-repo
    - tomcat
    - kafka
    - mongodb
    - tac
    - iam
    - tsd
```
