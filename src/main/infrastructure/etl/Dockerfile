# From Logstash.
FROM docker.elastic.co/logstash/logstash:7.9.2

# Sets the user to root.
USER root

# Sets locale and UTF-8 charset.
ENV TZ=America/Sao_Paulo

# Installs Postgres JDBC.
RUN yum install -y postgresql-jdbc && \
	yum clean all -y
	
# Installs necessary plugins.
RUN /usr/share/logstash/bin/logstash-plugin install logstash-output-email && \
	/usr/share/logstash/bin/logstash-plugin install logstash-output-jdbc && \
	/usr/share/logstash/bin/logstash-plugin install logstash-output-elasticsearch && \
	/usr/share/logstash/bin/logstash-plugin install logstash-filter-translate && \
	/usr/share/logstash/bin/logstash-plugin install logstash-filter-json && \
	/usr/share/logstash/bin/logstash-plugin install logstash-filter-json_encode && \
	/usr/share/logstash/bin/logstash-plugin install logstash-filter-mutate
	
# Copies Logstash configuration.
ADD config /usr/share/logstash/config
RUN chown -R logstash:logstash /usr/share/logstash/config/ && \
	mkdir /var/log/logstash/ && \
	chown -R logstash:logstash /var/log/logstash/ && \
	rm /usr/share/logstash/pipeline/*.conf

# Changes the user back to Logstash.
USER logstash

# Configures Java memory.
ENV LS_JAVA_OPTS="-Xms256m -Xmx4g"
