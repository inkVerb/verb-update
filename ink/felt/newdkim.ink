#!/bin/bash

# Set the serf name
SURFNAME="newinkdkim"

# Include the settings & functions
. ${INKSET}
. ${iDir}/ink.functions

# About message
aboutMsg="$(cat <<EOU
This creates new domain DKIM keys for a hosted domain.
- This is usually unnecessary since OpenDKIM keys and entries are automatically handled by:
  # ink add domain
  # ink new domainshell (avoid using)
  # ink kill domain
  # ink kill domainshell (severe)
- This is usually needed only after (dangerously) running: (if you want to refresh your OpenDKIM keys)
  # ink kill dkim
EOU
)"

# Available flags
optSerf="d:hrcv"
declare -A optName
declare -A optDesc
optName[d]="Domain"
optDesc[d]="A new domain to create DKIM keys for (or subdomain if using for email and unique SSL certificates)"

# Check the variables
while getopts "${optSerf}" Flag; do
 case "${Flag}" in
  d)
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
success_message="$SOd domain OpenDKIM keys created and added."

# Fail message
fail_message="$SOd domain OpenDKIM keys failed to be created and added."

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
