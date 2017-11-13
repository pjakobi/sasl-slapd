# Use osixia/light-baseimage
# sources: https://github.com/osixia/docker-light-baseimage
FROM osixia/openldap:latest
MAINTAINER Pascal Jakobi <pascal.jakobi@gmail.com>


RUN apt-get -y update \
	  && LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
       krb5-user \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


