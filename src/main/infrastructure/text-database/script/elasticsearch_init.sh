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
${DEBUG} && echo "Running 'elasticsearch_init'"
${DEBUG} && echo "STARTUP_WAIT=${STARTUP_WAIT}"

# Continues configuring the node in the background.
elasticsearch_configure &

# Starts the main process.
/usr/local/bin/docker-entrypoint.sh 



