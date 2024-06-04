*** Settings ***
Library    SeleniumLibrary


*** Variables ***
# The maximum number of seconds Selenium Keywords wait for an action to be completed.
${SELENIUM_TIMEOUT}    ${5}


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


# Keywords for elements that load asynchronously
Click Element After It Loads
    [Arguments]    ${locator}    ${modifier}=${False}    ${action_chain}=${False}

    Wait Until Page Contains Element    ${locator}
    Wait Until Element Is Visible    ${locator}
    Click Element    ${locator}    ${modifier}    ${action_chain}


Switch To Frame After It Loads
    [Arguments]    ${locator}

    Wait Until Page Contains Element    ${locator}
    Select Frame    ${locator}


# Javascript generators.
# Primarily used to build non-trivial conditions for the Keyword "Wait For Condition".
Get "Is Element Loaded" JavaScript
    [Arguments]    ${element_xpath}

    VAR    ${js}    document.evaluate("${element_xpath}", document, null, XPathResult.BOOLEAN_TYPE, null).booleanValue

    RETURN    ${js}
