*** Settings ***
Resource    ../Helpers.robot
Resource    ../ExternalVariables.robot


*** Keywords ***
Open Browser At Daily Quick Crossword Game Page
    Start Browser    ${BROWSER}
    ...              ${INNER_DOC_WIDTH}    ${INNER_DOC_HEIGHT}
    ...              ${DQC_GAME_URL}
