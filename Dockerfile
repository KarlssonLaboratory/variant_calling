FROM rocker/r-ver:4.4.0

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  git \
  less \
  procps \
  && rm -rf /var/lib/apt/lists/*

# Install R-packages
COPY install.R /tmp/install.R
RUN Rscript /tmp/install.R

WORKDIR /data
CMD ["/bin/bash"]