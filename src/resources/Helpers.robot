*** Settings ***
Library    String
Library    DateTime
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
Wait For Element To Be Interactable
    [Arguments]    ${locator}

    Wait Until Page Contains Element    ${locator}
    Wait Until Element Is Visible    ${locator}

Click Element After It Loads
    [Arguments]    ${locator}    ${modifier}=${False}    ${action_chain}=${False}

    Wait For Element To Be Interactable    ${locator}
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

# Javascript actions.
Is Element Checked
    [Documentation]    This Keyword is intended to be used with elements for which
    ...                the attributes do not change when they are selected.

    [Arguments]    ${locator}

    ${element}    Get WebElement    ${locator}
    ${js_query_result}    Execute Javascript    return arguments[0].checked
    ...                   ARGUMENTS    ${element}

    ${is_checked}    Set Variable    ${FALSE}
    IF  $js_query_result == $TRUE
        ${is_checked}    Set Variable    ${TRUE}
    END

    RETURN    ${is_checked}


# Date and time operations.
Get Current Month And Year In Local Time
    ${month_year_as_string}    Get Current Date    result_format=%B %Y    exclude_millis=True
    @{month_year_as_list}    Split String    ${month_year_as_string}

    VAR    &{month_year_as_dict}    month=${month_year_as_list}[0]    year=${month_year_as_list}[1]

    RETURN    ${month_year_as_dict}
