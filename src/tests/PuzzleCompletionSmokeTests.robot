*** Settings ***
Resource    ../resources/pages/GamePage.robot

Variables    ../test_data/PuzzleSolutions.json

Test Teardown    Helpers.Shutdown Browsers


*** Test Cases ***
Complete Puzzle From Previous Month Without Making Mistakes
    VAR    ${puzzle_dict}    ${28May2024-NoMistakes}

    Open Browser At Daily Quick Crossword Game Page
    Prepare Game Main Menu For Interaction
    Verify That Current Month Is Selected In Main Menu
    Start Puzzle    ${puzzle_dict.day}    ${puzzle_dict.month_name}    ${puzzle_dict.year}
    Complete Puzzle Without Mistakes    ${puzzle_dict.clues}
    Verify Results Screen Of Puzzle From Previous Month Completed Without Mistakes

    Take Completed Puzzle State Screenshots
