{{/*
Expand the name of the chart.
*/}}
{{- define "semaphore.name" -}}
{{- default .Chart.Name .Values.chartNameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "semaphore.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}


{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "semaphore.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
Allow the release namespace to be overridden for multi-namespace deployments in combined charts.
*/}}
{{- define "semaphore.namespace" -}}
  {{- if .Values.namespaceOverride -}}
    {{- .Values.namespaceOverride -}}
  {{- else -}}
    {{- .Release.Namespace -}}
  {{- end -}}
{{- end -}}


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
{{- default "semaphore_database" .Values.database.config.databaseName }}
{{- end }}


{{/*
Database user name value
*/}}
{{- define "semaphore.database.userName" -}}
{{- default "semaphore_user" .Values.database.config.userName }}
{{- end }}


{{/*
Database user password value
*/}}
{{- define "semaphore.database.userPassword" -}}
{{- $generatedPassword := randAlphaNum 64 }}
{{- default $generatedPassword .Values.database.config.userPassword }}
{{- end }}


{{/*
Database host value
*/}}
{{- define "semaphore.database.host" -}}
{{- default "localhost" .Values.database.config.host }}
{{- end }}


{{/*
Database port value
*/}}
{{- define "semaphore.database.port" -}}
{{- default 5432 .Values.database.config.port | int }}
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
Semaphore database backup to gcp storage
*/}}
{{- define "semaphore.backup.toGcsStorage" -}}
{{- if .Values.backup }}
{{- if .Values.backup.gcp }}
{{- if .Values.backup.gcp.projectId }}
{{- if .Values.backup.gcp.keyJson }}
{{- if .Values.backup.gcp.serviceAccountEmail }}
{{- if .Values.backup.gcp.bucket }}
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
