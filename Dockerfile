FROM quay.io/jupyter/scipy-notebook:2023-12-08

USER root

# Install desktop packages
# Also installs 'zip' needed by jupyter-tree-download
RUN apt-get update -qq --yes > /dev/null && \
    apt-get install --yes -qq \
        zip \
        dbus-x11 \
        firefox \
        xfce4 \
        xfce4-panel \
        xfce4-terminal \
        xfce4-session \
        xfce4-settings \
        xorg \
        xubuntu-icon-theme \
        openjdk-8-jre \
        libreoffice > /dev/null

USER ${NB_USER}

COPY environment.yml /tmp/

RUN mamba env update -p ${CONDA_DIR} -f /tmp/environment.yml && mamba clean -afy

# For https://2i2c.freshdesk.com/a/tickets/187
# If we don't set `NLTK_DATA`, the data gets downloaded onto $HOME, which
# isn't available when the image is loaded onto JupyterHub.
# So we download alongside our packages.
# Note that textblob.download_corpora just calls nltk to download corpora
ENV NLTK_DATA=${CONDA_DIR}/nltk_data
RUN mkdir -p ${NLTK_DATA} && python -m textblob.download_corpora

RUN jupyter nbclassic-extension install --sys-prefix --py jupyter_nbextensions_configurator --overwrite && \
    jupyter nbclassic-extension enable --sys-prefix --py jupyter_nbextensions_configurator && \
    jupyter nbclassic-serverextension enable --sys-prefix --py jupyter_nbextensions_configurator