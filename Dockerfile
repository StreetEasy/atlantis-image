
ARG ENVKEY_VERSION
FROM zillownyc/envkey:${ENVKEY_VERSION} as envkey

ARG TERRAGRUNT_VERSION
FROM zillownyc/terragrunt:${ENVKEY_VERSION} as terragrunt

FROM runatlantis/atlantis-base:v3.2

ARG ATLANTIS_VERSION
ARG AWS_CLI_VERSION
ARG SCENERY_VERSION

RUN curl -Lso atlantis.zip https://github.com/runatlantis/atlantis/releases/download/${ATLANTIS_VERSION}/atlantis_linux_amd64.zip \
    && unzip atlantis.zip \
    && rm atlantis.zip \
    && mv atlantis /usr/local/bin/atlantis

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

COPY --from=envkey /usr/local/bin/envkey-source /usr/local/bin/envkey-source
COPY --from=terragrunt /usr/local/bin/terragrunt /usr/local/bin/terragrunt
COPY --from=terragrunt /bin/terraform /bin/terraform

RUN apk add py-pip groff \
    && pip install awscli==${AWS_CLI_VERSION}

ADD https://github.com/dmlittle/scenery/releases/download/${SCENERY_VERSION}/scenery-${SCENERY_VERSION}-linux-amd64 /usr/local/bin/scenery

RUN chmod +x /usr/local/bin/scenery

COPY startup.sh /
COPY repos.yaml /home/atlantis/

ENTRYPOINT ["/startup.sh"]
CMD ["server"]
