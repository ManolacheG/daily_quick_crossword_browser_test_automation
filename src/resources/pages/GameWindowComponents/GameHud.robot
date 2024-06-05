*** Settings ***
Resource    ../../Helpers.robot


*** Variables ***
# Locators
${GAME_HUD_SECTION_XPATH}    //section[contains(@class,'game_hud__')]
${GAME_SETTINGS_MENU_XPATH}    //section[contains(@class, 'game_container__')]/section[3]/article
${GAME_SETTINGS_MENU_OPEN_BUTTON_XPATH}    ${GAME_HUD_SECTION_XPATH}/button[1]
${GAME_SETTINGS_MENU_CLOSE_BUTTON_XPATH}    ${GAME_SETTINGS_MENU_XPATH}/button
${GAME_SETTINGS_SKIP_FILLED_SQUARES_ELEM_XPATH}    ${GAME_SETTINGS_MENU_XPATH}/descendant::input[@id='skip']
${GAME_SETTINGS_SKIP_FILLED_SQUARES_BUTTON_XPATH}    ${GAME_SETTINGS_SKIP_FILLED_SQUARES_ELEM_XPATH}/../div
${GAME_SETTINGS_SKIP_NEXT_WORD_ELEM_XPATH}    ${GAME_SETTINGS_MENU_XPATH}/descendant::input[@id='skipNextWord']
${GAME_SETTINGS_SKIP_NEXT_WORD_BUTTON_XPATH}    ${GAME_SETTINGS_SKIP_NEXT_WORD_ELEM_XPATH}/../div
${GAME_SETTINGS_DISPLAY_CLUE_LIST_ELEM_XPATH}    ${GAME_SETTINGS_MENU_XPATH}/descendant::input[@id='cluesDisplayList']
${GAME_SETTINGS_DISPLAY_CLUE_LIST_BUTTON_XPATH}    ${GAME_SETTINGS_DISPLAY_CLUE_LIST_ELEM_XPATH}/../div

${GAME_DROPDOWN_OVERLAY_XPATH}    ${GAME_HUD_SECTION_XPATH}/../div[contains(@class,'game_dropdownOverlay__')]


*** Keywords ***
Configure Game For Fast Completion
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
    ${is_display_clue_list_enabled}    Is Element Checked
    ...                                xpath:${GAME_SETTINGS_DISPLAY_CLUE_LIST_ELEM_XPATH}
    IF  not $is_display_clue_list_enabled
        Helpers.Click Element After It Loads    xpath:${GAME_SETTINGS_DISPLAY_CLUE_LIST_BUTTON_XPATH}
    END

    Helpers.Click Element After It Loads    xpath:${GAME_SETTINGS_MENU_CLOSE_BUTTON_XPATH}
    Wait Until Page Does Not Contain Element    xpath:${GAME_DROPDOWN_OVERLAY_XPATH}
