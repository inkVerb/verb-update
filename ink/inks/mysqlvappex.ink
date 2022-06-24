#!/bin/bash

# Set the serf name
SURFNAME="mysqlvappex"

# Include the settings & functions
. ${INKSET}
. ${iDir}/ink.functions

# About message
aboutMsg="$(cat <<EOU
This exports a MySQL/MariaDB database for a given Verb web app.
EOU
)"

# Available flags
optSerf="a:hrcv"
declare -A optName
declare -A optDesc
optName[a]="App"
optDesc[a]="The Verb web app to export the database for"

# Check the variables
while getopts "${optSerf}" Flag; do
 case "${Flag}" in
 . $INKOPT
   a)
     isVappConfig "${OPTARG}" "${optName[a]}"
     SOa="${OPTARG}"
   ;;
 esac
done

# Message prep
# Success message
success_message="Verb web app '$SOa' exported."

# Fail message
fail_message="Verb web app '$SOa' failed to be exported."

# Check requirements or defaults
## HELP
if [ "${SOh}" = "true" ]; then
  /bin/echo "
${aboutMsg}"
  /bin/echo "
Available flags:
-h This help message
-a ${optName[a]}: ${optDesc[a]}
"
  exit 0
fi

## Required flags & defaults
if [ -z "${SOa}" ]; then
  #SOa="DEFAULT" # Uncomment for optional default
  /bin/echo "${optName[a]} option must be set."; inkFail # Uncomment if required
fi

# Prepare command
serfcommand="${SERFS}/${SURFNAME} ${SOa}"

# Run the ink
. $INKRUN
