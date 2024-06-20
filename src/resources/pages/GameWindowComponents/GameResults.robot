*** Settings ***
Documentation    All Keywords part of this file expect the game container iframe
...              to have been selected before they are called.

Resource    ../../Helpers.robot


*** Variables ***
# Locators
${GAME_END_RESULTS_SCREEN_XPATH}    //section[contains(@class,'gameEndPopup_window__')]
${GAME_END_RESULTS_SCREEN_COMP_PERCENT_FIELD_XPATH}    //section[contains(@class,'gameEndPopup_container__')]/section[1]/h2
${GAME_END_RESULTS_SCREEN_BUTTONS_CONTAINER_XPATH}    ${GAME_END_RESULTS_SCREEN_XPATH}/descendant::section[contains(@class,'gameEndPopup_submitContainer__')]
${GAME_END_RESULTS_SCREEN_REVIEW_BUTTON_XPATH}    ${GAME_END_RESULTS_SCREEN_BUTTONS_CONTAINER_XPATH}/button[text()='Review Answers']

${GAME_END_RESULTS_SCREEN_SHOW_BUTTON_XPATH}    //button[contains(@class,'gameEndPopup_showButton__')]

# Other variables
${COMPLETED_PUZZLE_SCREENSHOT_NAME}    completed_puzzle_proof.png
${RESULT_SCREEN_SCREENSHOT_NAME}    completed_puzzle_results_screen_proof.png


*** Keywords ***
Verify Results Screen Content
    [Arguments]    ${expected_completion_percentage}

    Wait Until Element Contains     xpath:${GAME_END_RESULTS_SCREEN_COMP_PERCENT_FIELD_XPATH}
    ...                             %

    ${actual_completed_percentage}    Get Text    xpath:${GAME_END_RESULTS_SCREEN_COMP_PERCENT_FIELD_XPATH}
    Should Be Equal As Strings    ${actual_completed_percentage}
    ...                           ${expected_completion_percentage}


Take Completed Puzzle Screenshots
    Capture Page Screenshot    ${RESULT_SCREEN_SCREENSHOT_NAME}

    Click Element After It Loads    xpath:${GAME_END_RESULTS_SCREEN_REVIEW_BUTTON_XPATH}
    Wait Until Page Contains Element     xpath:${GAME_END_RESULTS_SCREEN_SHOW_BUTTON_XPATH}
    Capture Page Screenshot    ${COMPLETED_PUZZLE_SCREENSHOT_NAME}
