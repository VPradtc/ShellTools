#!/bin/sh
ResFile="$0.res"
echo $'\n\n----' >> "${ResFile}"
set -o pipefail
set -uC

(
  set -ex 
  ToolsDir="$(pwd)"
  (
	pwd
	source './zConfig.sh'
	cd "${WorkDir}"

	(
	  ExitCode=0
	  time git config credential.helper "cache --timeout=3600*8"
	  ExitCode=$?
	) ; (exit $?) || false

  )
  ExitCode=$?
  exit ${ExitCode}) && echo 'Success' || echo "Error / ExitCode = $?"
  
  pwd
  cd "${ToolsDir}"
  source "./Fetch.sh"
  
  exit ${ExitCode}
 2>&1 | tee -a "${ResFile}"

read -rs -n1 -p 'Press any key to continue...'

exit ${ExitCode}
