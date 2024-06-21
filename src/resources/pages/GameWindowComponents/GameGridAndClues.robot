*** Settings ***
Documentation    All Keywords part of this file expect the game container iframe
...              to have been selected before they are called.

Library    String

Resource    ../../Helpers.robot


*** Variables ***
# Locators
${GAME_GRID_BASE_XPATH}    //section[contains(@class,'game_gridLayout__')]
${GAME_FOOTER_PUZZLE_INFO_XPATH}    //span[contains(@class,'game_inlinePuzzleInfo__')]

${GAME_CLUE_LISTS_COMMON_XPATH}    //section[contains(@class,'connectedCluePanel_cluePanel__')]
${GAME_CLUE_LIST_ACROSS_XPATH}    ${GAME_CLUE_LISTS_COMMON_XPATH}\[1\]/ul
${GAME_CLUE_LIST_ACROSS_ITEM_XPATH}    ${GAME_CLUE_LIST_ACROSS_XPATH}/li
${GAME_CLUE_LIST_DOWN_XPATH}    ${GAME_CLUE_LISTS_COMMON_XPATH}\[2\]/ul
${GAME_CLUE_LIST_DOWN_ITEM_XPATH}    ${GAME_CLUE_LIST_DOWN_XPATH}/li

${GAME_GRID_TABLE_XPATH}    //*[local-name()='g' and @role='table']
${GAME_GRID_TABLE_CELL_XPATH}    ${GAME_GRID_TABLE_XPATH}/*[local-name()='g']

# Other variables.
${GAME_SELECTED_SQUARE_COLOR}    rgb(255, 222, 113)


*** Keywords ***
Wait For Game To Be Ready
    Helpers.Wait For Element To Be Interactable    xpath:${GAME_GRID_BASE_XPATH}


Verify Game Footer Puzzle Date
    [Arguments]    ${expected_day}    ${expected_month_name}    ${expected_year}

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


Enter Solutions In Puzzle Grid To All Clues
    [Documentation]    @arg clues_with_solutions: a dictionary containing the keys
    ...                "across" and "down", each mapping to the corresponding
    ...                list of clues. Each clue is a dictionary with the keys
    ...                "id", "clue", "char_counts", and "solution", where each key
    ...                has assigned to it the expected string value.

    [Arguments]    ${clues_with_solutions}

    Fill In Entries For Clues In List    ${GAME_CLUE_LIST_ACROSS_ITEM_XPATH}
    ...                                  ${clues_with_solutions.across}
    Fill In Entries For Clues In List    ${GAME_CLUE_LIST_DOWN_ITEM_XPATH}
    ...                                  ${clues_with_solutions.down}

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

        VAR    ${clue_start_grid_cell}    ${GAME_GRID_TABLE_CELL_XPATH}/*[local-name()='text' and text()='${clue_dict.id}']
        ${clue_start_grid_cell_current_color}    Get Element Attribute
        ...                                      ${clue_start_grid_cell}/../*[local-name()='rect']
        ...                                      fill
        IF   $clue_start_grid_cell_current_color != $GAME_SELECTED_SQUARE_COLOR
            Helpers.Click Element After It Loads    ${clue_start_grid_cell}
        END

        Press Keys    None    ${clue_dict.solution}
    END
