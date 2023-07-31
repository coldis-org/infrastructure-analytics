# From ES.
FROM docker.elastic.co/elasticsearch/elasticsearch:8.8.1

# Sets locale and UTF-8 charset.
ENV TZ=America/Sao_Paulo

# Sets up config files.
COPY config/ config/

# Sets up scripts.
ENV ES_SCRIPT=/opt/elasticsearch-script
RUN mkdir -p ${ES_SCRIPT}
COPY script ${ES_SCRIPT}
RUN chown -R elasticsearch:elasticsearch ${ES_SCRIPT} && \
	ln -s ${ES_SCRIPT}/*.sh /usr/bin && \
	for FILE in /usr/bin/elasticsearch*.sh; \
	do \
		chown elasticsearch:elasticsearch ${FILE} && \	
		mv -- "${FILE}" "${FILE%.sh}"; \
	done

# Configures Java memory.
ENV ES_JAVA_OPTS="-Xms4g -Xmx4g" \
	MEMORY_LOCK=false \
	NODE_NAME=node \
	CLUSTER_NAME=cluster \
	MASTER_NODE=127.0.0.1 \
	NODE_IS_DATA=true \
	NODE_IS_INGEST=true \
	NODE_IS_MASTER=true \
	PASSWORD=secret

# Entrypoint.
ENTRYPOINT [ "elasticsearch_init" ]

