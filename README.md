## Certbot with Route53 plugin

### Description

This repo provides certbot with [route53 plugin](https://github.com/certbot/certbot/tree/master/certbot-dns-route53) installed, issues TLS certificates seamlessly.

### How to use it

Make sure you have access to AWS's Route53 service, either through IAM roles or
via `.aws/credentials`.

To run this container with aws credentials on proper mounts:
```
docker run -it --rm \
    -v '/HOME_DIR/.aws:/root/.aws:ro' \
    -v '/HOME_DIR/etc_letsencrypt:/etc/letsencrypt' \
    -v "/HOME_DIR/var_lib_letsencrypt:/var/lib/letsencrypt" \
    mavfav/certsviaroute53:latest
```

Default entrypoint is bash shell, once in run this to generate a certificate:
```
certbot certonly \
  -n --agree-tos \
  --email team.rocket@example.com \
  --dns-route53 \
  -d x.supersecure.example.com
```
