schtasks /Create /SC "DAILY" /TN "git_fetch" /TR "../Fetch.sh" /ST "10:00" /RI 5