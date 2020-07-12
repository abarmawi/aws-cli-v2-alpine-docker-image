# FROM aws_alpine_image:latest as aws
FROM alpine

# image version
ARG VERSION
# git commit ref
ARG VCS_REF
# image build timestamp
ARG BUILD_DATE

LABEL maintainer="Abdallah Albarmawi <abarmawi@live.com>"
LABEL org.label-schema.name="aws-cli v2 image"
LABEL org.label-schema.description="This image contains aws-cli v2 sdk"
LABEL org.label-schema.usage="https://github.com/abarmawi/aws-cli-v2-alpine-docker-image/blob/master/README.md"
LABEL org.label-schema.url="https://github.com/abarmawi/aws-cli-v2-alpine-docker-image"
LABEL org.label-schema.vcs-ref=$VCS_REF
LABEL org.label-schema.schema-version=$VERSION
LABEL org.label-schema.build-date=$BUILD_DATE

ENV GLIBC_VER=2.31-r0

# install glibc compatibility for alpine
RUN apk --no-cache add \
        git \
        binutils \
        curl \
    && curl -sL https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-${GLIBC_VER}.apk \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-bin-${GLIBC_VER}.apk \
    && apk add --no-cache \
        glibc-${GLIBC_VER}.apk \
        glibc-bin-${GLIBC_VER}.apk \
    && curl -sL https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip \
    && unzip awscliv2.zip \
    && aws/install \
    && rm -rf \
        awscliv2.zip \
        aws \
        /usr/local/aws-cli/v2/*/dist/aws_completer \
        /usr/local/aws-cli/v2/*/dist/awscli/data/ac.index \
        /usr/local/aws-cli/v2/*/dist/awscli/examples \
    && apk --no-cache del \
        binutils \
        curl \
    && rm glibc-${GLIBC_VER}.apk \
    && rm glibc-bin-${GLIBC_VER}.apk \
    && rm -rf /var/cache/apk/*

ENTRYPOINT []
CMD []