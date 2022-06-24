#!/bin/bash

# Set the serf name
SURFNAME="mysqlkilldb"

# Include the settings & functions
. ${INKSET}
. ${iDir}/ink.functions

# About message
aboutMsg="$(cat <<EOU
This destroys (drops) a MySQL/MariaDB database.
EOU
)"

# Available flags
optSerf="d:hrcv"
declare -A optName
declare -A optDesc
optName[d]="Database"
optDesc[d]="The database to destroy"

# Check the variables
while getopts "${optSerf}" Flag; do
 case "${Flag}" in
 . $INKOPT
   d)
     isSQLDatabasename "${OPTARG}" "${optName[d]}"
     SOd="${OPTARG}"
   ;;
 esac
done

# Message prep
# Success message
success_message="Database '$SOd' dropped."

# Fail message
fail_message="Database '$SOd' failed to drop."

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
