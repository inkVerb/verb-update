#!/bin/bash

# Set the serf name
SURFNAME="webcgi"

# Include the settings & functions
. ${INKSET}
. ${iDir}/ink.functions

# Not for LEMP
forbiddenServerType LEMP

# About message
aboutMsg="$(cat <<EOU
This activates CGI for a domain or subdomain
EOU
)"

# Available flags
optSerf="hd:ynrcv"
declare -A optName
declare -A optDesc
optName[d]="Domain"
optDesc[d]="The hosted domain or subdomain to change the CGI option for"
optName[yn]="On/Off"
optDesc[yn]="Choose one-letter flag: -y=on -n=off"

# Check the variables
while getopts "${optSerf}" Flag; do
 case "${Flag}" in
 . $INKOPT
  d)
    isDomain "${OPTARG}" "${optName[d]}"
    SOd="${OPTARG}"
  ;;
  y)
    SOyn="on"
  ;;
  n)
    SOyn="off"
  ;;
 esac
done

# Message prep
# Success message
success_message="$SOd CGI $SOyn"

# Fail message
fail_message="$SOd CGI failed to turn $SOyn"

# Check requirements or defaults
## HELP
if [ "${SOh}" = "true" ]; then
  /bin/echo "
${aboutMsg}"
  /bin/echo "
Available flags:
-h This help message
-d ${optName[d]} ${optDesc[d]}
-y/n  ${optName[yn]}: ${optDesc[yn]}
"
  exit 0
fi

## Required flags & defaults
if [ -z "${SOd}" ]; then
  /bin/echo "${optName[d]} option must be set."; inkFail # Uncomment if required
fi

## Y/N
if [ -z "${SOyn}" ]; then
  /bin/echo "${optName[yn]}  option must be set."; inkFail # Uncomment if required
fi

# Prepare command
serfcommand="${SERFS}/${SURFNAME} ${SOyn} ${SOd}"

# Run the ink
. $INKRUN
