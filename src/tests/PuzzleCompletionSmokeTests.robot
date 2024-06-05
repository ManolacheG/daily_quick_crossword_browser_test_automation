*** Settings ***
Resource    ../resources/pages/GamePage.robot
Resource    ../resources/pages/GameWindow.robot

Variables    ../test_data/PuzzleSolutions.json

Test Teardown    Helpers.Shutdown Browsers


*** Test Cases ***
Complete Puzzle From Previous Month Without Making Mistakes
    VAR    ${puzzle_dict}    ${28May2024-NoMistakes}

    GamePage.Open Browser At Daily Quick Crossword Game Page
    GamePage.Prepare Game Main Menu For Interaction

    GameWindow.Verify That Current Month Is Selected In Main Menu
    GameWindow.Start Puzzle    ${puzzle_dict.day}    ${puzzle_dict.month_name}    ${puzzle_dict.year}
    GameWindow.Complete Puzzle Without Mistakes    ${puzzle_dict.clues}

    GameWindow.Verify Results Screen Of Puzzle From Previous Month Completed Without Mistakes
    GameWindow.Take Screenshots Of Completed Puzzle
