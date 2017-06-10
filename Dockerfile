FROM ubuntu:16.04

ENV REALM_ROOT_PATH=/var/lib/realm-object-server \
    REALM_LOG_PATH=/var/lib/realm/log

EXPOSE 9080
EXPOSE 9443

# Use custom config
COPY configuration.yml /etc/realm/configuration.yml

# Change default source to aliyun, fuck the WFG[::-1]!
COPY sources.list /etc/apt/sources.list

RUN echo "deb http://ppa.launchpad.net/fkrull/deadsnakes/ubuntu xenial main" >> /etc/apt/sources.list && \
    echo "deb-src http://ppa.launchpad.net/fkrull/deadsnakes/ubuntu xenial main" >> /etc/apt/sources.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FF3997E83CD969B409FB24BC5BB92C09DB82666C &&

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

# Start the service
CMD /usr/bin/realm-object-server -c /etc/realm/configuration.yml 
