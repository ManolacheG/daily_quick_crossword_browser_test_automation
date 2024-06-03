*** Settings ***
Library    SeleniumLibrary


*** Variables ***
# The maximum number of seconds Selenium Keywords wait for an action to be completed.
${SELENIUM_TIMEOUT}    ${10}


*** Keywords ***
# Browser-related Keywords.
Start Browser
    [Arguments]    ${browser}
    ...            ${inner_doc_width}    ${inner_doc_height}
    ...            ${url}=${NONE}

    Open Browser    browser=${browser}    url=${url}

    Set Window Size    ${inner_doc_width}    ${inner_doc_height}    ${TRUE}
    Set Window Position    ${0}    ${0}

    Set Selenium Timeout    ${SELENIUM_TIMEOUT}

Shutdown Browsers
    Close All Browsers
