FROM postgres:10-buster

# Generate an SSL certificate and key file, so that replication can be done over SSL. The postgres
# Docker image doesn't come with SSL set up, so this has to be done manually.
RUN openssl req -new -text -passout pass:abcd -subj /CN=localhost -out server.req
RUN openssl rsa -in privkey.pem -passin pass:abcd -out server.key
RUN openssl req -x509 -in server.req -text -key server.key -out server.crt

# Set permissions on the crt and key files and move them into place.
RUN chown postgres:postgres server.crt server.key
RUN chmod og-rwx server.key
RUN mkdir -p /ssl
RUN mv server.key server.crt /ssl

# Copy the setup.sh script to the container. The postgres Docker image is set up so that any scripts
# in the docker-entrypoint-initdb.d directory will be run after the database is initialized.
RUN mkdir -p /docker-entrypoint-initdb.d
COPY setup.sh /docker-entrypoint-initdb.d/setup.sh
RUN chmod +x /docker-entrypoint-initdb.d/setup.sh
RUN cat /usr/share/postgresql/postgresql.conf.sample > /etc/postgresql/postgresql.conf
RUN chown postgres:postgres /docker-entrypoint-initdb.d/setup.sh
RUN chown postgres:postgres /etc/postgresql/postgresql.conf

# Install the wal2json plugin.
RUN apt-get update -y
RUN apt-get install -y git build-essential postgresql-server-dev-10

RUN git clone https://github.com/eulerto/wal2json.git --branch wal2json_1_0 --single-branch /wal2json
WORKDIR /wal2json
RUN USE_PGXS=1 make && make install


