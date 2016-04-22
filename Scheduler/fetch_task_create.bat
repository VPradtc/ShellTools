set currentDir=%~dp0
schtasks /Create /SC "WEEKLY" /D "MON,TUE,WED,THU,FRI" /TN "git_fetch" /TR "%currentDir%..\Fetch.sh %currentDir%..\\" /ST "10:00" /DU "10:00" /RI 5