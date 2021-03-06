FROM alpine:3.7
MAINTAINER Paul Hammant <paul@hammant.org>

# Install and configure Apache WebDAV and Subversion
RUN apk --no-cache add apache2 apache2-utils apache2-webdav mod_dav_svn subversion
ADD vh-davsvn.conf /etc/apache2/conf.d/
ADD authz.authz /etc/apache2/conf.d/

# Setup a "two commits" starting point
COPY dataset dataset
COPY secondCommit secondCommit
RUN mkdir -p /run/apache2

ADD run.sh /
RUN chmod +x /run.sh
EXPOSE 80

# Define default command
CMD ["/run.sh"]
