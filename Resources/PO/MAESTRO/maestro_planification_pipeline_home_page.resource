*** Settings ***
Documentation  Maestro Planification home page - Project Robot Framework
...

Library    SeleniumLibrary
Resource   ../../common.robot

*** Variables ***
${PIPELINE_DETAILS_WORKFLOW_SAVE_BTN}                   id:pipeline-detail-workflow-save-btn-button
${PIPELINE_DETAILS_OPTIMIZER_BTN}                       id:pipeline-detail-pipeline-optimizer-btn-button
${PIPELINE_WORKFLOW_OPTIMIZER_CHANGE_STATE_BTN}         id:workflow-optimizer-change-state-btn
${PIPELINE_DETAILS_SETTINGS_TAB}                        id:pipeline-detail-settings-tab
${WORKFLOW_DETAILS_TAB}                                 xpath=//div[contains(text(),'Workflow')]
${PIPELINE_SETTINGS_CONTRIBUTORS_BTN}                   id:pipeline-settings-edit-contributors-btn

*** Keywords ***
Optimize Pipeline Details
    [Documentation]
    ...     Optimize pipeline details
    Wait Until Keyword Succeeds    3 times    4s    Wait Until Element Is Visible    ${PIPELINE_DETAILS_OPTIMIZER_BTN}
    Wait Until Keyword Succeeds    3 times    4s    Click Element    ${PIPELINE_DETAILS_OPTIMIZER_BTN}
    
Initiation Of Computations
    [Documentation]
    ...     Initiation of computation
    Wait Until Keyword Succeeds    3 times    4s    Wait Until Element Is Enabled    ${PIPELINE_WORKFLOW_OPTIMIZER_CHANGE_STATE_BTN}
    Click Element    ${PIPELINE_WORKFLOW_OPTIMIZER_CHANGE_STATE_BTN}
    Wait Until Keyword Succeeds    3 times    5s    Text Button Change    Voir le Workflow

Text Button Change
    [Documentation]
    ...     Text of the button change when click on it.
    [Arguments]     ${expected_label}
    Element Text Should Be    ${PIPELINE_WORKFLOW_OPTIMIZER_CHANGE_STATE_BTN}    ${expected_label}

See The New Workflow
    [Documentation]
    ...     See the new workflow
    Wait Until Element Is Enabled    ${PIPELINE_WORKFLOW_OPTIMIZER_CHANGE_STATE_BTN}
    Click Element    ${PIPELINE_WORKFLOW_OPTIMIZER_CHANGE_STATE_BTN}

Save Pipeline Details Workflow
    [Documentation]
    ...     Save all new details of the pipeline
    Wait Until Element Is Visible    ${PIPELINE_DETAILS_WORKFLOW_SAVE_BTN}
    Click Element    ${PIPELINE_DETAILS_WORKFLOW_SAVE_BTN}

Open Pipeline Details Settings Tab
    [Documentation]
    ...     Open Pipeline Details Settings Tab
    Wait Until Element Is Visible    ${PIPELINE_DETAILS_SETTINGS_TAB}
    Click Element    ${PIPELINE_DETAILS_SETTINGS_TAB}

Open Contributors Settings
    [Documentation]
    ...     Open contributors settings
    Wait Until Element Is Visible    ${PIPELINE_SETTINGS_CONTRIBUTORS_BTN}
    Click Element    ${PIPELINE_SETTINGS_CONTRIBUTORS_BTN}

Open Workflow Tab
    [Documentation]
    ...     Open workflow tab
    Wait Until Element Is Visible    ${WORKFLOW_DETAILS_TAB}
    Click Element    ${WORKFLOW_DETAILS_TAB}