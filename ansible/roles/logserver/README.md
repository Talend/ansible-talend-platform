# Talend LogServer

This role installs **Talend LogServer**.

Make sure you have completed the requirements listed in the [Root README](../../../README.md) file.

## Role variables

Before running the script, you can change the following variables in the *defaults/main.yml* file:

> **Note**: You can find details about each application installed using these Ansible roles in the corresponding RPM documentation on [Talend Help Center](https://help.talend.com/search/all?query=rpm&content-lang=en-US).

### Systemd

| Parameter             | Description                             | Value                           |
| --------------------- | --------------------------------------- | ------------------------------- |
| `app_install_systemd` | Whether to install as a systemd service | Supported values: `yes` or `no` |

### Logstash (*logstash-talend.conf* settings)

  To configure values in the `logstash-talend.conf` file, set the following parameters:
  - `logserv_input_beats_port`
  - `logserv_input_http_port`
  - `logserv_input_http_codec`
  - `logserv_input_http_type`
  - `logserv_output_elasticsearch_host`
  - `logserv_output_elasticsearch_index`

  For example:
  ```
  logserv_input_beats_port: 5044

  logserv_input_http_port: 8057
  logserv_input_http_codec: "json"
  logserv_input_http_type: "Audit"

  logserv_output_elasticsearch_host: "localhost:9200"
  logserv_output_elasticsearch_index: "%{esIndex}"
  ```
### ElasticSearch

| Parameter                 | Description                     | Value                 |
| ------------------------- | ------------------------------- | --------------------- |
| `logserv_es_cluster_name` | Name of ElasticSearch cluster   |                       |
| `logserv_es_node_name`    | Name of ElasticSearch node      |                       |
| `logserv_es_network_host` | ElasticSearch network host      |                       |
| `logserv_es_http_port`    | HTTP port used by ElasticSearch | Default value: `9200` |

### Kibana

| Parameter                          | Description                                              | Value                                                                                                                                                                                                                         |
| ---------------------------------- | -------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `logserv_kibana_server_port`       | Port used by Kibana                                      | Default value: `5601`                                                                                                                                                                                                         |
| `logserv_kibana_server_host`       | Address to which the Kibana server will bind             | Default value: `localhost`<br/>The value `localhost` usually means that remote machines will not be able to connect. To allow connections from remote users, set this parameter to a non-loopback address. Example: `0.0.0.0` |
| `logserv_kibana_server_name`       | Display name of the Kibana server                        |                                                                                                                                                                                                                               |
| `logserv_kibana_elasticsearch_url` | URL of the ElasticSearch instance to use for all queries | Default value: `http://localhost:9200`                                                                                                                                                                                        |

If the ElasticSearch instance that is proxied through the Kibana server requires basic authentication, Kibana users will need to authenticate.

| Parameter                    | Description                            |
| ---------------------------- | -------------------------------------- |
| `logserv_kibana_es_username` | User name of Kibana ElasticSearch user |
| `logserv_kibana_es_password` | Password of Kibana ElasticSearch user  |

## Example playbook

```yaml
- hosts: tac-host
  become: yes
  roles:
    - java
    - talend-repo
    - tomcat
    - tac
    - talend-logserver
```
