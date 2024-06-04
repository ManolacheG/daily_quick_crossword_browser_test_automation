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
${MAIN_MENU_BASE_CALENDAR_DAY_XPATH}    ${MAIN_MENU_INTERACTABLE_SECTION}/ul/li

${GAME_GRID_BASE_XPATH}    //section[contains(@class,'game_gridLayout__')]
${GAME_FOOTER_PUZZLE_INFO}    //span[contains(@class,'game_inlinePuzzleInfo__')]


*** Keywords ***
# Frame-related Keywords.
Select Game Container Frame
    Helpers.Switch To Frame After It Loads    id:${GAME_CONTAINER_FRAME_ID}


# Main menu Keywords.
Wait For Main Menu To Load
    [Setup]    Select Game Container Frame

    Wait Until Page Contains Element    xpath:${MAIN_MENU_SELECTED_MONTH_XPATH}

    [Teardown]    Unselect Frame

Switch Calendar To Previous Month
    [Setup]    Select Game Container Frame

    ${initial_selected_month_text}    Get Text
    ...                               xpath:${MAIN_MENU_SELECTED_MONTH_XPATH}
    Helpers.Click Element After It Loads    xpath:${MAIN_MENU_CHANGE_MONTH_BUTTON_XPATH}
    Wait Until Element Does Not Contain    xpath:${MAIN_MENU_SELECTED_MONTH_XPATH}
    ...                                    ${initial_selected_month_text}

    [Teardown]    Unselect Frame

Verify Calendar Header Displays Month And Year
    [Arguments]    ${month_name}    ${year}

    [Setup]    Select Game Container Frame

    ${month_name}    Convert To Upper Case    ${month_name}
    VAR    ${expected_month_and_year_string}    ${month_name}    ${year}

    ${displayed_month_and_year_string}    Get Text
    ...                                   xpath:${MAIN_MENU_SELECTED_MONTH_XPATH}

    Should Be Equal As Strings    ${expected_month_and_year_string}
    ...                           ${displayed_month_and_year_string}

    [Teardown]    Unselect Frame

Get Currently Selected Month and Year From Calendar Header
     [Setup]    Select Game Container Frame

    ${displayed_month_year_as_string}    Get Text
    ...                                  xpath:${MAIN_MENU_SELECTED_MONTH_XPATH}
    @{displayed_month_year_as_list}    Split String
    ...                                ${displayed_month_year_as_string}
    VAR    &{displayed_month_year_as_dict}    month=${displayed_month_year_as_list}[0]
    ...                                       year=${displayed_month_year_as_list}[1]

    RETURN    ${displayed_month_year_as_dict}

    [Teardown]    Unselect Frame


Start Puzzle From Currently Selected Month
    [Arguments]    ${puzzle_day}

    [Setup]    Select Game Container Frame

    Helpers.Click Element After It Loads    xpath:${MAIN_MENU_BASE_CALENDAR_DAY_XPATH}\[${puzzle_day}\]
    Wait For Element To Be Interactable    xpath:${GAME_GRID_BASE_XPATH}

    [Teardown]    Unselect Frame


# In-game Keywords.
Verify Game Footer Puzzle Date
    [Arguments]    ${expected_day}    ${expected_month_name}    ${expected_year}

    [Setup]    Select Game Container Frame

    ${game_footer_puzzle_info_as_string}    Get Text
    ...                                     xpath:${GAME_FOOTER_PUZZLE_INFO}
    @{game_footer_puzzle_info_as_list}    Split String
    ...                                   ${game_footer_puzzle_info_as_string}

    VAR    ${game_footer_puzzle_info_day}    ${game_footer_puzzle_info_as_list}[3]
    VAR    ${game_footer_puzzle_info_month_name}    ${game_footer_puzzle_info_as_list}[4]
    VAR    ${game_footer_puzzle_info_year}    ${game_footer_puzzle_info_as_list}[5]
    ${game_footer_puzzle_info_year}    Get Substring    ${game_footer_puzzle_info_year}
    ...                                0    4

    Should Be Equal As Strings    ${expected_day}   ${game_footer_puzzle_info_day}
    Should Be Equal As Strings    ${expected_month_name}   ${game_footer_puzzle_info_month_name}
    Should Be Equal As Strings    ${expected_year}   ${game_footer_puzzle_info_year}

    [Teardown]    Unselect Frame
