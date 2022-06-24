#!/bin/bash

# Set the serf name
SURFNAME="killftpuser"

# Include the settings & functions
. ${INKSET}
. ${iDir}/ink.functions

# About message
aboutMsg="$(cat <<EOU
This destroys any FTP user, whether 'user', 'filer', or 'vip'.
EOU
)"

# Available flags
optSerf="u:hrcv"
declare -A optName
declare -A optDesc
optName[u]="Username"
optDesc[u]="The FTP username to destroy"

# Check the variables
while getopts "${optSerf}" Flag; do
 case "${Flag}" in
 . $INKOPT
    u)
      isUsername "${OPTARG}" "${optName[u]}"
      SOu="${OPTARG}"
    ;;
 esac
done

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

# Message prep
# Success message
success_message="$SOu FTP user destroyed."

# Fail message
fail_message="$SOu FTP useer failed to be destroyed."


# Prepare command
serfcommand="${SERFS}/${SURFNAME} ${SOu}"

# Run the ink
. $INKRUN
