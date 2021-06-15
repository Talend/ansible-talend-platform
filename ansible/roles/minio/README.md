# MinIO

This role installs **MinIO local server** (required by roles tds, tsd and tdp).

Make sure you have completed the requirements listed in the [root README](../../../README.md) file.

## Role variables

Before running the script, you can change the following variables in the *defaults/main.yml* file:

> **Note**: You can find details about each application installed using these Ansible roles in the corresponding RPM documentation on [Talend Help Center](https://help.talend.com/search/all?query=rpm&content-lang=en-US).

### MinIO RPM version

| Parameter           | Description       | Value                          |
| ------------------- | ----------------- | ------------------------------ |
| `minio_pkg_version` | Minio RPM version | Example: `{{ rpm_version }}-1` |

### Systemd

| Parameter             | Description                             | Value                           |
| --------------------- | --------------------------------------- | ------------------------------- |
| `app_install_systemd` | Whether to install as a systemd service | Supported values: `yes` or `no` |

### Minio port

| Parameter    | Description                          | Value                 |
| ------------ | ------------------------------------ | --------------------- |
| `minio_port` | TCP/IP port used by the MinIO server | Default value: `9000` |

### MinIO bucket name

| Parameter      | Description               | Value                           |
| -------------- | ------------------------- | ------------------------------- |
| `minio_bucket` | Name of bucket to be used | Default value: `default-bucket` |

### AccessKey, SecretKey and Region

| Parameter         | Description                                   | Value                                   |
| ----------------- | --------------------------------------------- | --------------------------------------- |
| `minio_accesskey` | The Access Key to be used by the MinIO server | Default: `usr7xJ0agsFq`                 |
| `minio_secretkey` | The Secret Key to be used by the MinIO server | Default: `pwd9jYF26Van`                 |
| `minio_region`    | Region to be used by the MinIO server         | Use only the default value: `us-east-1` |

> **Note**: If you update any of these values from defaults, then you will need to update also AWS S3 values in tds, tsd and tdp roles

## Example playbook

```yaml
- hosts: tds-host
  become: yes
  roles:
    - java
    - talend-repo
    - tomcat
    - kafka
    - mongodb
    - minio
    - tsd
    - tds
    - tdp
```
