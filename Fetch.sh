#!/bin/sh
ResFile="$0.res"
CurrentDir="$1" || ""
echo $'\n\n----' >> "${ResFile}"
set -o pipefail
set -uC
( (
	set -ex
	date
	pwd
	source "${CurrentDir}./zConfig.sh"
	WorkDir="${CurrentDir}${WorkDir}";
	cd "${WorkDir}"
	pwd
	FetchCmd="git fetch --prune --all --verbose"
	time ${FetchCmd} ||
	(
		CurrentPos="$(git rev-parse --abbrev-ref HEAD)"
		git checkout -q HEAD~0
		ExitCode=0
		${FetchCmd} ||
		ExitCode=$?
		git checkout -q "${CurrentPos}"
		exit ${ExitCode}
	) ; (exit $?) || false

  )
	ExitCode=$?
	(exit ${ExitCode}) && echo 'Success' || echo "Error / ExitCode = $?"
	exit ${ExitCode}
) 2>&1 | tee -a "${ResFile}"
ExitCode=$?
exit ${ExitCode}