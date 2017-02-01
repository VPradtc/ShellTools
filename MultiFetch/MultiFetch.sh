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
	source "${CurrentDir}./_GlobalConfig.sh"

	WorkDir="${CurrentDir}${RepoListDir}"
    	SingleFetchRelativeCmdPath="${CurrentDir}./SingleFetch.sh"
    	SingleFetchCmdPath=$(realpath $SingleFetchRelativeCmdPath);
	cd "${WorkDir}"
	pwd

    	FindRepoListCmd="find ./ -maxdepth 1 -type f"

    	$FindRepoListCmd | xargs realpath | xargs -n 1 "${SingleFetchCmdPath}"
	ExitCode=$?
	(exit $?) || false
  )
	ExitCode=$?
	(exit ${ExitCode}) && echo 'Success' || echo "Error / ExitCode = $?"
	exit ${ExitCode}
) 2>&1 | tee -a "${ResFile}"
ExitCode=$?
exit ${ExitCode}