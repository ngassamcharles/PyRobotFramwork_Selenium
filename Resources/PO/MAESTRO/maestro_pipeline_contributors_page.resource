*** Settings ***
Documentation  Maestro Planification home page - Project Robot Framework
...

Library    SeleniumLibrary
Resource   ../../common.robot

*** Variables ***
${CONTRIBUTOR_SEARCH_INPUT}     id:contributors-search-contributors-input
${CONTRIBUTOR_SAVE_BTN}         id:contributors-save-btn

*** Keywords ***
Select Contributor
    [Documentation]
    ...     Select contributor
    [Arguments]     ${contributor_label}
    Click Element    ${CONTRIBUTOR_SEARCH_INPUT}
    Input Text    ${CONTRIBUTOR_SEARCH_INPUT}    ${contributor_label}
    ${contributor}    Set Variable    xpath=//span[contains(text(),'${contributor_label}')]
    Click Element    ${contributor}

Save Contributors
    [Documentation]
    ...     Save contributors
    Wait Until Element Is Enabled    ${CONTRIBUTOR_SAVE_BTN}
    Click Element    ${CONTRIBUTOR_SAVE_BTN}

