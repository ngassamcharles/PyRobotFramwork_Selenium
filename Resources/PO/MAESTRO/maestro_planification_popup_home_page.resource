*** Settings ***
Documentation  Maestro Planification home page - Project Robot Framework
...

Library    SeleniumLibrary
Resource   ../../common.robot

*** Variables ***
${PIPELINE_LABEL_INPUT}     id:pipeline-metadata-label-input
${PIPELINE_SAVE_BTN}        id:schedule-create-popup-save-btn


*** Keywords ***
Fill Label For Pipeline
    [Documentation]
    ...     Enter a label for the pipeline
    [Arguments]     ${pipeline_label}
    Wait Until Element Is Visible    ${PIPELINE_LABEL_INPUT}
    Input Text    ${PIPELINE_LABEL_INPUT}    ${pipeline_label}

Save Pipeline
    [Documentation]
    ...     Save label for the pipeline
    Wait Until Element Is Visible    ${PIPELINE_SAVE_BTN}
    Wait Until Element Is Enabled    ${PIPELINE_SAVE_BTN}
    Click Element    ${PIPELINE_SAVE_BTN}
