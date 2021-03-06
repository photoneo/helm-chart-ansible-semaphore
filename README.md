# Helm for Ansible Semaphore
[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/semaphore)](https://artifacthub.io/packages/search?repo=semaphore)

[Ansible Semaphore](https://ansible-semaphore.com/) is a moder graphical UI for Ansible.


## Requirements
1. Helm3


## Configuration

The following table lists the configurable parameters of the **Ansible Semaphore** chart and their default values.

| Parameter                             | Description                                   | Default                                                    |
| -------------------------------       | -------------------------------               | ---------------------------------------------------------- |
| `fullnameOverride`                    | Fullname override                             | ""                                           |
| `nameOverride`                        | Applicatio name override                      | ""                                           |
| `namespaceOverride`                   | Namespace override                            | ""                                           |
| `chartNameOverride`                   | Chart name override                           | ""                                           |
| `semaphore.image`                     | Image of the semaphore application            | "ansiblesemaphore/semaphore:v2.8.53" |
| `semaphore.imagePullPolicy`           | The image pull policy                         | "IfNotPresent" |
| `existingSecretSSHDir`                | Secret containing SSH files to be loaded into the ssh directory                         | "" |
| `semaphore.containerPort`             | Default application container port            | 3000 |
| `config.web_host`                     | Web host URL                                  | "" |
| `config.email_alert`                  | Use e-mail alerting                           | false |
| `config.email_host`                   | E-mail host for alerting                      | "" |
| `config.email_port`                   | E-mail port for alerting                      | "" |
| `config.email_username`               | E-mail user for alerting                      | "" |
| `config.email_userpassword`           | E-mail user's password for alerting           | "" |
| `config.email_sender`                 | E-mail sender description                     | "" |
| `service.enabled`                     | Enable service for the application            | true |
| `service.type`                        | Service type                                  | "ClusterIP" |
| `service.port`                        | Service port                                  | 3000 |
| `database.enabled`                    | Enable in-place database                      | true |
| `database.image`                      | Database image                                | "postgres:14-alpine" |
| `database.imagePullPolicy`            | Database image pull policy                    | "IfNotPresent" |
| `database.persistenceEnabled`         | Enable database persistence                   | true |
| `database.volumeSize`                 | Persistend volume size                        | 5Gi |
| `database.persistentVolumeClaimNameOverride`  | PVC override                          | "" |
| `database.containerPort`              | Database container port                       | 5432 |
| `database.config.host`                | Database internal host name                   | "localhost" |
| `database.config.port`                | Database internal port                        | 5432 |
| `database.config.databaseName`        | Database name                                 | "semaphore" |
| `database.config.userName`            | Database user name                            | "" |
| `database.config.userPassword`        | Database user password                        | "" |
| `ingress.enabled`                     | Enable ingress                                | true |
| `ingress.labels`                      | Additional ingress labels                     | {} |
| `ingress.annotations`                 | Additional ingress annotations                | {} |
| `ingress.ingressClassName`            | Ingress class name                            | Nil |
| `ingress.path`                        | Ingress application path                      | "/" |
| `ingress.hostName`                    | Ingress hostname                              | Nil |
| `ingress.tls`                         | Ingress TLS                                   | Nil |
| `backup.enabled`                      | Enable backups                                | false |
| `backup.schedule`                     | Backup schedule                               | "" |
| `backup.activeDeadlineSeconds`        | Job retention period in seconds               | "" |
| `backup.gcp.projectId`                | Google Project ID                             | "" |
| `backup.gcp.serviceAccountEmail`      | Service account's e-mail form                 | "" |
| `backup.gcp.keyJson`                  | The service account key in a JSON string format  | "{}" |
| `backup.gcp.bucket`                   | GCP bucket name                               | "" |
| `backup.gcp.bucketDirectory`          | Directory path inside the GCP bucket          | "" |
| `backup.postgresql.extraOptions`      | Extra options to be used on database dump.    | "" |
