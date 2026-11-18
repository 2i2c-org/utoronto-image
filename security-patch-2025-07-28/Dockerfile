FROM quay.io/2i2c/utoronto-image:c2d316fa18d9
USER root
RUN sed \
    -e 's|^mozilla/emSign_ECC_Root_CA_-_G3.crt|!&|' \
    -e 's|^mozilla/Comodo_AAA_Services_root.crt|!&|' \
    -i /etc/ca-certificates.conf && \
    update-ca-certificates
RUN fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
USER ${NB_USER}
COPY environment.yml /tmp/
RUN mamba update mamba && \ 
    # Notebook 7 was clobbered by 6 via pip. Let's remove it, and
    # then remove the package metadata from conda-forge so that we can re-install.
    pip uninstall -y notebook && \
    rm ${CONDA_DIR}/conda-meta/notebook-*.json && \
    mamba install --file /tmp/environment.yml && \
    mamba clean -afy
