#!/bin/sh
ResFile="$0.res"
echo $'\n\n----' >> "${ResFile}"
set -o pipefail
set -uC
( (
	set -ex
	pwd
	source './zConfig.sh'
	cd "${WorkDir}"

    (
	  ExitCode=0
	  time git fetch --all --prune --verbose ||
	  ExitCode=$?
    ) ; (exit $?) || false

  )
  
  ExitCode=$?
  exit ${ExitCode}) && echo 'Success' || echo "Error / ExitCode = $?"
  exit ${ExitCode}
) 2>&1 | tee -a "${ResFile}"

exit ${ExitCode}
