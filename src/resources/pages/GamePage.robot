*** Settings ***
Resource    ../Helpers.robot
Resource    ../ExternalVariables.robot
Resource    GameContainer.robot


*** Variables ***
# Locators
${COOKIE_DIALOG_ID}    qc-cmp2-ui
${COOKIE_DIALOG_XPATH}    //div[@id='${COOKIE_DIALOG_ID}']
${COOKIE_DIALOG_GENERIC_BUTTON_XPATH}    ${COOKIE_DIALOG_XPATH}/descendant::div[contains(@class,'qc-cmp2-summary-buttons')]/button
${COOKIE_DIALOG_AGREE_BUTTON_XPATH}    ${COOKIE_DIALOG_GENERIC_BUTTON_XPATH}/span[text()='AGREE']/..

${PREROLL_CONTAINER_FRAME_XPATH}    //div[@id='ark_pre-roll']/descendant::iframe
${COMMON_GOOGLE_ADS_FRAME_XPATH}    //iframe[starts-with(@id, 'google_ads_iframe')]
${COMMON_GOOGLE_ADS_NESTED_FRAME_XPATH}    //iframe[@id='ad_iframe']
${PREROLL_CONTAINER_DISMISS_AD_BUTTON_ID}    dismiss-button


*** Keywords ***
Open Browser At Daily Quick Crossword Game Page
    Helpers.Start Browser    ${BROWSER}    ${DQC_GAME_URL}


Prepare Game Main Menu For Interaction
    Wait For Page To Become Interactable
    Close Dialogs Blocking Game Container

    GameContainer.Wait For Main Menu To Load

Verify That Current Month Is Selected In Main Menu
    ${current_month_year_dict}    Get Current Month And Year In Local Time
    GameContainer.Verify Calendar Header Displays Month And Year
    ...    ${current_month_year_dict.month}    ${current_month_year_dict.year}

Start Puzzle
    [Arguments]    ${puzzle_day}    ${puzzle_month_name}    ${puzzle_year}

    ${calendar_header_month_year}    GameContainer.Get Currently Selected Month and Year From Calendar Header
    IF  $puzzle_month_name.upper() != $calendar_header_month_year.month
        GameContainer.Switch Calendar To Previous Month
    END
    GameContainer.Start Puzzle From Currently Selected Month    ${puzzle_day}
    GameContainer.Verify Game Footer Puzzle Date    ${puzzle_day}    ${puzzle_month_name}
    ...                                             ${puzzle_year}

Complete Puzzle Without Mistakes
    [Arguments]    ${clues_with_solutions}

    GameContainer.Configure Game For Fast Completion
    GameContainer.Fill In Puzzle Completely    ${clues_with_solutions}

Verify Results Screen Of Puzzle From Previous Month Completed Without Mistakes
    Verify Results Screen Content    100%

Wait For Page To Become Interactable
    ${cookie_dialog_loaded_cond}    Helpers.Get "Is Element Loaded" Javascript
    ...                             ${COOKIE_DIALOG_XPATH}
    ${preroll_container_frame_loaded_cond}    Helpers.Get "Is Element Loaded" Javascript
    ...                                       ${PREROLL_CONTAINER_FRAME_XPATH}
    ${game_container_frame_loaded_cond}    Helpers.Get "Is Element Loaded" Javascript
    ...                                    ${GAME_CONTAINER_FRAME_XPATH}

    Wait For Condition    return ${cookie_dialog_loaded_cond} || ${preroll_container_frame_loaded_cond} || ${game_container_frame_loaded_cond}


Close Dialogs Blocking Game Container
    ${is_cookie_policy_dialog_displayed}    Get Element Count    id:${COOKIE_DIALOG_ID}
    IF  $is_cookie_policy_dialog_displayed
        Agree To Cookie Policy
    END

    ${is_preroll_container_frame_displayed}    Get Element Count    xpath:${PREROLL_CONTAINER_FRAME_XPATH}
    IF  $is_preroll_container_frame_displayed
        # On some occasions the preroll ad container frame is removed from the DOM after
        # the cookie policy is dismissed, so try to close the preroll ad if it exists,
        # and attempt to continue if it does not exist.
        TRY
            Helpers.Switch To Frame After It Loads    xpath:${PREROLL_CONTAINER_FRAME_XPATH}
            Helpers.Switch To Frame After It Loads    xpath:${COMMON_GOOGLE_ADS_FRAME_XPATH}
                ${is_ad_dismiss_button_in_current_frame}    Get Element Count
                ...                                         id:${PREROLL_CONTAINER_DISMISS_AD_BUTTON_ID}
                IF  not $is_ad_dismiss_button_in_current_frame
                    Helpers.Switch To Frame After It Loads    xpath:${COMMON_GOOGLE_ADS_NESTED_FRAME_XPATH}
                END
                Helpers.Click Element After It Loads    id:${PREROLL_CONTAINER_DISMISS_AD_BUTTON_ID}
            Unselect Frame
        EXCEPT
            Unselect Frame
        END
    END


Agree To Cookie Policy
    Helpers.Click Element After It Loads    ${COOKIE_DIALOG_AGREE_BUTTON_XPATH}
