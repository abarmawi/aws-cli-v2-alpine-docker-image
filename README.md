# Aws cli v2 Image

Docker image contains aws-cli v2 for alpine based.

## How to build

```
$ docker build --build-arg VERSION=$VERSION --build-arg VCS_REF=$VCS_REF --build-arg BUILD_DATE=$BUILD_DATE  -t aws-cli .

# example

$ BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ')
$ docker build --build-arg VERSION=1.0 --build-arg VCS_REF=06566c321bb4c9e1b9547ca6f534a41618eb --build-arg BUILD_DATE=2020-04-27T09:24:41Z  -t aws-cli .
```

## How to use it

```
$ docker run --rm -it -v $PWD:/modules aws-cli:$VERSION terragrunt apply-all

# example

docker run --rm -it -v $PWD:/modules aws-cli:1.0 terragrunt apply-all
```
