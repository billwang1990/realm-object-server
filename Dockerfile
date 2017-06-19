FROM ubuntu:16.04

ENV REALM_ROOT_PATH=/var/lib/realm/object-server \
    REALM_LOG_PATH=/var/log/realm \

RUN mkdir ${REALM_LOG_PATH}

EXPOSE 9080 9443

RUN apt-get update && \
	apt-get -y install curl && \
	# Setup Realm's PackageCloud repository
	curl -s https://packagecloud.io/install/repositories/realm/realm/script.deb.sh | bash && \
    # Install the Realm Object Server
    apt-get install -y realm-object-server-developer && \
    # Enable the service
    systemctl enable realm-object-server &&\
    apt-get purge -y --auto-remove $buildDeps

VOLUME ["${REALM_ROOT_PATH}", "${REALM_LOG_PATH}"]

COPY configuration.yml /etc/realm/configuration.yml

# Start the service
CMD /usr/bin/realm-object-server -c /etc/realm/configuration.yml 
