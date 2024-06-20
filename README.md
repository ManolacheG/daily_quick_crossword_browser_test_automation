# Introduction
This repository holds the source code for an automated test script that leverages RobotFramework together with its SeleniumLibrary to perform the necessary actions to complete a puzzle from the "Daily Quick Crossword" web-based game hosted at https://www.gamelab.com/games/daily-quick-crossword.


The test script has been executed and confirmed to be working on Windows 10 with Chrome Version 125.0.6422.142 (64-bit), as such, the sections below describe the dependencies required to execute the script in the context of Windows 10 and Chrome.


# Prerequisites for Successful Script Execution

## Operating System
An up to date version of Windows 10 (although it is very likely that Windows 11 will work as well).

## Browser
An up to date version of Google Chrome, which can be obtained from google's website: https://www.google.com/chrome/.

## Python
The Python programming language is a dependency for RobotFramework, as such, download and install the latest version of Python as described on the website of the programming language at https://www.python.org/downloads/.

**Python Installation Notes**
1. When installing Python, make sure that the "Add python.exe to PATH" option is selected in the installer.
2. If any issues are encountered, additional details related to the installation of Python can be found on RobotFramework's GitHub at https://github.com/robotframework/robotframework/blob/master/INSTALL.rst#installing-python-on-windows.
3. Confirm that the installation was performed successfully by opening a new instance of a terminal (e.g., Command Prompt) and executing the command: python --version


## RobotFramework
The automated test script is implemented using RobotFramework, as such, install the latest version of RobotFramework as described on the RobotFramework website or on its GitHub (a terminal such as Command Prompt is required to execute the pip install command) https://github.com/robotframework/robotframework/blob/master/INSTALL.rst#installing-and-uninstalling-robot-framework.

**RobotFramework Installation Notes**
1. The scripts use features implemented starting with RobotFramework version 7.0. The automated script will not complete execution successfully when executed under a RobotFramework version lower than 7.0.
2. Confirm that the installation was performed successfully by opening a new instance of a terminal (e.g., Command Prompt) and executing the command: robot --version


## SeleniumLibrary
RobotFramework's SeleniumLibrary uses Selenium internally to enable the automation of browser actions. Since the primary purpose of the automated test script found in this repository is to interact with a browser, SeleniumLibrary must be installed as described on its Github at https://github.com/robotframework/SeleniumLibrary/blob/master/README.rst#installation.


## ChromeDriver
The last dependency is ChromeDriver, which must be downloaded and accessible to SeleniumLibrary in order for the automated script to start the browser and interact with it.

SeleniumLibrary's GitHub provides information on how browser drivers can be installed (see https://github.com/robotframework/SeleniumLibrary/blob/master/README.rst#browser-drivers), however, Windows installation steps for chromedriver have also been included below for completion:
1. Navigate to https://googlechromelabs.github.io/chrome-for-testing/
2. Scroll down to the **Stable** table
3. Identify the chromedriver binary that matches your OS and the currently installed version of Google Chrome
4. Access the related URL
5. Save the archive
6. Create a folder dedicated to browser drivers on one of the partitions of the device (e.g., "C:/browser_drivers/")
7. Extract the binary from the archive downloaded at step 5 into the folder created at step 6
8. Open the Control Panel
9. Go to "System And Security" and then to "System" (or just to "System" if the menu item is directly available)
10. On the right-side of the newly opened window select "Advanced system settings"
11. Click "Environment Variables" on the newly open "System Properties" window
12. Select the "Path" item in the "User variables for {USERNAME}" section
13. Click the "Edit" button
14. Click the "New" or "Browse" button on the newly open "Edit environment variable" window
15. Add the folder created at step 6
16. Click "OK" for the "Edit environment variable" window
17. Click "OK" for the "Edit Variables" window
18. Click "OK" for the "System Properties" window

**Confirm that the operation was performed successfully by opening a new instance of terminal (e.g., Command Prompt) and executing the command: chromedriver --version**


# Execution of the Automated Test Script
1. If the code from this repository was not previously downloaded, perform a git clone, or, download the code archive manually and extract it
2. Open a new terminal instance (e.g., Command Prompt)
3. Navigate to the folder in which the code was cloned or extracted
4. Execute a "dir" or "ls" command and ensure that you are in the root of the repository (e.g., the "src" folder is listed)
5. Execute the following command to start the execution of the script "robot -d results -v BROWSER:chrome -v DQC_GAME_URL:https://www.gamelab.com/games/daily-quick-crossword src/tests/PuzzleCompletionSmokeTests.robot"
6. Wait for the execution to complete. RobotFramework will list the execution result once it creates its output files.

The execution of the script creates a "results" folder (in the folder from which the execution was started) that stores the report and log of the script execution, which allows for the result of the execution to be reviewed after the script execution is concluded.


# Automated Test Execution Proof and Report
The folder "execution_result_log_and_proofs" found in the root of this repository contains:
1. The execution report and log generated by RobotFramework for the execution of the script. The report file provides a high-level overview of the executed tests, while the log file contains details related to each executed step of each test.
2. Two screenshots showing the state of the puzzle on its completion.
3. A video showing a successful execution of the script.
