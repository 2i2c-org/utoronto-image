FROM quay.io/2i2c/utoronto-image:c2d316fa18d9
USER root
RUN sed \
    -e 's|^mozilla/emSign_ECC_Root_CA_-_G3.crt|!&|' \
    -e 's|^mozilla/Comodo_AAA_Services_root.crt|!&|' \
    /etc/ca-certificates.conf > /etc/ca-certificates.conf && \
    update-ca-certificates
COPY environment.yml /tmp/
RUN conda install conda-rattler-solver && \
    conda config --set solver rattler && \
    conda install -f /tmp/environment.yml && \
    conda clean -afy
USER ${NB_USER}
