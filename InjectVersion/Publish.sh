#!/bin/sh
ResFile="$0.res"
echo $'\n\n----' >> "${ResFile}"
set -o pipefail
set -uC
( (
	set -ex
	source "./zConfig.sh"
	date
	pwd
	
	./CommitVersion.sh && git checkout $ReleaseBranch && git merge $DevBranch --no-ff && ./TagVersion.sh && git rebase head $ConfigBranch && ./InjectVersion.sh;
  )
	ExitCode=$?
	(exit ${ExitCode}) && echo 'Success' || echo "Error / ExitCode = $?"
	exit ${ExitCode}
) 2>&1 | tee -a "${ResFile}"
ExitCode=$?
exit ${ExitCode}
