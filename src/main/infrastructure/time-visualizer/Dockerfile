# From Kibana.
FROM docker.elastic.co/kibana/kibana:8.8.1

# sets the user to root.
USER root

# Sets locale and UTF-8 charset.
ENV TZ=America/Sao_Paulo

# Sets up config files and scripts.
COPY config/ config/
COPY script/ bin/
RUN chown -R kibana:kibana bin/ config/ && \
	chmod -R +x bin/*
	
# Sets the user back to Kibana.
USER kibana

# Installs the plugins.
#RUN /usr/share/kibana/bin/kibana-plugin install https://github.com/fbaligand/kibana-enhanced-table/releases/download/v1.8.0/enhanced-table-1.8.0_7.6.2.zip 
#	/usr/share/kibana/bin/kibana-plugin install https://github.com/rvcoutinho/ob-kb-funnel/raw/7.6.1/build/ob-kb-funnel-7.6.1.zip
	
# Configures Java memory.
ENV KB_JAVA_OPTS="-Xms128m -Xmx4g" \
	ELASTICSEARCH_HOSTS=http://127.0.0.1 \
	SERVER_NAME=kibana

