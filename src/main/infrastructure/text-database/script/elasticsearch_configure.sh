#!/bin/sh

# Default script behavior.
set -o errexit
#set -o pipefail

# Default parameters.
DEBUG=false
DEBUG_OPT=
SCRIPT_DIRECTORY=${PWD}/bin
STARTUP_WAIT=30

# For each argument.
while :; do
	case ${1} in
		
		# If debuf is enabled.
		--debug)
			DEBUG=true
			DEBUG_OPT="--debug"
			;;

		# Startup wait.
		-w|startup-wait)
			STARTUP_WAIT=${2}
			shift
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
${DEBUG} && echo "Running 'elasticsearch_configure'"

# Waits for it ot start
sleep ${STARTUP_WAIT}

# If there is a configure indexes script.
if [ -f ${SCRIPT_DIRECTORY}/configure_indexes.sh ]
then

	# Configures the indexes.
	. ${SCRIPT_DIRECTORY}/configure_indexes.sh

fi

# If there is a configure roles script.
if [ -f ${SCRIPT_DIRECTORY}/configure_roles.sh ]
then

	# Configures the roles.
	. ${SCRIPT_DIRECTORY}/configure_roles.sh

fi

# Refreshes indexes.
curl -XPOST -u elastic:${PASSWORD} "localhost:${NODE_HTTP_PORT}/_refresh"


