*** Settings ***
Documentation  Datachain project datablocks page
...

Library    SeleniumLibrary
Resource   ../../common.robot

*** Variables ***
${SEARCH_INPUT}                 xpath=//input[contains(@aria-label, 'Rechercher')]
${SPINNER}                      id:spinner
${EDIT_BUTTON}                  action-edit-btn
${REFRESH_DATABLOCK_BUTTON}     id:db-refresh


*** Keywords ***
Search Datablocks
    # TODO : Need to better implement the wait here.
    [Documentation]
    ...     Research a specific datablock
    [Arguments]     ${datablock_name}
    Wait Until Element Is Visible    ${SEARCH_INPUT}
    Input Text    ${SEARCH_INPUT}    ${datablock_name}
    Sleep    3s

Edit datablock
    [Documentation]
    ...     Select the data block that is the result of the search.
    Wait Until Element Is Not Visible    ${SPINNER}
    Click On Element Using Javascript By Id    ${EDIT_BUTTON}

