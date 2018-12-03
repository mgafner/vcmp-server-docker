# This file is part of vcmp-server-docker
# https://github.com/mgafner/vcmp-server-docker
#
# This is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this file.  If not, see <http://www.gnu.org/licenses/>.

FROM debian
MAINTAINER Martin Gafner <gafner@puzzle.ch>

RUN apt-get update
RUN apt-get install -y nmap sudo

ENV USER vcmp
ENV UID 1000
ENV GID 1000
ENV HOME /home/$USER
ENV HOSTNAME vcmp-server-docker

RUN mkdir -p $HOME
RUN echo "$USER:x:$UID:$GID:$USER,,,:$HOME:/bin/bash" >> /etc/passwd
RUN echo "$USER:x:$UID:" >> /etc/group
RUN echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER
RUN chmod 0440 /etc/sudoers.d/$USER

COPY mpsvrrel64 $HOME
RUN chmod u+x $HOME/mpsvrrel64
COPY server.* $HOME/

RUN chown $UID:$GID -R $HOME

RUN mkdir plugins
COPY plugins/* $HOME/plugins/

RUN mkdir scripts
COPY scripts/* $HOME/scripts/

COPY docker-scripts/start.sh $HOME
RUN chmod u+x $HOME/start.sh

HEALTHCHECK CMD nmap -sU -p 8192 localhost | grep open || exit 1

#USER $USER
WORKDIR $HOME

ENTRYPOINT ["/home/vcmp/start.sh"]

EXPOSE 8192
