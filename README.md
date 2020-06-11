# opendistro-elasticsearch
OpenDistro Elasticsearch Self Hosted Solution

# Deployment
- [Create node SSL certificates](certs/README.md)
- Increase docker memory to 6GB
    - ![docker_settings](docker_settings.png)

- Execute: `docker-compose --compatibility up`

# Tips
If you want to use the same cert for all nodes set: `opendistro_security.ssl.transport.resolve_hostname: false`
- Use-case maybe IT organization is cumbersome to get certs expeditiously