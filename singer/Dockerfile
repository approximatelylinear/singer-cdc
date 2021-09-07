FROM python:3.8

RUN apt-get update -y && apt-get install -y \
    python3-dev \
    wait-for-it \
    postgresql \
    jq

# Note: tap-postgres uses an old version of psycopg
RUN pip install pipelinewise-tap-postgres

COPY run.sh run.sh
RUN chmod +x run.sh
