#!/bin/sh
ResFile="$0.res"
GitFilter="*/.git/*"
ExtensionFilter=".*\.\(cs\|html\|cshtml\|xml\|js\|ts\|csproj\|sln\|config\|asax\|json\|template\)"
echo $'\n\n----' >> "${ResFile}"
set -o pipefail
set -uC
( (
	set -ex
	source "./zConfig.sh"
	date
	pwd

    FindCodeCmd="find ./ -type f -not -path '${GitFilter}' -regex '${ExtensionFilter}'"
    FindFilesCmd="find ./ -type f -not -path '${GitFilter}' -name '*${OldName}'*"
    FindDirsCmd="find ./ -type d -not -path '${GitFilter}' -name '*${OldName}'*"

	SedCmd="sed -i'' 's/${OldName}/${NewName}/g' {} +"
	RenameCmd="while read FNAME; do mv \"\$FNAME\" \"\${FNAME//${OldName}/${NewName}}\"; done"

	eval "${FindCodeCmd} -exec ${SedCmd}"
	eval "${FindDirsCmd} | ${RenameCmd}"
	eval "${FindFilesCmd} | ${RenameCmd}"

	# (
	# 	eval "git remote remove origin"
	# 	eval "git reset --soft ${RootSHA}"
	# 	eval "git add -A"
	# 	eval "git commit --amend --no-edit"
	# )
  )
	ExitCode=$?
	(exit ${ExitCode}) && echo 'Success' || echo "Error / ExitCode = $?"
	exit ${ExitCode}
) 2>&1 | tee -a "${ResFile}"
ExitCode=$?
exit ${ExitCode}