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

	GitFilter="*/.git/*"
	ExtensionFilter=".*\.\(html\|js\)"
    
    FindFilesCmd="find ./ -type f -not -path '${GitFilter}' -regex '${ExtensionFilter}'"

    ScriptRegex="(([\x27\\\"])([a-zA-Z0-9./\\-]+\\.(js|html|json|css))(\2))"
    ScriptRegexReplace="\\2\\3?version=${Version}\\5"

	SedCmd="sed -r -i'' 's:${ScriptRegex}:${ScriptRegexReplace}:gi' {} +"

	InjectCmd="${FindFilesCmd} -exec ${SedCmd}"

	eval ${InjectCmd}
  )
	ExitCode=$?
	(exit ${ExitCode}) && echo 'Success' || echo "Error / ExitCode = $?"
	exit ${ExitCode}
) 2>&1 | tee -a "${ResFile}"
ExitCode=$?
exit ${ExitCode}

