# Annon Infrastructure

Infrastructure helpers for [Annon API Gateway](http://docs.annon.apiary.io/):

1. Sample [Docker Compose files](/docker-compose) and one-click-install bash script.

  `curl -L http://bit.ly/annon_compose | bash`

2. [Kubernetes config](/kubernetes) examples.

## Environment Variables

This environment variables can be used to configure released docker container at start time.
Also sample `.env` can be used as payload for `docker run` cli.

### General

| VAR_NAME      | Default Value           | Description |
| ------------- | ----------------------- | ----------- |
| `LOG_LEVEL`   | `info` | Elixir Logger severity level. Possible values: `debug`, `info`, `warn`, `error`. |
| `PROTECTED_HEADERS` | `x-consumer-id,x-consumer-scope,x-consumer-token,x-consumer-token-id` | Comma-separated list of headers which are ignored when received from API consumers. |

### Clustering

| VAR_NAME          | Default Value           | Description |
| ----------------- | ----------------------- | ----------- |
| `ERLANG_COOKIE`   | `03/yHifHIEl`..         | Erlang [distribution cookie](http://erlang.org/doc/reference_manual/ |
| `LISTEN_DIST_MIN` | `10000`                 | Start of Erlang's port range to connect between nodes. |
| `LISTEN_DIST_MAX` | `10100`                 | End of Erlang's port range to connect between nodes. |
| `POD_IP`          | `127.0.0.1`             | Node IP address. (Should be correct for clustering to work.) |
| `SKYCLUSTER_STRATEGY`                 | `Cluster.Strategy.Epmd`   | Which strategy to use? |
| `SKYCLUSTER_KUBERNETES_SELECTOR`      | `app=annon,component=api` | How to select gateway pods in kubernetes |
| `SKYCLUSTER_KUBERNETES_NODE_BASENAME` | `gateway`                 | Name of a Annon's deployment |

### HTTP Endpoints

| VAR_NAME                  | Default Value | Description |
| ------------------------- | ------------- | ----------- |
| `GATEWAY_PUBLIC_PORT`     | `4000`        | This is a public port that will may be available to the Internet. |
| `GATEWAY_PRIVATE_PORT`    | `4002`        | This is a port used for management API, must be protected by a firewall. |
| `GATEWAY_MANAGEMENT_PORT` | `4001`        | This is a port that can be used by cluster services to communicate with each-other, must be protected by a firewall. |

### Database

You can set individual DB connection options that will apply for both configurations and requests connections:

| VAR_NAME      | Default Value | Description |
| ------------- | ------------- | ----------- |
| `DB_NAME`     | `annon`       | Database name. |
| `DB_USER`     | `postgres`    | Database user. |
| `DB_PASSWORD` | `postgres`    | Database password. |
| `DB_HOST`     | `travis`      | Database host. |
| `DB_PORT`     | `5432`        | Database port. |
| `DB_MIGRATE`  | `true`        | Migrate database when container starts. |

Our you can set separately via DB connection URLs:

| VAR_NAME                     | Default Value | Description |
| ---------------------------- | ------------- | ----------- |
| `CONFIGURATION_DATABASE_URL` | not set       | URL with configurations DB connection settings, example: `postgres://postgres:postgres@travis:5432/annon`. |
| `REQUESTS_DATABASE_URL`      | not set       | URL with requests DB connection settings, example: `postgres://postgres:postgres@travis:5432/annon`. |

### Monitoring

# StatsD
| VAR_NAME      | Default Value | Description |
| ------------- | ------------- | ----------- |
| `STATSD_HOST` | `travis`      | DogStatsD server hostname. |
