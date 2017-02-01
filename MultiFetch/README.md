### TABLE OF CONTENTS ###
1. Prerequisites
2. Actions
	2.1. Start/Stop
	2.2. Add a new repository mirror
	2.3. Stop mirroring a repository
	2.4. One-time manual run

### 1. Prerequisites ###
- Git
- Git-Bash

### 2. Actions ###
	### 2.1. Start/Stop ###
	To start mirroring in background, navigate to /Scheduler and run multifetch_task_create.bat.
	To stop, run multifetch_task_kill.bat.
	NOTE: Moving the folder that contains MultiFetch.sh breaks background mirroring. Whenever you move it, you have to run multifetch_task_create.bat again.
	### 2.2. Add a new repository ###
	To add a new repository, navigate to /Repositories and create a text file with the following structure:
		First line - path to local folder that will contain the repository (Example: C:\Program Files).
		NOTE: Make sure the last character of the provided path is not backslash (\).
		Second line - URL of the git repository (Example: https://github.com/ryanmcdermott/clean-code-javascript.git)
		NOTE: The URL must end with a .git extension.
	Initially, /Repositories contains files for BMP, KAT, KIC Service and DLOS repositories. You can edit them instead.
	### 2.3. Stop mirroring a repository ###
	To stop mirroring a repository, delete its respective file in /Repositories folder.
	### 2.4. One-time manual run ###
	To run a mirror manually, run MultiFetch.sh in Git-Bash or Cygwin.
