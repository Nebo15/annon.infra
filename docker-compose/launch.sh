#!/bin/bash
#-------------------------------------------------------------------------------
# Copyright (c) 2017 Nebo #15 (https://nebo15.com). Licensed under MIT License.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#-------------------------------------------------------------------------------

readonly WORKDIR="$HOME/annon-demo"
readonly DIRNAME=`dirname $0`
readonly PROGNAME=`basename $0`
readonly color_title='\033[32m'
readonly color_text='\033[1;36m'

# OS specific support (must be 'true' or 'false').
declare cygwin=false
declare darwin=false
declare linux=false
declare dc_exec="docker-compose -f docker-compose.yml up"

welcome() {
    echo
    echo -e " ${color_title}           __    _   __    _    ____    __    _  \033[0m"
    echo -e " ${color_title}    /\    |  \  | | |  \  | |  /    \  |  \  | | \033[0m"
    echo -e " ${color_title}   /  \   |   \ | | |   \ | | |  /\  | |   \ | | \033[0m"
    echo -e " ${color_title}  / /\ \  | |\ \| | | |\ \| | | |  | | | |\ \| | \033[0m"
    echo -e " ${color_title} / ____ \ | | \   | | | \   | |  \/  | | | \   | \033[0m"
    echo -e " ${color_title}/_/    \_\|_|  \__| |_|  \__|  \____/  |_|  \__| \033[0m"
    echo -e " ${color_title}    | |                                          \033[0m${color_text}http://nebo15.com\033[0m"
    echo -e " ${color_title}  __| | ___ _ __ ___   ___                                               \033[0m"
    echo -e " ${color_title} / _\`|/ _ \ '_ \ _ \ / _ \                                              \033[0m"
    echo -e " ${color_title}| (_| |  __/ | | | | | (_) |                                             \033[0m"
    echo -e " ${color_title} \__,_|\___|_| |_| |_|\___/                                              \033[0m"
    echo
}

check_deps() {
  command -v docker >/dev/null 2>&1 || {
    echo "Docker CLI is required but it's not installed. Installation guide: https://docs.docker.com/engine/installation" >&2;
    echo "Aborting." >&2;
    exit 1;
  }
  command -v docker-compose >/dev/null 2>&1 || {
    echo "Docker Compose is required but it's not installed. Installation guide: https://docs.docker.com/compose/install/" >&2;
    echo "Aborting." >&2;
    exit 1;
  }
}

init_env() {
    local dockergrp
    # define env
    case "`uname`" in
        CYGWIN*)
            cygwin=true
            ;;

        Darwin*)
            darwin=true
            ;;

        Linux)
            linux=true
            ;;
    esac

    # test if docker must be run with sudo
    dockergrp=$(groups | grep -c docker)
    if [[ $darwin == false && $dockergrp == 0 ]]; then
        dc_exec="sudo $dc_exec";
    fi
}

init_dirs() {
    echo "Init log directory in $WORKDIR ..."
    mkdir -p "$WORKDIR/logs/"
    echo
}

main() {
    welcome

    init_env
    if [[ $? != 0 ]]; then
        exit 1
    fi

    check_deps
    if [[ $? != 0 ]]; then
        exit 1
    fi

    set -e
    init_dirs
    pushd $WORKDIR > /dev/null
        echo "Download docker compose files ..."
        curl -L https://raw.githubusercontent.com/nebo15/annon.infra/master/docker-compose/docker-compose.yml -o "docker-compose.yml"
        echo
        echo "Launch Annon demo ..."
        $dc_exec
    popd > /dev/null
}

main
