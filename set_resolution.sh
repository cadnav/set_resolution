#!/usr/bin/env bash

##################################################################################################
# AUTHOR:   Arpan Bhattacherjee <arpanb@nvidia.com>
# VERSION:  1.0
# DESCRIPTION:  `xrandr` shell wrapper for display settings
##################################################################################################

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

######################################### Globals ################################################
readonly __VERSION="v1.0"
readonly __SCRIPT_NAME=$(basename "${0}" .sh)

# Resolutions for xrandr
readonly RES_3440x1440="3440x1440"
readonly RES_3840x2160="3840x2160"
readonly RES_1920x1200="1920x1200"
readonly RES_2560x2880="2560x2880"
readonly RES_1920x1080="1920x1080"

######################################### FUNCTIONS ###############################################

log() { # Args: Message
    echo "[INFO] $@"
}

set_resolution() {
    local resolution=$1
    log "Setting resolution to ${resolution}"
    xrandr -s ${resolution}
    log "Resolution set to ${resolution}"
}

help() {
    cat <<HELP
NAME
    ${__SCRIPT_NAME} - xrandr shell wrapper for custom display resolutions

USAGE
    ${__SCRIPT_NAME} [OPTION]

DESCRIPTION
    Set the display resolution using xrandr.

OPTIONS
    -h, --help            Show this help screen
    -v, --version         Show the current version of the program
    -w, --3440x1440       Set resolution to 3440x1440
    -k, --3840x2160       Set resolution to 3840x2160
    -m, --1920x1200       Set resolution to 1920x1200
    -d, --2560x2880       Set resolution to 2560x2880
    -b, --1920x1080       Set resolution to 1920x1080
HELP
}

version() {
    echo "${__SCRIPT_NAME} ${__VERSION}"
}

######################################### START ###############################################
main() {
    if [[ "$#" -eq 0 ]]; then
        help
        exit 1
    fi

    while [[ "$#" -gt 0 ]]; do
        case "$1" in
            -h|--help)
                help
                exit 0
                ;;
            -v|--version)
                version
                exit 0
                ;;
            -w|--3440x1440)
                set_resolution "${RES_3440x1440}"
                exit 0
                ;;
            -k|--3840x2160)
                set_resolution "${RES_3840x2160}"
                exit 0
                ;;
            -m|--1920x1200)
                set_resolution "${RES_1920x1200}"
                exit 0
                ;;
            -d|--2560x2880)
                set_resolution "${RES_2560x2880}"
                exit 0
                ;;
            -b|--1920x1080)
                set_resolution "${RES_1920x1080}"
                exit 0
                ;;
            *)
                echo "Unknown option: $1"
                help
                exit 1
                ;;
        esac
    done
}

main "$@"

