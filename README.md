# Introduction
This repository holds the source code for an automated test script that leverages RobotFramework together with its SeleniumLibrary to perform the necessary actions to complete a puzzle from the "Daily Quick Crossword" web-based game hosted at https://www.gamelab.com/games/daily-quick-crossword.


The test script has been executed and confirmed to be working on Windows 10 with Chrome Version 125.0.6422.142 (64-bit), as such, the sections below describe the dependencies required to execute the script in the context of Windows 10 and Chrome.


# Prerequisites for Successful Script Execution

## Operating System
An up to date version of Windows 10 (it is very likely that Windows 11 will work as well).

## Browser
An up to date version of Google Chrome, which can be obtain from google's website: https://www.google.com/chrome/.

## Programming Language Dependencies
### Python
The Python programming language is a dependency for RobotFramework, as such, download and install the latest version of Python as described on the website of the programming language at https://www.python.org/downloads/.

**Confirm that the installation was performed successfully by opening a new terminal and executing the command: python --version**

If any issues are encountered, additional details related to the installation of Python can be found on RobotFramework's GitHub https://github.com/robotframework/robotframework/blob/master/INSTALL.rst#installing-python-on-windows.


### RobotFramework
The automated test script is implemented using RobotFramework, as such, install the latest version of RobotFramework as described on the RobotFramework website or on its GitHub https://github.com/robotframework/robotframework/blob/master/INSTALL.rst#installing-and-uninstalling-robot-framework.

**Note that the scripts use features implemented starting with RobotFramework version 7.0. The automated script will not complete execution successfully when executed under a RobotFramework version lower than 7.0.**

**Confirm that the installation was performed successfully by opening a new terminal and executing the command: robot --version**


### SeleniumLibrary
RobotFramework's SeleniumLibrary uses Selenium internally to enable the automation of browser actions. Since the primary purpose of the automated test script found in this reporistory is to interact with a browser, SeleniumLibrary must be installed as described on its Github https://github.com/robotframework/SeleniumLibrary/blob/master/README.rst#installation.

### ChromeDriver
The last dependency is ChromeDriver, which must be downloaded and accessible to SeleniumLibrary in order for the automated script to start the browser and interact with it.

SeleniumLibrary's GitHub provides documentation on how browser drivers can be installed (see https://github.com/robotframework/SeleniumLibrary/blob/master/README.rst#browser-drivers), but the necessary steps have been provided below as well:
1. Navigate to https://googlechromelabs.github.io/chrome-for-testing/
2. Scroll down to the **Stable** table
3. Identify the chromedriver binary that matches your OS and the currently installed version of Google Chrome
4. Access the related URL
5. Save the archive
6. Create a folder dedicated to browser drivers on one of the partitions of the device (e.g., "C:/browser_drivers/")
7. Extract the binary from the archive downloaded at step 5 into the folder created at step 6
8. Open the Control Panel
9. Select "System"
10. On the right-side of the newly opened window select "Advanced system settings"
11. Click "Environment Variables" on the newly open "System Properties" window
12. Select the "Path" item in the "User variables for {USERNAME}" section
13. Click the "Edit" button
14. Click the "New" button on the newly open "Edit environment variable" window
15. Add the folder created at step 6
16. Click "OK" for the "Edit environment variable" window
17. Click "OK" for the "Edit Variables" window
18. Click "Apply" then "OK" for the "System Properties" window

**Confirm that the operation was performed successfully by opening a new terminal and executing the command: chromedriver --version**


# Execution of the Automated Test Script
