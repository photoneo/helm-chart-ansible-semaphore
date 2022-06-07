{{/*
 Override of namespace value
*/}}
{{- define "semaphore.namespace" -}}
{{- if .Values.namespaceOverride }}
namespace: {{ .Values.namespaceOverride }}
{{- end }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "semaphore.name" -}}
{{- default .Chart.Name .Values.chartNameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "semaphore.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
url in format {protocol}://{host}{path} on which semaphore will be available to public
*/}}
{{- define "semaphore.config.webHost" }}
{{- if .Values.semaphoreIngress.enabled }}
{{- printf "%s://%s%s" .Values.urlConfig.protocol .Values.urlConfig.host .Values.urlConfig.path }}
{{- end }}
{{- end }}


{{/*
Common labels
*/}}
{{- define "semaphore.labels" -}}
helm.sh/chart: {{ include "semaphore.chart" . }}
{{ include "semaphore.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}


{{/*
Selector labels
*/}}
{{- define "semaphore.selectorLabels" -}}
app.kubernetes.io/name: {{ include "semaphore.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{/*
Database name value
*/}}
{{- define "semaphore.database.name" -}}
{{- default "semaphore_database" .Values.databaseConfig.databaseName }}
{{- end }}


{{/*
Database user name value
*/}}
{{- define "semaphore.database.userName" -}}
{{- default "semaphore_user" .Values.databaseConfig.userName }}
{{- end }}


{{/*
Database user password value
*/}}
{{- define "semaphore.database.userPassword" -}}
{{- $generatedPassword := randAlphaNum 64 }}
{{- default $generatedPassword .Values.databaseConfig.userPassword }}
{{- end }}


{{/*
Database user password value
*/}}
{{- define "semaphore.database.host" -}}
{{- default "localhost" .Values.databaseConfig.host }}
{{- end }}


{{/*
Database user password value
*/}}
{{- define "semaphore.database.port" -}}
{{- default 5432 .Values.databaseConfig.port | int }}
{{- end }}


{{/*
Database volume name
*/}}
{{- define "semaphore.database.volume.name" -}}
{{- if .Values.database.persistentVolumeClaimNameOverride }}
{{ .Values.database.persistentVolumeClaimNameOverride }}
{{- else }}
{{- include "semaphore.name" . }}-database-volume
{{- end }}
{{- end }}


{{/*
Database volume size
*/}}
{{- define "semaphore.database.volume.size" -}}
{{- default "5Gi" .Values.database.volumeSize }}
{{- end }}


{{/*
Semaphore configuration secret resource name
*/}}
{{- define "semaphore.config.secretName" -}}
{{- include "semaphore.name" . }}-configuration
{{- end }}


{{/*
Semaphore database backup cronjob name
*/}}
{{- define "semaphore.backup.name" -}}
{{ $baseName := include "semaphore.name" . }}
{{- printf  "%s-%s" $baseName "backup"}}
{{- end }}


{{/*
Semaphore database backup cronjob schedule
*/}}
{{- define "semaphore.backup.schedule" -}}
{{- default "5 2 * * *" .Values.backup.schedule | quote }}
{{- end }}


{{/*
Semaphore database backup cronjob max allowed time to be alive / time to live / activeDeadlineSeconds
*/}}
{{- define "semaphore.backup.activeDeadlineSeconds" -}}
{{- default 300 .Values.backup.activeDeadlineSeconds | int }}
{{- end }}


{{/*
Semaphore database backup to s3 storage
*/}}
{{- define "semaphore.backup.toS3Storage" -}}
{{- if .Values.backup }}
{{- if .Values.backup.s3 }}
{{- if .Values.backup.s3.accessKeyId }}
{{- if .Values.backup.s3.secretAccessKey }}
{{- if .Values.backup.s3.host }}
{{- if .Values.backup.s3.bucket }}
{{- if .Values.backup.s3.prefix }}
true
{{- end }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}


{{/*
Semaphore database backup to gcs storage
*/}}
{{- define "semaphore.backup.toGcsStorage" -}}
{{- if .Values.backup }}
{{- if .Values.backup.gcs }}
{{- if .Values.backup.gcs.projectId }}
{{- if .Values.backup.gcs.keyJson }}
{{- if .Values.backup.gcs.serviceAccountEmail }}
{{- if .Values.backup.gcs.bucket }}
true
{{- end }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}


{{/*
Semaphore database backup postgresql extra options
*/}}
{{- define "semaphore.backup.postgres.extraOptions" -}}
{{- default "--blobs" .Values.backup.postgresql.extraOptions }}
{{- end }}


{{/*
Semaphore database backup postgresql extra options
*/}}
{{- define "semaphore.backup.filenamePrefix" -}}
{{- default "semaphore-" .Values.backup.filenamePrefix }}
{{- end }}


{{/*
Semaphore database backup postgresql extra options
*/}}
{{- define "semaphore.backup.dateFormat" -}}
{{- default "%Y-%m-%d_%H-%M" .Values.backup.dateFormat }}
{{- end }}


{{/*
Semaphore service name
*/}}
{{- define "semaphore.service.name" -}}
{{ $baseName := include "semaphore.name" . }}
{{- printf "%s-%s" $baseName "service" }}
{{- end }}


