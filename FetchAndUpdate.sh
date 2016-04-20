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
	set +x

	PasswordPrompt="Enter password for '${Username}':"$'\n'
	while IFS= read -rs -n1 -p "${PasswordPrompt}" PasswordChar ; do
		# Enter - accept password
		if [[ $PasswordChar == $'\0' ]] ; then
			break
		fi
		# Backspace
		if [[ $PasswordChar == $'\177' ]] ; then
			if [ ! -z "${Password}" ] ; then
				PasswordPrompt=$'\b\b\b   \b\b\b'
				Password="${Password%?}"
			else
				PasswordPrompt=''
			fi
		else
			PasswordPrompt='***'
			Password+="$PasswordChar"
		fi
	done
	echo

	git config "tfs-remote.${RemoteBrName}.password" "${Password}"

	ExitCode=0
	time git tfs fetch -d \
		-u "${Username}" \
		-i "${RemoteBrName}" ||
	ExitCode=$?
	git config --unset "tfs-remote.${RemoteBrName}.password"
	(exit ${ExitCode}) || false

		#-p "${Password}" \
		#2>&1 | sed "s/${PasswordEscaped}/x/g"
) ; (exit $?) || false


true ||
[[ -z "$(git status --porcelain | head -1)" ]] ||
{
	git reset --hard &&
	git clean -fd
} ||
false

BrName='master'
FetchCmd="git fetch . refs/remotes/tfs/${RemoteBrName}:refs/heads/${BrName}"
${FetchCmd} ||
(
	CurrentPos="$(git rev-parse --abbrev-ref HEAD)"
	git checkout -q HEAD~0
	ExitCode=0
	${FetchCmd} ||
	ExitCode=$?
	git checkout -q "${CurrentPos}"
	exit ${ExitCode}
) ; (exit $?) || false


#(
#) ; (exit $?) || false

	)
	ExitCode=$?
	(exit ${ExitCode}) && echo 'Success' || echo "Error / ExitCode = $?"
	exit ${ExitCode}
) 2>&1 | tee -a "${ResFile}"
ExitCode=$?
#echo '' >> "${ResFile}"
read -rs -n1 -p 'Press any key to continue...'
exit ${ExitCode}
