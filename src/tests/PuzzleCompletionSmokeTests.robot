*** Settings ***
Resource    ../resources/pages/DailyQuickCrosswordGamePage.robot

Test Teardown    Helpers.Shutdown Browsers


*** Test Cases ***
Complete Puzzle From Previous Month Without Making Mistakes
    Open Browser At Daily Quick Crossword Game Page
    Prepare Game Main Menu For Interaction
    Verify That Current Month Is Selected In Main Menu
