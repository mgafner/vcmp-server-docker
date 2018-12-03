#!/bin/bash
#
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

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

docker run \
	-it \
	--hostname vcmp-server-docker \
	-v $SCRIPTPATH/server_log.txt:/home/vcmp/server_log.txt:rw \
	-v $SCRIPTPATH/server.cfg:/home/vcmp/server.cfg:ro \
	-v $SCRIPTPATH/server.conf:/home/vcmp/server.conf:ro \
	-v $SCRIPTPATH/scripts:/home/vcmp/scripts:ro \
	-p 8192:8192/udp \
	vcmp-server

