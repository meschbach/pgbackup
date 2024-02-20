FROM meschbach/postgres-with-aws:16.2
RUN mkdir -p opt
COPY bin /opt/bin
