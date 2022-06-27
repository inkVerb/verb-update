#!/bin/bash

# Set the serf name
SURFNAME="mysqlkilluser"

# Include the settings & functions
. ${INKSET}
. ${iDir}/ink.functions

# About message
aboutMsg="$(cat <<EOU
This destroys (drops) a MySQL/MariaDB database useer.
EOU
)"

# Available flags
optSerf="u:hrcv"
declare -A optName
declare -A optDesc
optName[u]="Username"
optDesc[u]="The username being created"

# Check the variables
while getopts "${optSerf}" Flag; do
 case "${Flag}" in
   u)
     isSQLUserCredential "${OPTARG}" "${optName[u]}"
     SOu="${OPTARG}"
   ;;
 esac
done
. $INKOPT

# Message prep
# Success message
success_message="Database user '$SOu' dropped."

# Fail message
fail_message="Database user '$SOu' failed to drop."

# Check requirements or defaults
## HELP
if [ "${SOh}" = "true" ]; then
  /bin/echo "
${aboutMsg}"
  /bin/echo "
Available flags:
-h This help message
-u ${optName[u]}: ${optDesc[u]}
"
  exit 0
fi

## Required flags & defaults
if [ -z "${SOu}" ]; then
  #SOd="DEFAULT" # Uncomment for optional default
  /bin/echo "${optName[u]} option must be set."; inkFail # Uncomment if required
fi

# Prepare command
serfcommand="${SERFS}/${SURFNAME} ${SOu}"

# Run the ink
. $INKRUN
