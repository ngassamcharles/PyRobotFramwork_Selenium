*** Settings ***
Documentation  Maestro home page - SSO authentification Gina Dev
...

Library    SeleniumLibrary
Resource   ../../common.robot

*** Variables ***
${INSTANCE_CARD}                            id:instance-card-elem
${CREATE_PLANIFICATION_SCHEDULE_BTN}        id:main-layout-create-schedule-btn
${SECURITY_CHECK_POPUP_PASSWORD_INPUT}      id:security-check-popup-password-input
${SECURITY_CHECK_POPUP_SUBMIT_BTN}          id:security-check-popup-submit-btn
${ROBOTFRAMEWORK_PROJECT_ITEM}              xpath=//div[contains(@id, 'project-card')]//div[contains(text(), 'Robot Framework') and contains(text(), '11026')]
${PIPELINE_REDIRECTION_BTN}                 id:main-layout-pipelines-redirection-btn

*** Keywords ***
Item Should Be Present
    [Documentation]
    ...     Item DEV should be present when user get connected
    Wait Until Keyword Succeeds    5 times    5s
    ...     Element Should Be Visible    ${INSTANCE_CARD}

Select Item
    [Documentation]
    ...     Select item
    Click Element    ${INSTANCE_CARD}

Create Planification
    [Documentation]
    ...     Click on button create planificatoin
    Element Should Be Visible    ${CREATE_PLANIFICATION_SCHEDULE_BTN}
    Click Element    ${CREATE_PLANIFICATION_SCHEDULE_BTN}

Entrer Password On PopUp Security Check
    [Documentation]
    ...     Entrer password on the popup security check
    [Arguments]     ${password}
    Element Should Be Visible    ${SECURITY_CHECK_POPUP_PASSWORD_INPUT}
    Element Should Be Disabled    ${SECURITY_CHECK_POPUP_SUBMIT_BTN}
    Input Text    ${SECURITY_CHECK_POPUP_PASSWORD_INPUT}    ${password}

Submit Password Security Check
    [Documentation]
    ...     Submit password security check
    Element Should Be Enabled    ${SECURITY_CHECK_POPUP_SUBMIT_BTN}
    Click Element    ${SECURITY_CHECK_POPUP_SUBMIT_BTN}

Choose Project Robot Framework
    [Documentation]
    ...     Choose project robot framework for scheduling a planification
    Wait Until Element Is Visible    ${ROBOTFRAMEWORK_PROJECT_ITEM}
    Click Element    ${ROBOTFRAMEWORK_PROJECT_ITEM}

Redirection To Main Pipeline Layout
    [Documentation]
    ...     Redirection to the main pipenline layout
    Wait Until Keyword Succeeds    3 times    4s    Wait Until Element Is Visible    ${PIPELINE_REDIRECTION_BTN}
    Wait Until Keyword Succeeds    3 times    4s    Click Element    ${PIPELINE_REDIRECTION_BTN}

Execute Pipeline
    [Documentation]
    ...     Execute the pipeline corresponding to the label passed as argument
    [Arguments]     ${pipeline_label}
    # Id is set here because it's dynamically generated with project label.
    ${execute_btn}    Set Variable    xpath=//*[@id='pipeline-table-${pipeline_label}-play-btn']
    Wait Until Keyword Succeeds    15 times    15s    Element Should Be Enabled    ${execute_btn}
    Click Element    ${execute_btn}

Pipeline Should Be Launched
    [Documentation]
    ...     Pipeline should be launched. This step would wait until running is completed.
    [Arguments]     ${pipeline_label}
    # Id is set here because it's dynamically generated with project label.
    ${stop_btn}    Set Variable    xpath=//*[@id='pipeline-table-${pipeline_label}-stop-btn']
    Element Should Be Enabled    ${stop_btn}
    Element Should Be Visible    ${stop_btn}
    ${execute_btn}    Set Variable    xpath=//*[@id='pipeline-table-${pipeline_label}-play-btn']
    Wait Until Keyword Succeeds    20 times    25s    Element Should Be Enabled    ${execute_btn}