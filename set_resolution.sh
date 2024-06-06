#!/usr/bin/env bash

##################################################################################################
# AUTHOR:   Arpan Bhattacherjee <arpanb@nvidia.com>
# VERSION:  1.0
# DESCRIPTION:  `xrandr` shell wrapper  for display settings
##################################################################################################

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

######################################### Globals ################################################
readonly __DESC="A template to be used for quick creation of bash scripts."
readonly __VERSION="v1.0"
readonly __SCRIPT_NAME=$(basename "${0}" .sh)
readonly __LOCAL_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

readonly __NC='\e[0m'
readonly __GRAY='\e[0;90m'
readonly __RED='\e[0;91m'
readonly __GREEN='\e[0;92m'
readonly __YELLOW='\e[0;93m'
readonly __BLUE='\e[0;94m'
readonly __PASS='\u2714' # ✔
readonly __FAIL='\u274c' # ✖
# readonly WARN='\u26A0' # ⚠
# readonly INFO='\u2757' # ℹ

__VERBOSITY=3
readonly __LOG_LEVELS=(
    [0]="[${__GREEN}${__PASS} ${__NC}]"
    [1]="[${__RED}${__FAIL} ${__NC}]"
    [2]="[${__YELLOW}WARN${__NC}]"
    [3]="[${__BLUE}INFO${__NC}]"
    [4]="[${__GRAY}DEBUG${__NC}]"
)

# Resolutions for xrandr
readonly RES_3440x1440="3440x1440"
readonly RES_3480x2160="3480x2160"
readonly RES_1920x1200="1920x1200"
readonly RES_2560x2880="2560x2880"
readonly RES_1920x1080="1920x1080"

######################################### FUNCTIONS ###############################################

banner() { # Args: Title
    echo "# ========================================================"
    echo "# "
    echo "# $@ "
    echo "# "
    echo "# ========================================================"
}

log() { # Args: log_level[0-4], Message
    local _level=${1}
    shift
    if [[ "${__VERBOSITY}" -ge "${_level}" ]]; then
        echo -e "${__LOG_LEVELS[${_level}]} $@"
    fi
}

# https://gist.github.com/davejamesmiller/1965569
ask() { # Args: Message, [OPTIONAL] default answer
    local _prompt _default _reply _message=${1}

    if [ "${2:-}" = "Y" ]; then
        _prompt="Y/n"
        _default=Y
    elif [ "${2:-}" = "N" ]; then
        _prompt="y/N"
        _default=N
    else
        _prompt="y/n"
        _default=
    fi

    while true; do
        # Ask the question (not using "read -p" as it uses stderr not stdout)
        echo -n "${_message} [${_prompt}] "
        # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
        read _reply </dev/tty

        if [ -z "${_reply}" ]; then
            _reply="${_default}"
        fi

        case "${_reply}" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac
    done
}

menu() {
    while true; do
        cat<<MENU
==============================
        Program Menu
------------------------------
  Please enter your choice:

  1) Set resolution to 3440x1440
  2) Set resolution to 3480x2160
  3) Set resolution to 1920x1200
  4) Set resolution to 2560x2880
  5) Set resolution to 1920x1080
  Q) Quit
------------------------------
MENU
        local _reply
        read -n1 -s _reply
        case "${_reply}" in
            "1")  set_resolution $RES_3440x1440 ;;
            "2")  set_resolution $RES_3480x2160 ;;
            "3")  set_resolution $RES_1920x1200 ;;
            "4")  set_resolution $RES_2560x2880 ;;
            "5")  set_resolution $RES_1920x1080 ;;
            "Q"|"q")  exit 0  ;;
            * )  echo "Invalid option..." ;;
        esac
    done
}

help() {
    local _desc="Show this help screen"
    cat <<HELP
NAME
    ${__SCRIPT_NAME} - `xrandr` shell wrapper for custom display resolutions

USAGE
    xr --verbose 4

DESCRIPTION
    ${__DESC}

    -h, --help
            ${_desc}

    -V, --verbose
            Specify the verbosity of the script. [0-4]
                0 - success
                1 - error
                2 - warn
                3 - info
                4 - debug

    -v, --version
            Shows the current version of the program

    -w, --3440x1440 | wide
    -f, --3480x2160 | 4k
    -m, --1920x1200 | mbp
    -d, --2560x2880 | dualup
    -r, --1920x1080 | baseline

HELP
}

usage() {
    local _desc="Displays an inline message invalid args are given"
    echo "Try '${__SCRIPT_NAME} -h' for more information."
}

version() {
    local _desc="Shows the current version of the program"
    echo "${__SCRIPT_NAME} ${__VERSION}"
}

set_resolution() {
    local resolution=$1
    log 3 "Setting resolution to ${resolution}"
    xrandr --output $(xrandr | grep " connected" | cut -f1 -d " ") --mode $resolution
    log 0 "Resolution set to ${resolution}"
}

######################################### START ###############################################
main () {
    for __ARG in "${@}"; do
        shift
        case "${__ARG}" in
            "--help") set -- "${@}" "-h" ;;
            "--verbose") set -- "${@}" "-V" ;;
            "--version") set -- "${@}" "-v" ;;
            "--3440x1440") set -- "${@}" "-w" ;;
            "--3480x2160") set -- "${@}" "-f" ;;
            "--1920x1200") set -- "${@}" "-m" ;;
            "--2560x2880") set -- "${@}" "-d" ;;
            "--1920x1080") set -- "${@}" "-r" ;;
            *) set -- "$@" "${__ARG}"
        esac
    done

    if [[ "$#" = "0" ]]; then
        menu
    else
        while getopts "hV:vwfmrd-:" __OPTION; do
            case ${__OPTION} in
                h)
                    help
                    exit 0
                    ;;
                V)
                    __VERBOSITY="${OPTARG}"
                    ;;
                v)
                    version
                    exit 0
                    ;;
                w)
                    set_resolution $RES_3440x1440
                    exit 0
                    ;;
                f)
                    set_resolution $RES_3480x2160
                    exit 0
                    ;;
                m)
                    set_resolution $RES_1920x1200
                    exit 0
                    ;;
                d)
                    set_resolution $RES_2560x2880
                    exit 0
                    ;;
                r)
                    set_resolution $RES_1920x1080
                    exit 0
                    ;;
                *)
                    usage
                    exit 0
                    ;;
            esac
        done
        readonly __VERBOSITY
    fi

    # Example of how to log output
    log 0 "Success"
    log 1 "Error"
    log 2 "Warn"
    log 3 "Info"
    log 4 "Debug"

    # Ask() Examples
    if ask "Do you want to do such-and-such?"; then
        echo "Yes"
    else
        echo "No"
    fi

    # Default to Yes if the user presses enter without giving an answer:
    if ask "Do you want to do such-and-such?" Y; then
        echo "Yes"
    else
        echo "No"
    fi

    # Default to No if the user presses enter without giving an answer:
    if ask "Do you want to do such-and-such?" N; then
        echo "Yes"
    else
        echo "No"
    fi

    # Only do something if you say Yes
    if ask "Do you want to do such-and-such?"; then
        echo "yes"
    fi

    # Only do something if you say No
    if ! ask "Do you want to do such-and-such?"; then
        echo "no"
    fi

    # Or if you prefer the shorter version:
    ask "Do you want to do such-and-such?" && echo "yes"

    ask "Do you want to do such-and-such?" || echo "no"
}

cleanup() {
    local _result=$?
    # Your cleanup code

    echo # Print a Newline
    log 4 "Cleaning up..."
    log 4 "Exited with code ${_result}"

    exit "${_result}"
}
trap cleanup EXIT ERR

main "${@}"
