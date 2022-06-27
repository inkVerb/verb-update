#!/bin/bash

# Set the serf name
SURFNAME="activatefiles"

# Include the settings & functions
. ${INKSET}
. ${iDir}/ink.functions
. ${CONF}/siteurilist

# About message
aboutMsg="$(cat <<EOU
This activates the files.${vipURI} folder for availability on the web
-y	(files.${vipURI} becomes a web-accessible folder)
-n	(files.${vipURI} returns to a redirect to ${inkURI})
Note, SFTP must be installed on the Verber first
EOU
)"

# Available flags
optSerf="hynrcv"
declare -A optName
declare -A optDesc
optName[yn]="y/n"
optDesc[yn]="Choose one-letter flag: -y=on -n=off"

# Check the variables
while getopts "${optSerf}" Flag; do
 case "${Flag}" in
  y)
    SOyn="on"
    yes="true"
    SuccessMessage="VIP files activated."
    FailMessage="VIP files failed to activate."
  ;;
  n)
    SOyn="off"
    no="true"
    SuccessMessage="VIP files deactivated."
    FailMessage="VIP files failed to deactivate."
  ;;
 esac
done
. $INKOPT

# Message prep
# Success message
success_message=$SuccessMessage

# Fail message
fail_message=$FailMessage

# Check requirements or defaults
## HELP
if [ "${SOh}" = "true" ]; then
  /bin/echo "
${aboutMsg}"
  /bin/echo "
Available flags:
-h This help message
-y/n  ${optName[yn]}: ${optDesc[yn]}
"
  exit 0
fi

## Y/N requirements
if [ -z "${SOyn}" ]; then
  /bin/echo "${optName[yn]}  option must be set."; inkFail # Uncomment if required
fi
if [ -n $yes ] && [ -n $no ]; then
  inkFail
fi

# Prepare command
serfcommand="${SERFS}/${SURFNAME} ${SOyn}"

# Run the ink
. $INKRUN
