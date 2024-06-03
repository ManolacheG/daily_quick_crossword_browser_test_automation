*** Settings ***
Documentation    This file defines all variables for which values are expected to be
...              provided in order for tests to start their execution successfully.
...              Most commonly, values will be provided for these variables
...              when the test or test suite execution is started from the command line.


*** Variables ***
${BROWSER}    ${NONE}
${DQC_GAME_URL}    ${NONE}

# The target resolution of the document loaded in the browser is specified explicitly
# to remove the variability introduced by maximizing the browser window,
# as different machines will have different resolutions,
# some of which not representing valid test targets.
${INNER_DOC_WIDTH}         ${1920}
${INNER_DOC_HEIGHT}        ${919}
