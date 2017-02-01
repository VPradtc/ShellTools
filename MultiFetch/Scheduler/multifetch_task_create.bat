set currentDir=%~dp0
schtasks /Create /V1 /SC "WEEKLY" /D "MON,TUE,WED,THU,FRI" /TN "git_multifetch" /TR "%currentDir%..\MultiFetch.sh %currentDir%..\\" /ST "00:00" /DU "24:00" /RI 5