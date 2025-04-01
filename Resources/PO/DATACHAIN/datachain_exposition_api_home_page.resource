*** Settings ***
Documentation  Exposition api management page
...

Library    SeleniumLibrary
Resource   ../../common.robot

*** Variables ***
${EXPOSITION_ACTION_MENU}                       xpath=//*[contains(@id,'expositions-list') and contains(@id,'actions-menu-btn')]
${EXPOSITION_ACTION_DELETE_BUTTON}              xpath=//*[contains(@id,'delete-btn')]
${EXPOSITION_ACTION_CONFIRM_DELETE_CHECKBOX}    exposition-confirm-confirm-delete-checkbox-input
${EXPOSITION_ACTION_CONFIRM_DELETE_BUTTON}      id:exposition-confirm-delete-btn
${TOAST_CONTAINER}                              id:toast-container


*** Keywords ***
Access Point Should Be Present
    [Documentation]
    ...     Check if exposition with the correct access point is visible
    [Arguments]  ${access_point}
    ${access_point_label}   Set Variable    xpath=//h6[normalize-space()='${access_point}']
    Wait Until Keyword Succeeds    3    10s    Element Should Be Visible    ${access_point_label}

Datablock Source Should Be Present
    [Documentation]
    ...     Check if exposition with the correct datablock source is visible
    [Arguments]  ${datablock_source}
    ${datablock_source_label}   Set Variable    xpath=//span[normalize-space()='${datablock_source}']
    Wait Until Keyword Succeeds    3 times    5s    Element Should Be Visible    ${datablock_source_label}
        
Open Exposition Actions
    [Documentation]
    ...     Open exposition actions
    [Arguments]  ${access_point}
    ${access_point_label}   Set Variable    xpath=//h6[normalize-space()='${access_point}']
    Mouse Over    ${access_point_label}
    ${elements}     Get WebElements    ${EXPOSITION_ACTION_MENU}
    FOR    ${element}    IN    @{elements}
        ${is_visible}   Run Keyword And Return Status    Element Should Be Visible    ${element}
        IF    ${is_visible}
            Click Element    ${element}
            Exit For Loop
        END
    END

Delete Exposition
    [Documentation]
    ...     Delete exposition
    Wait Until Keyword Succeeds    3 times    5s    Element Should Be Visible  ${EXPOSITION_ACTION_DELETE_BUTTON}
    Click Element    ${EXPOSITION_ACTION_DELETE_BUTTON}

Confirm Checkbox Delete Exposition
    [Documentation]
    ...     Confirm chehckbox Delete exposition
    Wait Until Keyword Succeeds    3 times    5s    Click On Element Using Javascript By Id    ${EXPOSITION_ACTION_CONFIRM_DELETE_CHECKBOX}

Confirm Delete Exposition
    [Documentation]
    ...     Confirm Delete exposition
    Wait Until Element Is Enabled    ${EXPOSITION_ACTION_CONFIRM_DELETE_BUTTON}
    Wait Until Keyword Succeeds    3 times    5s    Click Element    ${EXPOSITION_ACTION_CONFIRM_DELETE_BUTTON}

Exposition Should Be Deleted
    [Documentation]
    ...     Toast confirmation should be visible.
    Wait Until Element Is Visible    ${TOAST_CONTAINER}