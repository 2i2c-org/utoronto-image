FROM quay.io/2i2c/utoronto-image:c2d316fa18d9
USER root
RUN sed \
    -e 's|^mozilla/emSign_ECC_Root_CA_-_G3.crt|!&|' \
    -e 's|^mozilla/Comodo_AAA_Services_root.crt|!&|' \
    -i /etc/ca-certificates.conf && \
    update-ca-certificates
COPY environment.yml /tmp/
RUN mamba update mamba && \
    mamba install --file /tmp/environment.yml && \
    mamba clean -afy
USER ${NB_USER}
