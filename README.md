# atlantis-image

```
docker build \
  --build-arg ATLANTIS_VERSION=v0.10.1 \
  --build-arg SCENERY_VERSION=v0.1.5 \
  --build-arg TERRAGRUNT_VERSION=0.28.18 \
  --build-arg AWS_CLI_VERSION=1.18.54 \
  --build-arg ENVKEY_VERSION=latest \
  -t zillownyc/atlantis:0.10.1 \
  -t zillownyc/atlantis:0.10 \
  -t zillownyc/atlantis:latest .
```


