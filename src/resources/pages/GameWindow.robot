*** Settings ***
Resource    ../Helpers.robot

Resource    GameWindowComponents/GameMainMenu.robot
Resource    GameWindowComponents/GameHud.robot
Resource    GameWindowComponents/GameGridAndClues.robot
Resource    GameWindowComponents/GameResults.robot


*** Variables ***
# Locators
${GAME_CONTAINER_FRAME_ID}    canvas-box
${GAME_CONTAINER_FRAME_XPATH}    //iframe[@id='${GAME_CONTAINER_FRAME_ID}']


*** Keywords ***
Wait For Main Menu To Load
    [Setup]    Select Game Container Frame

    GameMainMenu.Wait For Menu To Be Ready

    [Teardown]    Unselect Frame


Verify That Current Month Is Selected In Main Menu
    [Setup]    Select Game Container Frame

    ${current_month_year_dict}    Helpers.Get Current Month And Year In Local Time
    GameMainMenu.Verify Calendar Header Displays Month And Year
    ...          ${current_month_year_dict.month}    ${current_month_year_dict.year}

    [Teardown]    Unselect Frame


Start Puzzle
    [Arguments]    ${puzzle_day}    ${puzzle_month_name}    ${puzzle_year}

    [Setup]    Select Game Container Frame

    ${calendar_header_month_year}    GameMainMenu.Get Currently Selected Month and Year From Calendar Header
    IF  $puzzle_month_name.upper() != $calendar_header_month_year.month
        GameMainMenu.Switch Calendar Month

        ${calendar_header_month_year}    GameMainMenu.Get Currently Selected Month and Year From Calendar Header
        Should Be Equal As Strings    ${puzzle_month_name.upper()}
        ...                           ${calendar_header_month_year.month}
    END

    GameMainMenu.Start Puzzle From Currently Selected Month    ${puzzle_day}
    GameGridAndClues.Wait For Game To Be Ready

    GameGridAndClues.Verify Game Footer Puzzle Date    ${puzzle_day}
    ...                                                ${puzzle_month_name}
    ...                                                ${puzzle_year}

    [Teardown]    Unselect Frame


Complete Puzzle Without Mistakes
    [Arguments]    ${clues_with_solutions}

    [Setup]    Select Game Container Frame

    GameHud.Configure Game For Fast Completion
    GameGridAndClues.Enter Solutions In Puzzle Grid To All Clues    ${clues_with_solutions}

    [Teardown]    Unselect Frame


Verify Results Screen Of Puzzle From Previous Month Completed Without Mistakes
    [Setup]    Select Game Container Frame

    GameResults.Verify Results Screen Content    100%

    [Teardown]    Unselect Frame

Take Screenshots Of Completed Puzzle
    [Setup]    Select Game Container Frame

    GameResults.Take Completed Puzzle Screenshots

    [Teardown]    Unselect Frame


Select Game Container Frame
    [Tags]    robot:private

    Helpers.Switch To Frame After It Loads    id:${GAME_CONTAINER_FRAME_ID}
