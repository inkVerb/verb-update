#!/bin/bash

# Set the serf name
SURFNAME="killboss"

# Include the settings & functions
. ${INKSET}
. ${iDir}/ink.functions

# About message
aboutMsg="$(cat <<EOU
This removes a new Linux user having sudo permissions and purges the home folder.
EOU
)"

# Available flags
optSerf="u:hrcv"
declare -A optName
declare -A optDesc
optName[u]="Username"
optDesc[u]="The username being destroyed"

# Check the variables
while getopts "${optSerf}" Flag; do
 case "${Flag}" in
  u)
    isUsername "${OPTARG}" "${optName[u]}"
    SOu="${OPTARG}"
  ;;
   p)
     isDomain "${OPTARG}" "${optName[d]}"
     SOd="${OPTARG}"
   ;;
   # Standard flags
   c)
     SOcli="true"
   ;;
   v)
     SOverbose="true"
   ;;
   h)
     SOh="true"
   ;;
   r)
     richtext="true"
   ;;
   *)
     inkFail
   ;;
 esac
done

# Message prep
# Success message
success_message="$SOu boss user destroyed."

# Fail messages
fail_message="$SOu boss user failed to be destroyed."

# Check requirements or defaults
## HELP
if [ "${SOh}" = "true" ]; then
  /bin/echo "
${aboutMsg}"
  /bin/echo "
Available flags:
-h This help message
-u ${optName[u]}: ${optDesc[u]}
-p ${optName[p]}: ${optDesc[p]}
"
  exit 0
fi

## Required flags & defaults
if [ -z "${SOu}" ]; then
  #SOd="DEFAULT" # Uncomment for optional default
  /bin/echo "${optName[u]} option must be set."; inkFail # Uncomment if required
fi
if [ -z "${SOp}" ]; then
  SOp="$(pwgen -s1 38)" # Uncomment for optional default
  #/bin/echo "${optName[u]} option must be set."; inkFail # Uncomment if required
fi

# Prepare command
serfcommand="${SERFS}/${SURFNAME} ${SOu} ${SOp}"

# Run the ink
. $INKRUN
