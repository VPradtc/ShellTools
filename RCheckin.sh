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


SourceBashFunctions() {
	source d:/BashFunctions/main/BashFunctions.sh
}
#SourceBashFunctions

(
	set +x

	#read -rs -p "Enter password for '${Username}':"$'\n' Password

	Password=''
	echo "Enter password for '${Username}':"
	while IFS= read -rs -n1 PasswordChar ; do
		# Enter - accept password
		if [[ $PasswordChar == $'\0' ]] ; then
			break
		fi
		# Backspace
		if [[ $PasswordChar == $'\177' ]] ; then
			if [ ! -z "${Password}" ] ; then
				printf $'\b\b\b   \b\b\b'
				Password="${Password%?}"
			fi
		else
			printf '***'
			Password+="$PasswordChar"
		fi
	done
	echo

	#SedSearchStrEscape() { (
	#	echo $1 | sed -e 's/[]\/$*.^|[]/\\&/g'
	#) }

	#PasswordEscaped=$(SedSearchStrEscape "${Password}")

	UsernameKey="tfs-remote.${RemoteBrName}.username"
	PasswordKey="tfs-remote.${RemoteBrName}.password"
	UsernameBak=$(git config "${UsernameKey}")
	git config "${UsernameKey}" "${Username}"
	git config "${PasswordKey}" "${Password}"

	ExitCode=0
	time git tfs rcheckin -d \
		-i "${RemoteBrName}" \
		||
	ExitCode=$?

	git config --unset "${PasswordKey}"
	git config "${UsernameKey}" "${UsernameBak}"
	(exit ${ExitCode})

		#--no-merge \
		#-u "${Username}" \
		#-p "${Password}" \
		#2>&1 | sed "s/${PasswordEscaped}/x/g"
) ; (exit $?) || false


BrName='master'
#GitRebaseWithFallback "tfs/${RemoteBrName}" "${BrName}"


#(
#) ; (exit $?) || false

	)
	ExitCode=$?
	(exit ${ExitCode}) && echo 'Success' || echo "Error / ExitCode = $?"
	exit ${ExitCode}
) 2>&1 | tee -a "${ResFile}"
ExitCode=$?
#echo '' >> "${ResFile}"
read -rs -n1 -p $'Press any key to continue...\n'
exit ${ExitCode}
