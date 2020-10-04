# From grafana.
FROM grafana/grafana:7.2.0

# Set to root user for configuration.
USER root

# Sets the timezone.
ENV TZ=America/Sao_Paulo
RUN apk upgrade --update \
    && apk add -U tzdata \
    && cp /usr/share/zoneinfo/${TZ} /etc/localtime \
    && apk del tzdata \
    && rm -rf \
    /var/cache/apk/*

# Installs gettext (envsubst).
RUN apk update && \
	apk add gettext && \
	apk del wget unzip

# Copies the scripts.
RUN mkdir -p /opt/grafana-script
COPY script /opt/grafana-script
RUN chmod -R 755 /opt/grafana-script && \
	ln -s /opt/grafana-script/*.sh /usr/bin && \
	for FILE in /usr/bin/grafana*.sh; \
	do \
		mv -- "${FILE}" "${FILE%.sh}"; \
	done
	
# Allowing embedding.
RUN sed -i "s/;allow_embedding = .*/allow_embedding = true/" /etc/grafana/grafana.ini
	
# Set back to grafana user for execution.
USER grafana

# Installs plugins.
RUN grafana-cli plugins install grafana-piechart-panel && \
	grafana-cli plugins install grafana-googlesheets-datasource
	
# Commands.
ENTRYPOINT [ "grafana_init" ]
CMD [ "/run.sh" ] 

