*** Settings ***
Library    String

Resource    ../Helpers.robot


*** Variables ***
# Locators
${GAME_CONTAINER_FRAME_ID}    canvas-box
${GAME_CONTAINER_FRAME_XPATH}    //iframe[@id='${GAME_CONTAINER_FRAME_ID}']

${MAIN_MENU_INTERACTABLE_SECTION}    //section[contains(@class, 'gameStart_container__')]
${MAIN_MENU_SELECTED_MONTH_XPATH}    ${MAIN_MENU_INTERACTABLE_SECTION}/section/span


*** Keywords ***
Wait For Main Menu To Load
    Helpers.Switch To Frame After It Loads    id:${GAME_CONTAINER_FRAME_ID}
        Wait Until Page Contains Element    xpath:${MAIN_MENU_SELECTED_MONTH_XPATH}
    Unselect Frame


Verify Calendar Header Displays Month And Year
    [Arguments]    ${month_name}    ${year}

    ${month_name}    Convert To Upper Case    ${month_name}
    VAR    ${expected_month_and_year_string}    ${month_name}    ${year}

    Helpers.Switch To Frame After It Loads    id:${GAME_CONTAINER_FRAME_ID}
        ${displayed_month_and_year_string}    Get Text
        ...                                   xpath:${MAIN_MENU_SELECTED_MONTH_XPATH}
    Unselect Frame

    Should Be Equal As Strings    ${expected_month_and_year_string}
    ...                           ${displayed_month_and_year_string}
