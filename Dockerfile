FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y ca-certificates jq

RUN echo "deb [trusted=yes] https://packages.cloudfoundry.org/debian stable main" > /etc/apt/sources.list.d/cloudfoundry-cli.list
RUN apt-get update
RUN apt-get install -y git wget build-essential

RUN mkdir cf

RUN apt-get install -y cf7-cli || ( wget -nv https://github.com/timotto/cf-cli-arm/releases/download/v6.51.0/cf-arm7 && chmod +x cf-arm7 && mv cf-arm7 /cf/cf7 && ln -s /cf/cf7 /cf/cf )
ENV PATH="$PATH:/cf"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]