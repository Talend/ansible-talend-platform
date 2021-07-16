# Talend Data Stewardship

This role installs **Talend Data Stewardship**.

Make sure you have completed the requirements listed in the [Root README](../../../README.md) file.

## Role variables

Before running the script, you can change the following variables in the *defaults/main.yml* file:

> **Note**: You can find details about each application installed using these Ansible roles in the corresponding RPM documentation on [Talend Help Center](https://help.talend.com/search/all?query=rpm&content-lang=en-US).

The following table lists the configurable parameters for the TDS playbook and their default values.
The parameters with `First Install Only` as `Yes` can only be set at initial installation. Any subsequent changes to the values are not taken into account during an update.

| Parameter                         | First Install Only | Description                                                                                                                | Default                      |
| --------------------------------- | ------------------ | -------------------------------------------------------------------------------------------------------------------------- | ---------------------------- |
| `app_install_systemd`             | Yes                | Installation of the service in systemd: `yes` or `no`                                                                      | `yes`                        |
| `app_use_talend_tomcat`           | Yes                | Use Talend Tomcat: `yes` or `no`                                                                                           | `yes`                        |
| `app_tomcat_port`                 | Yes                | Port of Tomcat                                                                                                             | `19999`                      |
| `app_tomcat_home`                 | Yes                | Path to Tomcat home (only if using a custom Tomcat - `app_use_talend_tomcat` = `no`)                                       | `/opt/tomcat`                |
| `app_tomcat_mode`                 | Yes                | Tomcat mode: `direct` or `shared` (only if using a custom Tomcat - `app_use_talend_tomcat` = `no`)                         | `direct`                     |
| `app_tomcat_setup`                | Yes                | Let RPM update customer's tomcat configuration like ports (only if using a custom Tomcat - `app_use_talend_tomcat` = `no`) | `no`                         |
| `tds_kafka_host`                  | No                 | Host of Kafka broker                                                                                                       | `localhost`                  |
| `tds_kafka_port`                  | No                 | Port of Kafka broker                                                                                                       | `9092`                       |
| `tds_mongo_host`                  | No                 | Host of MongoDB                                                                                                            | `localhost`                  |
| `tds_mongo_port`                  | No                 | Port of MongoDB                                                                                                            | `27017`                      |
| `tds_mongo_database`              | No                 | Name of the TDS MongoDB database                                                                                           | `tds`                        |
| `tds_mongo_username`              | No                 | Username of the TDS MongoDB database                                                                                       | `tds-user`                   |
| `tds_mongo_password`              | No                 | Password of the TDS MongoDB database. Default values for security settings must be changed                                 | `duser`                      |
| `tds_audit_enabled`               | No                 | Enables the audit for TDS. This is taken into account only when `tds_hybrid_mode` = `no`. Possible values are `true` and `false`. | `true`                |
| `tds_appender_http_url`           | No                 | URL for http log appender.                                                                                                 | `http://localhost:8057/`     |
| `tds_security_scim_url`           | No                 | URL to Talend Identity and Access Management SCIM                                                                          | `http://localhost:9080/scim` |
| `tds_security_oidc_url`           | No                 | URL to Talend Identity and Access Management                                                                               | `http://localhost:9080/oidc` |
| `tds_security_oidc_user_auth_url` | No                 | URL to Talend Identity and Access Management User Authentication                                                           | `http://localhost:9080/oidc` |
| `tds_use_semantic_dictionary`     | No                 | Enable link with Talend Dictionary Service: `yes` (only if you have a license) or `no`                                    | `yes`                        |
| `tds_semantic_dictionary_url`     | No                 | URL of Talend Dictionary Service                                                                                         | `http://localhost:8187`      |
| `tds_use_tdp_switch`              | No                 | Enable Talend Data Preparation app switch: `yes` (only if you have a license) or `no`                                      | no                           |
| `tds_front_tdp_url`               | No                 | URL of Talend Data Preparation                                                                                             | `http://localhost:9999`      |
| `tds_language`                    | No                 | Set the language. Supported values: `en-US` or `fr-FR` or `ja-JP` or `zh-CN`                                               | `en-US`                      |
| `tds_hybrid_mode`                 | No                 | Installation of TDS in Hybrid mode. Available values are `yes` and `no`                                                    | `no`                         |
| `tds_hybrid_region`               | No                 | Hybrid region location, can be one of `us`, `eu` or `ap`                                                                   | `us`                         |
| `tds_hybrid_data_center`          | No                 | Hybrid data center to use, provider-specific notation (for AWS, can be `us-east-1`, `eu-central-1` or `ap-south-1`)        | `us-east-1`                  |
| `tds_hybrid_cloud_provider`       | No                 | The cloud provider for Hybrid mode, can be either `AWS` or `azure`                                                         | `AWS`                        |
| `tds_oidc_id`                     | No                 | Talend Identity and Access Management OIDC client identifier.<br>For Hybrid mode: Client ID for your account (retrieved from Talend Management Console)  | `tl6K6ac7tSE-LQ`             |
| `tds_oidc_secret`                 | No                 | Talend Identity and Access Management OIDC password.<br>For Hybrid mode: Client Secret for your account (retrieved from Talend Management Console)  | `sLbyFKTzM8F0dTL10mHd3A`     |

## Dependencies

The following roles must be used to successfully install TDS:

- java
- tomcat
- iam
- tac
- mongodb
- kafka
- tsd (only if you have the license for TSD)
- tdp (only if you have the license for TDP and want to use the app switcher in the TDS interface)

## Example playbook

The dependency roles listed above must be defined before the **tds** role in the playbook. For example:

```yaml
- hosts: tds-host
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
    - tds
```

> **Note**: Remove `tsd` from the example above if you do not have the licence for it.
