FROM debian:latest

LABEL maintainer="IThundxr <me@ithundxr.dev>"
LABEL version="1.0.0"
LABEL description="Debian based ssh server for use with remote developent features provided by IDEs like Zed and the Jetbrains suite"

ENV SSH_USERNAME="debian-ssh"
ENV SSH_PASSWORD="debian-ssh"
ENV HOME_FOLDER="/opt/home"
ENV SETUP_SCRIPT_PATH="/opt/setup.sh"

RUN apt-get update && apt-get install -y openssh-server

ADD entrypoint.sh /entrypoint.sh

VOLUME [ $HOME_FOLDER ]
WORKDIR $HOME_FOLDER

EXPOSE 22

ENTRYPOINT [ "bash" ]
CMD [ "/entrypoint.sh" ]
