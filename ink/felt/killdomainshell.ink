#!/bin/bash

# Set the serf name
SURFNAME="killdomainshell"

# Include the settings & functions
. ${INKSET}
. ${iDir}/ink.functions

# About message
aboutMsg="$(cat <<EOU
This removes a domain framework created with:
  # ink new domainshell
EOU
)"

# Available flags
optSerf="u:p:hrcv"
declare -A optName
declare -A optDesc
optName[d]="Domain"
optDesc[d]="The domain to remove the framework for"

# Check the variables
while getopts "${optSerf}" Flag; do
 case "${Flag}" in
  d)
    isDomain "${OPTARG}" "${optName[d]}"
    SOd="${OPTARG}"
  ;;
 esac
done
. $INKOPT

# Message prep
# Success message
success_message="$SOd domain framework removed."

# Fail message
fail_message="$SOd domain framework failed to be removed."

# Check requirements or defaults
## HELP
if [ "${SOh}" = "true" ]; then
  /bin/echo "
${aboutMsg}"
  /bin/echo "
Available flags:
-h This help message
-d ${optName[d]}: ${optDesc[d]}
"
  exit 0
fi

## Required flags & defaults
if [ -z "${SOd}" ]; then
  #SOd="DEFAULT" # Uncomment for optional default
  /bin/echo "${optName[d]} option must be set."; inkFail # Uncomment if required
fi

# Prepare command
serfcommand="${SERFS}/${SURFNAME} ${SOd}"

# Run the ink
. $INKRUN
