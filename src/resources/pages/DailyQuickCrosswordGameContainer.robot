*** Settings ***
Resource    ../Helpers.robot


*** Variables ***
# Locators
${GAME_CONTAINER_FRAME_ID}    canvas-box
${GAME_CONTAINER_FRAME_XPATH}    //iframe[@id='${GAME_CONTAINER_FRAME_ID}']

${MAIN_MENU_GAME_LOGO_XPATH}    //img[contains(@class,'gameStart_gameLogo__')]


*** Keywords ***
Wait For Main Menu To Load
    Helpers.Switch To Frame After It Loads    id:${GAME_CONTAINER_FRAME_ID}
        Wait Until Page Contains Element    xpath:${MAIN_MENU_GAME_LOGO_XPATH}
    Unselect Frame
