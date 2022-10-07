# Postgresql

For demo instance, run a standalone version of postgresql via helm chart.

BEWARE when upgrading the repo with regards to password and pvc.
Read the docs!

See for example:

- <https://github.com/bitnami/charts/issues/2061>
- <https://docs.bitnami.com/kubernetes/infrastructure/postgresql/administration/upgrade/>

## Initialization of the database and users

Init scripts can be provided via the `initDbScripts` variable.
