FROM quay.io/2i2c/utoronto-image:c2d316fa18d9
USER root
RUN sed \
    -e 's|^mozilla/emSign_ECC_Root_CA_-_G3.crt|!&|' \
    -e 's|^mozilla/Comodo_AAA_Services_root.crt|!&|' \
    /etc/ca-certificates.conf > /tmp/ca-certificates.conf
COPY environment.yml /tmp/
RUN mamba install -f /tmp/environment.yml && \
    mamba clean -afy
USER ${NB_USER}
