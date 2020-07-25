# Update the VARIANT arg in devcontainer.json to pick an Go version
ARG VARIANT=1
FROM golang:${VARIANT}

# This Dockerfile adds a non-root user with sudo access. Update the “remoteUser” property in
# devcontainer.json to use it. More info: https://aka.ms/vscode-remote/containers/non-root-user.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Options for common setup script
ARG INSTALL_ZSH="true"
ARG UPGRADE_PACKAGES="false"

# Copy setup scripts
COPY ./library-scripts/ ./install-go-tools.sh /tmp/

# Install needed packages and setup non-root user. Use a separate RUN statement to add your own dependencies.
RUN apt-get update \
    && bash /tmp/common-debian.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* /tmp/common-debian.sh

# Install Go tools and clean up
RUN bash /tmp/install-go-tools.sh \
    && rm -f /tmp/install-go-tools.sh

# Update this to "on" or "off" as appropriate
ENV GO111MODULE=auto

# [Optional] Uncomment the next line to use go get to install anything else you need
# RUN go get -v <your-dependency-or-tool-list>

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update \
#     && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>

