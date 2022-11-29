# GasCore+

Prerequisites:
Have a working version of WSL installed within your windows Machine.

1) Download this project into your local and extract
2) Install the required GasGauge and Manticore libraries
3) If facing any issues with Solidity:
	i)Please upgrade the version of solidity and ensure that yarn.lock is updated
	ii) Update any contracts that have a hardcoded pragma version
4) Both Manticore and GasGauge have several libraries that are shared but download different versions:
	i) Update your Souffle version to match
	ii) Update your Truffle Version to match
	ii) Update your ganache-cli to match
5) You can use the sample contracts available within the project
6) During the first time run, if your WSL does not provide access to shutil.copy linux command, please run it on windows till it fails. The next runs could be ran through WSL.
	i) This step just copies over the contract to a location to perform the analysis
7) Run the project using "python3 run.py"