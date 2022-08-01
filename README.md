# Helm for Ansible Semaphore

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/semaphore)](https://artifacthub.io/packages/search?repo=semaphore)

[Ansible Semaphore](https://ansible-semaphore.com/) is a modern graphical UI for Ansible.

## Requirements

1. Helm3

## Configuration

The following table lists the configurable parameters of the **Ansible Semaphore** chart and their default values.

| Parameter                                      | Description                                                                 | Default                                     |
|------------------------------------------------|-----------------------------------------------------------------------------|---------------------------------------------|
| `fullnameOverride`                             | Fullname override                                                           | ""                                          |
| `nameOverride`                                 | Application name override                                                   | ""                                          |
| `namespaceOverride`                            | Namespace override                                                          | ""                                          |
| `chartNameOverride`                            | Chart name override                                                         | ""                                          |
| `semaphore.image.name`                         | Image of the semaphore application                                          | "ansiblesemaphore/semaphore"                |
| `semaphore.image.tag`                          | Image of the semaphore application                                          | "v2.8.53"                                   |
| `semaphore.imagePullPolicy`                    | The image pull policy                                                       | "IfNotPresent"                              |
| `semaphore.containerPort`                      | Default application container port                                          | 3000                                        |
| `semaphore.existingSecretSSHDir`               | Secret containing SSH files to be loaded into the ssh directory             | ""                                          |
| `semaphore.config.web_host`                    | Web host URL                                                                | ""                                          |
| `semaphore.config.email_alert`                 | Use e-mail alerting                                                         | false                                       |
| `semaphore.config.email_host`                  | E-mail host for alerting                                                    | ""                                          |
| `semaphore.config.email_port`                  | E-mail port for alerting                                                    | ""                                          |
| `semaphore.config.email_username`              | E-mail user for alerting                                                    | ""                                          |
| `semaphore.config.email_userpassword`          | E-mail user's password for alerting                                         | ""                                          |
| `semaphore.config.email_sender`                | E-mail sender description                                                   | ""                                          |
| `semaphore.service.enabled`                    | Enable service for the application                                          | true                                        |
| `semaphore.service.type`                       | Service type                                                                | "ClusterIP"                                 |
| `semaphore.service.port`                       | Service port                                                                | 3000                                        |
| `semaphore.ingress.enabled`                    | Enable ingress                                                              | true                                        |
| `semaphore.ingress.labels`                     | Additional ingress labels                                                   | {}                                          |
| `semaphore.ingress.annotations`                | Additional ingress annotations                                              | {}                                          |
| `semaphore.ingress.ingressClassName`           | Ingress class name                                                          | nginx                                       |
| `semaphore.ingress.path`                       | Ingress application path                                                    | "/"                                         |
| `semaphore.ingress.hostName`                   | Ingress hostname                                                            | "semaphore.example.com"                     |
| `semaphore.ingress.tls`                        | Ingress TLS                                                                 | Nil                                         |
| `database.createInstance`                      | Create database statefulset                                                 | true                                        |
| `database.image.name`                          | Database image name                                                         | "postgres"                                  |
| `database.image.tag`                           | Database image tag                                                          | "14-alpine"                                 |
| `database.imagePullPolicy`                     | Database image pull policy                                                  | "IfNotPresent"                              |
| `database.persistence.enabled`                 | Enable database persistence                                                 | true                                        |
| `database.persistence.volumeClaimNameOverride` | PVC override                                                                | ""                                          |
| `database.persistence.volumeSize`              | Persistent volume claim size                                                | 10Gi                                        |
| `database.persistence.accessModes`             | Persistent volume claim access modes                                        | ReadWriteOnce                               |
| `database.permissions.userId`                  | Id of database user in pod                                                  | 70                                          |
| `database.permissions.groupId`                 | Id of database group in pod                                                 | 70                                          |
| `database.config.host`                         | Database internal host name                                                 | "semaphore-database"                        |
| `database.config.port`                         | Database internal port                                                      | 5432                                        |
| `database.config.databaseName`                 | Database name                                                               | "semaphore"                                 |
| `database.config.userName`                     | Database user name                                                          | ""                                          |
| `database.config.userPassword`                 | Database user password                                                      | ""                                          |
| `database.sslCertificate.directory`            | Absolute path where ssl certificate files should be placed                  | "/var/lib/postgresql/database-certificates" |
| `database.sslCertificate.filename`             | Base name for certificate files                                             | "postgres"                                  |
| `database.service.type`                        | Type of service for database stateful set                                   | ClusterIp                                   |
| `database.service.port`                        | Port to expose database service on                                          | 5432                                        |
| `database.secret.useExisting`                  | Toggle to create new or use existing database secret                        | false                                       |
| `database.secret.name`                         | Name of secret used when creating or referencing existing one               | "semaphore-database-secrets"                |
| `database.secret.keys.username`                | Key in secret used for database user name value                             | "userName"                                  |
| `database.secret.keys.password`                | Key in secret used for database user password value                         | "userPassword"                              |
| `database.secret.keys.databaseName`            | Key in secret used for database name value                                  | "databaseName"                              |
| `database.secret.keys.host`                    | Key in secret used for database host value                                  | "host"                                      |
| `database.secret.keys.port`                    | Key in secret used for database port value                                  | "port"                                      |
| `backup.enabled`                               | Enable backups                                                              | false                                       |
| `backup.schedule`                              | Backup schedule                                                             | ""                                          |
| `backup.activeDeadlineSeconds`                 | Job retention period in seconds                                             | ""                                          |
| `backup.image.name`                            | Image name used to upload db backup to gcs                                  | "google/cloud-sdk"                          |
| `backup.image.tag`                             | Image tag used to upload db backup to gcs                                   | "slim"                                      |
| `backup.secret.useExisting`                    | Toggle to create new or use existing gcp backup secret                      | false                                       |
| `backup.secret.name`                           | Name of secret used when creating or referencing existing one               | "semaphore-database-backup-gcp"             |
| `backup.secret.keys.projectId`                 | Key in secret used for gcp backup projectId value                           | "projectId"                                 |
| `backup.secret.keys.keyJson`                   | Key in secret used for gcp backup keyJson value                             | "key.json"                                  |
| `backup.secret.keys.serviceAccountEmail`       | Key in secret used for gcp backup serviceAccountEmail value                 | "serviceAccountEmail"                       |
| `backup.secret.keys.bucket`                    | Key in secret used for gcp backup bucket value                              | "bucket"                                    |
| `backup.secret.keys.bucketDirectory`           | Key in secret used for gcp backup bucketDirectory value                     | "bucketDirectory"                           |
| `backup.gcp.projectId`                         | Google Project ID                                                           | ""                                          |
| `backup.gcp.serviceAccountEmail`               | Service account's e-mail form                                               | ""                                          |
| `backup.gcp.keyJson`                           | The service account key in a JSON string format                             | "{}"                                        |
| `backup.gcp.bucket`                            | GCP bucket name                                                             | ""                                          |
| `backup.gcp.bucketDirectory`                   | Directory path inside the GCP bucket                                        | ""                                          |
| `backup.pgDump.extraOptions`                   | Extra options to be used for database dump command.                         | ""                                          |
| `restore.enabled`                              | Enable database restoration                                                 | false                                       |
| `restore.archiveFileName`                      | Archive filename without extension from gcp storage                         | "semaphore-YYYY-MM-DD_HH:MM"                |
| `restore.pgDumpFileName`                       | Database dump file from archive filename without extension from gcp storage | "database-dump.sql"                         |
| `restore.image.name`                           | Image name used to download db backup from gcs                              | "google/cloud-sdk"                          |
| `restore.image.tag`                            | Image tag used to download db backup from gcs                               | "slim"                                      |
| `restore.secret.useExisting`                   | Toggle to create new or use existing gcp restore secret                     | false                                       |
| `restore.secret.name`                          | Name of secret used when creating or referencing existing one               | "semaphore-database-restore-gcp"            |
| `restore.secret.keys.projectId`                | Key in secret used for gcp restore projectId value                          | "projectId"                                 |
| `restore.secret.keys.keyJson`                  | Key in secret used for gcp restore keyJson value                            | "key.json"                                  |
| `restore.secret.keys.serviceAccountEmail`      | Key in secret used for gcp restore serviceAccountEmail value                | "serviceAccountEmail"                       |
| `restore.secret.keys.bucket`                   | Key in secret used for gcp restore bucket value                             | "bucket"                                    |
| `restore.secret.keys.bucketDirectory`          | Key in secret used for gcp restore bucketDirectory value                    | "bucketDirectory"                           |
| `restore.gcp.projectId`                        | Google Project ID                                                           | ""                                          |
| `restore.gcp.serviceAccountEmail`              | Service account's e-mail form                                               | ""                                          |
| `restore.gcp.keyJson`                          | The service account key in a JSON string format                             | "{}"                                        |
| `restore.gcp.bucket`                           | GCP bucket name                                                             | ""                                          |
| `restore.gcp.bucketDirectory`                  | Directory path inside the GCP bucket                                        | ""                                          |
| `restore.psql.extraOptions`                    | Extra options to be used on psql restore command.                           | ""                                          |
