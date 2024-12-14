######## INSTALL ########

# Set the base image
FROM debian:12-slim

# Create a new user 'steam'
RUN useradd -m steam

# Set environment variables for the new user
ENV USER steam
ENV HOME /home/steam

# Set working directory
WORKDIR $HOME

# Insert Steam prompt answers
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN echo steam steam/question select "I AGREE" | debconf-set-selections \
 && echo steam steam/license note '' | debconf-set-selections

# Update the repository and install SteamCMD
ARG DEBIAN_FRONTEND=noninteractive
COPY config/sources.list /etc/apt/sources.list
RUN dpkg --add-architecture i386 \
 && apt-get update -y \
 && apt-get upgrade -y \
 && apt-get install -y vim \
 && apt-get install -y --no-install-recommends ca-certificates locales steamcmd \
 && rm -rf /var/lib/apt/lists/*

# Add unicode support
RUN sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen \
 && locale-gen en_US.UTF-8
ENV LANG 'en_US.UTF-8'
ENV LANGUAGE 'en_US:en'

# Create symlink for executable
RUN ln -s /usr/games/steamcmd /usr/bin/steamcmd

# Update SteamCMD and verify latest version
RUN steamcmd +quit

# Fix missing directories and libraries
RUN mkdir -p $HOME/.steam \
 && ln -s $HOME/.local/share/Steam/steamcmd/linux32 $HOME/.steam/sdk32 \
 && ln -s $HOME/.local/share/Steam/steamcmd/linux64 $HOME/.steam/sdk64 \
 && ln -s $HOME/.steam/sdk32/steamclient.so $HOME/.steam/sdk32/steamservice.so \
 && ln -s $HOME/.steam/sdk64/steamclient.so $HOME/.steam/sdk64/steamservice.so

######## PALWORLD ########

# Install PalWorld
RUN steamcmd +force_install_dir /home/steam +login anonymous +app_update 2394010 validate +quit

COPY config/PalWorldSettings.ini $HOME/PalWorldSettings.ini

RUN chown -R $USER:$USER $HOME

USER $USER

WORKDIR /home/steam/

EXPOSE 8211/udp

ENTRYPOINT ["sh", "PalServer.sh"]
CMD ["-players=4", "-publiclobby", "-logformat=text"]