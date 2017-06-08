FROM ubuntu:16.04

EXPOSE 9080

RUN apt-get update && \
	apt-get -y install curl && \
	# Setup Realm's PackageCloud repository
	curl -s https://packagecloud.io/install/repositories/realm/realm/script.deb.sh | bash && \
    # Install the Realm Object Server
    apt-get install -y realm-object-server-developer && \
    # Enable the service
    systemctl enable realm-object-server &&\
    apt-get purge -y --auto-remove $buildDeps

VOLUME /var/lib/realm/object-server

# Start the service
CMD /usr/bin/realm-object-server -c /etc/realm/configuration.yml 
