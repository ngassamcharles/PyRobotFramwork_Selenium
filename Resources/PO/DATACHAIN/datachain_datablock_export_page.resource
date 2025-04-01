*** Settings ***
Documentation  Datachain project datablocks page
...

Library    SeleniumLibrary
Resource   ../../common.robot

*** Variables ***
${EXPORT_DATABLOCK_BTN}             id:export-template-modal-export-btn
${CONNECTOR_TYPE_LOCAL}             xpath=//*[contains(@id, "mat-select")]//span[contains(text(), "Local")]
${EXPORT_PATH_INPUT}                id:export-template-path-selection-input
${SUCCESS_IMPORT_DIV}               xpath=//div[contains(text(), "Succès")]


*** Keywords ***
Select Local Connector
    [Documentation]
    ...     Select the dropdwon list of all connector available
    Wait Until Element Is Visible    ${CONNECTOR_TYPE_LOCAL}
    Click Element    ${CONNECTOR_TYPE_LOCAL}

Select New Connector
    [Documentation]
    ...     Select SFTP on the list of connector
    [Arguments]     ${connector_label}
    ${connector}    Set Variable    //span[contains(text(), "${connector_label}")]
    Wait Until Element Is Visible    ${connector}
    Click Element    ${connector}

Fill Path For Export
    [Documentation]
    ...     Fill the path for export the datablock
    [Arguments]     ${path_text}
    Wait Until Element Is Visible    ${EXPORT_PATH_INPUT}
    Click Element    ${EXPORT_PATH_INPUT}
    Wait Until Keyword Succeeds    2 times    3s    Input Text    ${EXPORT_PATH_INPUT}    ${path_text}

Export Datablock
    [Documentation]
    ...     CLick on export the datablock
    Wait Until Element Is Visible    ${EXPORT_DATABLOCK_BTN}
    Click Element    ${EXPORT_DATABLOCK_BTN}

Datablock Export Should Be Completed
    [Documentation]
    ...     Datablock export should be completed with success message (div)
    Wait Until Keyword Succeeds    4 times    5s    Element Should Be Visible    ${SUCCESS_IMPORT_DIV}