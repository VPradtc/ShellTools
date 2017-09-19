@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

choco feature enable -n allowGlobalConfirmation

choco install googlechrome
choco install adobereader
choco install jre8
choco install firefox
choco install 7zip.install
choco install notepadplusplus.install
choco install nodejs.install
choco install skype
choco install git.install
choco install filezilla
choco install dotnet4.5
choco install malwarebytes
choco install thunderbird
choco install virtualbox
choco install teamviewer

choco install cygwin
choco install wireshark
choco install sublimetext3
choco install tortoisegit
choco install spotify
choco install nmap
choco install tor-browser
choco install Git-Credential-Manager-for-Windows


choco install adblockplus-firefox
choco install doublecmd
choco install truecrypt
