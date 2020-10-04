#!/bin/sh

# Default script behavior.
set -o errexit
#set -o pipefail

# Default parameters.
DEBUG=true
DEBUG_OPT=

# For each argument.
while :; do
	case ${1} in
		
		# Debug argument.
		--debug)
			DEBUG=true
			DEBUG_OPT="--debug"
			;;
			
		# Other option.
		?*)
			CMD="${CMD} ${1}"
			;;

		# No more options.
		*)
			break

	esac 
	shift
done

# Using unavaialble variables should fail the script.
set -o nounset

# Enables interruption signal handling.
trap - INT TERM

# Print arguments if on debug mode.
${DEBUG} && echo "Running 'grafana_init'"

# Replaces variables in the files.
envsubst < ${GF_AUTH_LDAP_CONFIG_FILE} > ${GF_AUTH_LDAP_CONFIG_FILE}

# Runs the start command.
${DEBUG} && echo "exec ${CMD}"
exec ${CMD}
