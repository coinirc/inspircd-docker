#!/bin/sh
# shellcheck disable=SC2039

########################################
###                                  ###
### DON'T EDIT THIS FILE AFTER BUILD ###
###                                  ###
###    USE ENVIRONMENT VARIABLES     ###
###              INSTEAD             ###
###                                  ###
########################################



# Default variables
cat <<EOF
# Network section
<define name="hostname" value="${HOSTNAME:-coinirc}">
<define name="netsuffix" value="${INSP_NET_SUFFIX:-.coinirc.com}">
<define name="netname" value="${INSP_NET_NAME:-CoinIRC}">
<define name="servername" value="${INSP_SERVER_NAME:-&hostname;&netsuffix;}">

# Admin section
<define name="adminname" value="${INSP_ADMIN_NAME:-CoinIRC crew}">
<define name="adminnick" value="${INSP_ADMIN_NICK:-circ}">
<define name="adminemail" value="${INSP_ADMIN_EMAIL:-circ@tutanota.com}">

# Connect block section
<define name="usednsbl" value="${INSP_ENABLE_DNSBL:-yes}">
EOF

# Include custom configurations if conf.d exists
if [ -d conf.d ]; then
    find conf.d/*.conf | while read -r file; do echo "<include file=\"$file\">"; done
fi

# Include custom configurations from docker secrets. (For example for further oper configs)
if [ -d /run/secrets ]; then
    find /run/secrets/*.conf | while read -r file; do echo "<include file=\"$file\">"; done
fi

# Space for further configs
