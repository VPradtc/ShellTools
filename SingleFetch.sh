#!/bin/sh
ResFile="$0.res"
echo $'\n\n----' >> "${ResFile}"
set -o pipefail
set -uC
( (
	set -ex
	date
	pwd

	RepoConfigPath="$1"
	LocalRepo=""
	RemoteRepo=""

	while IFS='' read -r line || [[ -n "$line" ]]; do
		[[ -z  $LocalRepo ]] && LocalRepo="$(cygpath -u $line)" && continue
		[[ -z  $RemoteRepo ]] && RemoteRepo=$line && continue
	done < "$1"

	InitCmd="git init"
	AddRemoteCmd="git remote add origin ${RemoteRepo}"
	FetchCmd="git fetch --prune --all --verbose"

	cd $LocalRepo || (mkdir -p $LocalRepo && cd $LocalRepo) && (
		($InitCmd) || true
		($AddRemoteCmd) || true
	) || exit $?

	${FetchCmd} ||
	ExitCode=$?
	(exit $?) || false
  )
	ExitCode=$?
	(exit ${ExitCode}) && echo 'Success' || echo "Error / ExitCode = $?"
	exit ${ExitCode}
) 2>&1 | tee -a "${ResFile}"
ExitCode=$?
exit ${ExitCode}