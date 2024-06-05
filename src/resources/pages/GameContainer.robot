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

${GAME_CONTAINER_XPATH}    //section[contains(@class, 'game_container__')]

${GAME_HUD_SECTION_XPATH}    //section[contains(@class,'game_hud__')]
${GAME_SETTINGS_MENU_XPATH}    ${GAME_CONTAINER_XPATH}/section[3]/article
${GAME_SETTINGS_MENU_OPEN_BUTTON_XPATH}    ${GAME_HUD_SECTION_XPATH}/button[1]
${GAME_SETTINGS_MENU_CLOSE_BUTTON_XPATH}    ${GAME_SETTINGS_MENU_XPATH}/button
${GAME_SETTINGS_SKIP_FILLED_SQUARES_ELEM_XPATH}    ${GAME_SETTINGS_MENU_XPATH}/descendant::input[@id='skip']
${GAME_SETTINGS_SKIP_FILLED_SQUARES_BUTTON_XPATH}    ${GAME_SETTINGS_SKIP_FILLED_SQUARES_ELEM_XPATH}/../div
${GAME_SETTINGS_SKIP_NEXT_WORD_ELEM_XPATH}    ${GAME_SETTINGS_MENU_XPATH}/descendant::input[@id='skipNextWord']
${GAME_SETTINGS_SKIP_NEXT_WORD_BUTTON_XPATH}    ${GAME_SETTINGS_SKIP_NEXT_WORD_ELEM_XPATH}/../div

${GAME_GRID_BASE_XPATH}    //section[contains(@class,'game_gridLayout__')]
${GAME_FOOTER_PUZZLE_INFO_XPATH}    //span[contains(@class,'game_inlinePuzzleInfo__')]

${GAME_CLUE_LISTS_COMMON_XPATH}    //section[contains(@class,'connectedCluePanel_cluePanel__')]
${GAME_CLUE_LIST_ACROSS_XPATH}    ${GAME_CLUE_LISTS_COMMON_XPATH}\[1\]/ul
${GAME_CLUE_LIST_ACROSS_ITEM_XPATH}    ${GAME_CLUE_LIST_ACROSS_XPATH}/li
${GAME_CLUE_LIST_DOWN_XPATH}    ${GAME_CLUE_LISTS_COMMON_XPATH}\[2\]/ul
${GAME_CLUE_LIST_DOWN_ITEM_XPATH}    ${GAME_CLUE_LIST_DOWN_XPATH}/li

${GAME_GRID_TABLE}    //section[contains(@class,'game_gridLayout__')]/*[local-name()='svg']/*[local-name()='g']
${GAME_GRID_TABLE_CELL}    ${GAME_GRID_TABLE}/*[local-name()='g']

${GAME_DROPDOWN_OVERLAY_XPATH}    ${GAME_HUD_SECTION_XPATH}/../div[contains(@class,'game_dropdownOverlay__')]

# Other variables.
${GAME_SELECTED_SQUARE_COLOR}    rgb(255, 222, 113)


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
    ...                                     xpath:${GAME_FOOTER_PUZZLE_INFO_XPATH}
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


Configure Game For Fast Completion
    [Setup]    Select Game Container Frame

    Helpers.Click Element After It Loads    xpath:${GAME_SETTINGS_MENU_OPEN_BUTTON_XPATH}
    Wait Until Page Contains Element    xpath:${GAME_DROPDOWN_OVERLAY_XPATH}

    ${is_skip_over_filled_squares_enabled}    Is Element Checked
    ...                                       xpath:${GAME_SETTINGS_SKIP_FILLED_SQUARES_ELEM_XPATH}
    IF  $is_skip_over_filled_squares_enabled
        Helpers.Click Element After It Loads    xpath:${GAME_SETTINGS_SKIP_FILLED_SQUARES_BUTTON_XPATH}
    END
    ${is_skip_next_word_enabled}    Is Element Checked
    ...                             xpath:${GAME_SETTINGS_SKIP_NEXT_WORD_ELEM_XPATH}
    IF  $is_skip_next_word_enabled
        Helpers.Click Element After It Loads    xpath:${GAME_SETTINGS_SKIP_NEXT_WORD_BUTTON_XPATH}
    END

    Helpers.Click Element After It Loads    xpath:${GAME_SETTINGS_MENU_CLOSE_BUTTON_XPATH}
    Wait Until Page Does Not Contain Element    xpath:${GAME_DROPDOWN_OVERLAY_XPATH}

    [Teardown]    Unselect Frame

Fill In Puzzle Completely
    [Arguments]    ${clues_with_solutions}

    [Setup]    Select Game Container Frame

    Fill In Entries For Clues In List    ${GAME_CLUE_LIST_ACROSS_ITEM_XPATH}
    ...                                  ${clues_with_solutions.across}

    Fill In Entries For Clues In List    ${GAME_CLUE_LIST_DOWN_ITEM_XPATH}
    ...                                  ${clues_with_solutions.down}

    [Teardown]    Unselect Frame

Fill In Entries For Clues In List
    [Tags]    robot:private
    [Arguments]    ${clue_list_item_locator}    ${clues_with_solutions}

    ${expected_number_of_clues}    Get Length    ${clues_with_solutions}
    ${actual_number_of_clues}    Get Element Count    xpath:${clue_list_item_locator}
    Should Be Equal As Integers   ${actual_number_of_clues}
    ...                           ${expected_number_of_clues}

    FOR  ${index}  ${clue_dict}  IN ENUMERATE  @{clues_with_solutions}
        VAR    ${dom_index}    ${index + 1}
        VAR    ${current_clue_list_item_locator}    ${clue_list_item_locator}\[${dom_index}\]/section

        Helpers.Click Element After It Loads    ${current_clue_list_item_locator}
        Scroll Element Into View    ${current_clue_list_item_locator}

        ${actual_clue_id}    Get Text    xpath:${current_clue_list_item_locator}/strong/div
        ${full_clue_string}    Get Text    xpath:${current_clue_list_item_locator}/div
        ${actual_clue_string}    Fetch From Left    ${full_clue_string}    ${SPACE}(
        ${actual_clue_char_counts}    Fetch From Right    ${full_clue_string}    (
        ${actual_clue_char_counts}    Fetch From Left    ${actual_clue_char_counts}   )
        Should Be Equal As Strings    ${actual_clue_id}    ${clue_dict.id}
        Should Be Equal As Strings    ${actual_clue_string}    ${clue_dict.clue}
        Should Be Equal As Strings    ${actual_clue_char_counts}    ${clue_dict.char_counts}

        VAR    ${clue_start_grid_cell}    ${GAME_GRID_TABLE_CELL}/*[local-name()='text' and text()='${clue_dict.id}']
        ${clue_start_grid_cell_current_color}    Get Element Attribute
        ...                                      ${clue_start_grid_cell}/../*[local-name()='rect']
        ...                                      fill
        IF   $clue_start_grid_cell_current_color != $GAME_SELECTED_SQUARE_COLOR
            Helpers.Click Element After It Loads    ${clue_start_grid_cell}
        END

        Press Keys    None    ${clue_dict.solution}
    END
