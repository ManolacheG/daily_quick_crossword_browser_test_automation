*** Settings ***
Library    String

Resource    ../Helpers.robot


*** Variables ***
# Locators
${GAME_CONTAINER_FRAME_ID}    canvas-box
${GAME_CONTAINER_FRAME_XPATH}    //iframe[@id='${GAME_CONTAINER_FRAME_ID}']

${MAIN_MENU_INTERACTABLE_SECTION}    //section[contains(@class, 'gameStart_container__')]
${MAIN_MENU_SELECTED_MONTH_XPATH}    ${MAIN_MENU_INTERACTABLE_SECTION}/section/span
${MAIN_MENU_CHANGE_MONTH_BUTTON_XPATH}    ${MAIN_MENU_INTERACTABLE_SECTION}/section/button[2]


*** Keywords ***
# Main menu Keywords.
Wait For Main Menu To Load
    Helpers.Switch To Frame After It Loads    id:${GAME_CONTAINER_FRAME_ID}
        Wait Until Page Contains Element    xpath:${MAIN_MENU_SELECTED_MONTH_XPATH}
    Unselect Frame


Switch Calendar To Previous Month
    Helpers.Switch To Frame After It Loads    id:${GAME_CONTAINER_FRAME_ID}
        ${initial_selected_month_text}    Get Text
        ...                               xpath:${MAIN_MENU_SELECTED_MONTH_XPATH}

        Helpers.Click Element After It Loads    ${MAIN_MENU_CHANGE_MONTH_BUTTON_XPATH}

        Wait Until Element Does Not Contain    xpath:${MAIN_MENU_SELECTED_MONTH_XPATH}
        ...                                    ${initial_selected_month_text}
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
