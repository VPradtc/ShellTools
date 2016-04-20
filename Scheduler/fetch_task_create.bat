set currentDir=%~dp0
schtasks /Create /SC "DAILY" /TN "git_fetch" /TR "%currentDir%..\Fetch.sh" /ST "10:00" /DU "10:00" /RI 5