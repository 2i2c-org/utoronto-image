FROM quay.io/jupyter/scipy-notebook:2025-07-28

# Install desktop packages
# Also installs 'zip' needed by jupyter-tree-download
USER root
COPY apt.txt /tmp/apt.txt
RUN apt-get update --yes -qq > /dev/null && \
    # Ignore comments in packages
    grep '^\s*[^#]\+' /tmp/apt.txt | xargs apt-get install --yes -qq
USER ${NB_USER}

COPY environment.yml /tmp/
RUN mamba env update -p ${CONDA_DIR} -f /tmp/environment.yml && \
    mamba clean -afy

# For https://2i2c.freshdesk.com/a/tickets/187
# If we don't set `NLTK_DATA`, the data gets downloaded onto $HOME, which
# isn't available when the image is loaded onto JupyterHub.
# So we download alongside our packages.
# Note that textblob.download_corpora just calls nltk to download corpora
ENV NLTK_DATA=${CONDA_DIR}/nltk_data
RUN mkdir -p ${NLTK_DATA} && python -m textblob.download_corpora

USER root
ENV PLAYWRIGHT_BROWSERS_PATH=/playwright/
RUN playwright install chromium
USER ${NB_USER}

COPY ./etc/jupyter /etc/jupyter

RUN jupyter nbclassic-extension install --sys-prefix --py jupyter_nbextensions_configurator --overwrite && \
    jupyter nbclassic-extension enable --sys-prefix --py jupyter_nbextensions_configurator && \
    jupyter nbclassic-serverextension enable --sys-prefix --py jupyter_nbextensions_configurator
