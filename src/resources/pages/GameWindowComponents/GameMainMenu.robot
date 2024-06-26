*** Settings ***
Documentation    All Keywords part of this file expect the game container iframe
...              to have been selected before they are called.

Library    String

Resource    ../../Helpers.robot


*** Variables ***
# Locators
${MAIN_MENU_INTERACTABLE_SECTION}    //section[@data-testid='calendarCard']
${MAIN_MENU_SELECTED_MONTH_XPATH}    ${MAIN_MENU_INTERACTABLE_SECTION}/section/span
${MAIN_MENU_CHANGE_MONTH_BUTTON_XPATH}    ${MAIN_MENU_INTERACTABLE_SECTION}/section/button[2]
${MAIN_MENU_CALENDAR_DAY_BASE_XPATH}    ${MAIN_MENU_INTERACTABLE_SECTION}/ul/li


*** Keywords ***
Wait For Menu To Be Ready
    Wait Until Page Contains Element    xpath:${MAIN_MENU_SELECTED_MONTH_XPATH}


Start Puzzle From Currently Selected Month
    [Arguments]    ${day_number}

    Helpers.Click Element After It Loads    xpath:${MAIN_MENU_CALENDAR_DAY_BASE_XPATH}\[${day_number}\]


Get Currently Selected Month and Year From Calendar Header
    [Documentation]    @returns a dictionary containing the keys "month" and "year".

    ${displayed_month_year_as_string}    Get Text
    ...                                  xpath:${MAIN_MENU_SELECTED_MONTH_XPATH}
    @{displayed_month_year_as_list}    Split String
    ...                                ${displayed_month_year_as_string}
    VAR    &{displayed_month_year_as_dict}    month=${displayed_month_year_as_list}[0]
    ...                                       year=${displayed_month_year_as_list}[1]

    RETURN    ${displayed_month_year_as_dict}

Verify Calendar Header Displays Month And Year
    [Arguments]    ${month_name}    ${year}

    ${month_name}    Convert To Upper Case    ${month_name}
    VAR    ${expected_month_and_year_string}    ${month_name}    ${year}

    ${displayed_month_and_year_string}    Get Text
    ...                                   xpath:${MAIN_MENU_SELECTED_MONTH_XPATH}

    Should Be Equal As Strings    ${expected_month_and_year_string}
    ...                           ${displayed_month_and_year_string}


Switch Calendar Month
    ${initial_selected_month_text}    Get Text
    ...                               xpath:${MAIN_MENU_SELECTED_MONTH_XPATH}
    Helpers.Click Element After It Loads    xpath:${MAIN_MENU_CHANGE_MONTH_BUTTON_XPATH}
    Wait Until Element Does Not Contain    xpath:${MAIN_MENU_SELECTED_MONTH_XPATH}
    ...                                    ${initial_selected_month_text}
