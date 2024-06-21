*** Settings ***
Documentation    All Keywords part of this file expect the game container iframe
...              to have been selected before they are called.

Resource    ../../Helpers.robot


*** Variables ***
# Locators
${GAME_SETTINGS_MENU_OPEN_BUTTON_XPATH}    //button[@data-tip='(Ctrl+M)']
${GAME_SETTINGS_MENU_CLOSE_BUTTON_XPATH}    //section[contains(@class, 'game_container__')]/section[3]/article/button

${GAME_SETTINGS_SKIP_FILLED_SQUARES_DATA_XPATH}    //input[@id='skip']
${GAME_SETTINGS_SKIP_FILLED_SQUARES_BUTTON_XPATH}    ${GAME_SETTINGS_SKIP_FILLED_SQUARES_DATA_XPATH}/../div
${GAME_SETTINGS_SKIP_NEXT_WORD_DATA_XPATH}    //input[@id='skipNextWord']
${GAME_SETTINGS_SKIP_NEXT_WORD_BUTTON_XPATH}    ${GAME_SETTINGS_SKIP_NEXT_WORD_DATA_XPATH}/../div
${GAME_SETTINGS_DISPLAY_CLUE_LIST_DATA_XPATH}    //input[@id='cluesDisplayList']
${GAME_SETTINGS_DISPLAY_CLUE_LIST_BUTTON_XPATH}    ${GAME_SETTINGS_DISPLAY_CLUE_LIST_DATA_XPATH}/../div

${GAME_PAUSE_OVERLAY_XPATH}    //div[contains(@class,'game_dropdownOverlay__')]


*** Keywords ***
Configure Game For Fast Completion
    Helpers.Click Element After It Loads    xpath:${GAME_SETTINGS_MENU_OPEN_BUTTON_XPATH}
    Wait Until Page Contains Element    xpath:${GAME_PAUSE_OVERLAY_XPATH}

    ${is_skip_over_filled_squares_enabled}    Is Element Checked
    ...                                       xpath:${GAME_SETTINGS_SKIP_FILLED_SQUARES_DATA_XPATH}
    IF  $is_skip_over_filled_squares_enabled
        Helpers.Click Element After It Loads    xpath:${GAME_SETTINGS_SKIP_FILLED_SQUARES_BUTTON_XPATH}
    END
    ${is_skip_next_word_enabled}    Is Element Checked
    ...                             xpath:${GAME_SETTINGS_SKIP_NEXT_WORD_DATA_XPATH}
    IF  $is_skip_next_word_enabled
        Helpers.Click Element After It Loads    xpath:${GAME_SETTINGS_SKIP_NEXT_WORD_BUTTON_XPATH}
    END
    ${is_display_clue_list_enabled}    Is Element Checked
    ...                                xpath:${GAME_SETTINGS_DISPLAY_CLUE_LIST_DATA_XPATH}
    IF  not $is_display_clue_list_enabled
        Helpers.Click Element After It Loads    xpath:${GAME_SETTINGS_DISPLAY_CLUE_LIST_BUTTON_XPATH}
    END

    Helpers.Click Element After It Loads    xpath:${GAME_SETTINGS_MENU_CLOSE_BUTTON_XPATH}
    Wait Until Page Does Not Contain Element    xpath:${GAME_PAUSE_OVERLAY_XPATH}
