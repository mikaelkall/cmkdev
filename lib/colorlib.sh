#!/bin/bash

COLORDEFAULT="\e[29m"
BLACK="\e[30m"
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
LIGHTGRAY="\e[37m"
DARKGRAY="\e[90m"
LIGHTRED="\e[91m"
LIGHTGREEN="\e[92m"
LIGHTYELLOW="\e[93m"
LIGHTBLUE="\e[94m"
LIGHTMAGENTA="\e[95m"
LIGHTCYAN="\e[96m"
LIGHTWHITE="\e[97m"

# Special codes
BOLD=$(tput bold)
UNDERLINE=$(tput sgr 0 1)
RESET=$(tput sgr0)

function color.default()
{
    echo -e "\e[29m$@"
}

function color.black()
{
    echo -e "\e[30m$@"
}

function color.red()
{
    echo -e "\e[31m$@"
}

function color.green()
{
    echo -e "\e[32m$@"
}

function color.yellow()
{
    echo -e "\e[33m$@"
}

function color.blue()
{
    echo -e "\e[34m$@"
}

function color.magenda()
{
    echo -e "\e[35m$@"
}

function color.cyan()
{
    echo -e "\e[36m$@"
}

function color.lightgray()
{
    echo -e "\e[37m$@"
}

function color.darkgray()
{
    echo -e "\e[90m$@"
}

function color.lightred()
{
    echo -e "\e[91m$@"
}

function color.lightgreen()
{
    echo -e "\e[92m$@"
}

function color.lightyellow()
{
    echo -e "\e[93m$@"
}

function color.lightblue()
{
    echo -e "\e[94m$@"
}

function color.lightmagenta()
{
    echo -e "\e[95m$@"
}

function color.lightcyan()
{
    echo -e "\e[96m$@"
}

function color.lightwhite()
{
    echo -e "\e[97m$@"
}


function print_usage()
{
    color.green "${BOLD}
                __       __   
.----.--------.|  |--.--|  |.-----.--.--.
|  __|        ||    <|  _  ||  -__|  |  |
|____|__|__|__||__|__|_____||_____|\___/ ${RESET}" 
 color.lightyellow "mikael.kall@unibet.com"
 color.default ""
 color.green "${BOLD}General Options${RESET}"
 color.default ""
 color.red "${BOLD}w${RESET}${LIGHTWHITE}|${CYAN}web${LIGHTWHITE}          Start webbrowser"
 color.red "${BOLD}p${RESET}${LIGHTWHITE}|${CYAN}plugin${LIGHTWHITE}       Edit plugin"
 color.red "${BOLD}c${RESET}${LIGHTWHITE}|${CYAN}check${LIGHTWHITE}        Edit check"
 color.red "${BOLD}s${RESET}${LIGHTWHITE}|${CYAN}save${LIGHTWHITE}         Save checks"
 color.red "${BOLD}q${RESET}${LIGHTWHITE}|${CYAN}quit${LIGHTWHITE}         Quit application"
 color.default ""
 color.green "${BOLD}Check_mk${RESET}"
 color.default ""
 color.red "${BOLD}x${RESET}${LIGHTWHITE}|${CYAN}execute${LIGHTWHITE}     Freetype cmk command"
 color.red "${BOLD}i${RESET}${LIGHTWHITE}|${CYAN}inventory${LIGHTWHITE}   Inventory server"
 color.red "${BOLD}r${RESET}${LIGHTWHITE}|${CYAN}run${LIGHTWHITE}         Run check"
 color.red "${BOLD}d${RESET}${LIGHTWHITE}|${CYAN}dump${LIGHTWHITE}        Dump checks"
 color.red "${BOLD}l${RESET}${LIGHTWHITE}|${CYAN}list${LIGHTWHITE}        List checks"
 color.red "${BOLD}o${RESET}${LIGHTWHITE}|${CYAN}reload${LIGHTWHITE}      Nagios reload"
 color.red "${BOLD}h${RESET}${LIGHTWHITE}|${CYAN}help${LIGHTWHITE}        View cmk help"
 color.default ""
 color.green "${BOLD}Docker${RESET}"
 color.default ""
 color.red "${BOLD}b${RESET}${LIGHTWHITE}|${CYAN}boot${LIGHTWHITE}        Boot containers"
 color.red "${BOLD}u${RESET}${LIGHTWHITE}|${CYAN}uninstall${LIGHTWHITE}   Stop and uninstall all containers" 
 color.default ""

}
