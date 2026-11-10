FROM quay.io/2i2c/utoronto-image:c2d316fa18d9
USER root
RUN sed \
    -e 's|^mozilla/emSign_ECC_Root_CA_-_G3.crt|!&|' \
    -e 's|^mozilla/Comodo_AAA_Services_root.crt|!&|' \
    -i /etc/ca-certificates.conf && \
    update-ca-certificates
COPY environment.yml /tmp/
RUN mamba update mamba && \
    mamba install "python~=3.12.16" \
    "certifi>=2026.10.19" \
    "ca-certificates>=2026.10.19" \
    "pip>=26.2.2" \
    "brotli>=1.2.1" && \
    mamba clean -afy
USER ${NB_USER}
