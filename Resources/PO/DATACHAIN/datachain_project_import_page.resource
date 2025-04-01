*** Settings ***
Documentation  Datachain import project page
...

Library    SeleniumLibrary
Library    DateTime
Resource   ../../common.robot


*** Variables ***
${CHOOSE_PROJECT_FILE_BTN}                  xpath=//*[@id='localFileDropZone']/following-sibling::button/translate
${CHOOSE_PROJECT_FILE_INPUT}                id:localFileDropZone
${PROGESS_STATUS_BAR}                       id:progressBarStatus
${IMPORT_PROJECT_LABEL_INPUT}               id:importedProjectLabel
${IMPORT_CONTEXT_PERSIST_SWITCH}            xpath=(//*[@id='context-persist-switch'])
${IMPORT_CONTEXT_OTHER_SWITCH}              xpath=(//*[@id='context-other-switch'])
${COPY_TEMPLATE_FOR_IMPORT_CHECKBOX}        id:copyTemplate
${ELEMENT_HANDLEDATA_IMPORT_CHECKBOX}       id:-hdElements
${DATABLOCKS_IMPORT_CHECKBOX}               id:-datablock
${ENTITY_IMPORT_CHECKBOX}                   id:-entity
${REPOSITORY_IMPORT_CHECKBOX}               id:-repository
${CONNECTOR_IMPORT_CHECKBOX}                id:-connector
${ROOT_CODE_FOR_EXPOSITION}                 id:root-code
${IMPORT_PROJECT_CREATE_CONFIGURATION}      id:import-project-configuration-create-after-mapping
${IMPORT_PROJECT_NEXT_STEP}                 id:import-project-consumers-mapping-step
${CANCEL_IMPORT_PROJECT_BTN}                id:import-project-cancel
${GO_TO_IMPORT_PROJECT_BTN}                 id:import-project-go-to
${USER_GROUP_SOURCE_IMPORT}                 id:consumer-mapping-0-target-select
${GROUP_USER_IMPORT_1_SPAN}                 xpath=(//*[@id='import-member-select']//span[@role='button'])[1]
${GROUP_USER_IMPORT_1_INPUT}                xpath=(//*[@id='import-member-select']//input[@type='search'])[1]
${GROUP_USER_IMPORT_2_SPAN}                 xpath=(//*[@id='import-member-select']//span[@role='button'])[2]
${GROUP_USER_IMPORT_2_INPUT}                xpath=(//*[@id='import-member-select']//input[@type='search'])[2]
${GROUP_USER_IMPORT_3_SPAN}                 xpath=(//*[@id='import-member-select']//span[@role='button'])[3]
${GROUP_USER_IMPORT_3_INPUT}                xpath=(//*[@id='import-member-select']//input[@type='search'])[3]


*** Keywords ***
Choose Project File
    [Documentation]
    ...     Choose the project .dca file to import.
    [Arguments]     ${file_name}
    Wait Until Element Is Visible    ${CHOOSE_PROJECT_FILE_BTN}
    Choose File    ${CHOOSE_PROJECT_FILE_INPUT}    ${OUTPUT_DIR}/download/${file_name}.dca
    Wait Until Element Is Not Visible    ${PROGESS_STATUS_BAR}

Enter Import Project Label
    [Documentation]
    ...     Enter project label for import
    [Arguments]     ${label}
    Wait Until Element Is Visible   ${IMPORT_PROJECT_LABEL_INPUT}
    Input Text    ${IMPORT_PROJECT_LABEL_INPUT}    COPIE-${label}

Enable Context Persist
    [Documentation]
    ...     Enable context persist for import
    [Arguments]     ${index}
    ${context}    Set Variable   ${IMPORT_CONTEXT_PERSIST_SWITCH} [${index}]
    Wait Until Element Is Visible   ${context}
    Click Element    ${context}

Enable Context Other
    [Documentation]
    ...     Enable context other for import
    [Arguments]     ${index}
    ${context}    Set Variable   ${IMPORT_CONTEXT_OTHER_SWITCH} [${index}]
    Wait Until Element Is Visible   ${context}
    Click Element    ${context}

Copy Template On Import
    [Documentation]
    ...     Copy template of the project
    Wait Until Element Is Visible   ${COPY_TEMPLATE_FOR_IMPORT_CHECKBOX}
    Click Element    ${COPY_TEMPLATE_FOR_IMPORT_CHECKBOX}

Select Element Handle Data Import
    [Documentation]
    ...     Handledata should be selected according to the api exposition. This select wil automatically check Datablocks & Entity checkbox.
    Click Element    ${ELEMENT_HANDLEDATA_IMPORT_CHECKBOX}
    Checkbox Should Be Selected    ${ELEMENT_HANDLEDATA_IMPORT_CHECKBOX}
    Checkbox Should Be Selected    ${DATABLOCKS_IMPORT_CHECKBOX}
    Checkbox Should Be Selected    ${ENTITY_IMPORT_CHECKBOX}

Select Repository Import
    [Documentation]
    ...     Select if repository should be exported. By select this checkbox will also check connector checkbox.
    Click Element    ${REPOSITORY_IMPORT_CHECKBOX}
    Checkbox Should Be Selected    ${REPOSITORY_IMPORT_CHECKBOX}
    Checkbox Should Be Selected    ${CONNECTOR_IMPORT_CHECKBOX}

Select Users Admin Group Import
    [Documentation]
    ...     Select user admin groups to import
    [Arguments]     ${user}
    Click Element    ${GROUP_USER_IMPORT_1_SPAN}
    Input Text    ${GROUP_USER_IMPORT_1_INPUT}    ${user}
    ${user_group}    Set Variable    xpath=//span[contains(text(),'${user}')]
    Wait Until Keyword Succeeds    3 times    10s   Click Element    ${user_group}

Select User Devflux Group Import
    [Documentation]
    ...     Select user 11026-RBF-H-DEVFLUX groups to import
    [Arguments]     ${user}
    Click Element    ${GROUP_USER_IMPORT_2_SPAN}
    Input Text    ${GROUP_USER_IMPORT_2_INPUT}    ${user}
    ${user_group}    Set Variable    xpath=//span[contains(text(),'${user}')]
    Wait Until Keyword Succeeds    3 times    10s   Click Element    ${user_group}

Select User Viewer Group Import
    [Documentation]
    ...     Select user 11026-RBF-H-VIEWER groups to import
    [Arguments]     ${user}
    Click Element    ${GROUP_USER_IMPORT_3_SPAN}
    Input Text    ${GROUP_USER_IMPORT_3_INPUT}    ${user}
    ${user_group}    Set Variable    xpath=//span[contains(text(),'${user}')]
    Wait Until Keyword Succeeds    3 times    10s   Click Element    ${user_group}

Enter Root Code For Exposition
    [Documentation]
    ...     Enter root code for expositions
    [Arguments]     ${code}
    ${current_time}     Get Current Date    result_format=%H%M
    Wait Until Element Is Visible    ${ROOT_CODE_FOR_EXPOSITION}
    Input Text    ${ROOT_CODE_FOR_EXPOSITION}    copie_${current_time}_${code}

Go To Next Import Page
    [Documentation]
    ...     Once we have element handledate (expositions) we have to go to another step
    Wait Until Element Is Visible    ${IMPORT_PROJECT_NEXT_STEP}
    Click Element    ${IMPORT_PROJECT_NEXT_STEP}

Select User Group Source
    [Documentation]
    ...     Select user group source
    [Arguments]     ${group_label}
    Click Element    ${USER_GROUP_SOURCE_IMPORT}
    ${group}    Set Variable    xpath=//div[@id='consumer-mapping-0-target-select-panel']//span[contains(text(),'${group_label}')]
    Click Element    ${group}

Create Import Project
    [Documentation]
    ...     Create project import configuration
    Wait Until Element Is Enabled    ${IMPORT_PROJECT_CREATE_CONFIGURATION}
    Click Element    ${IMPORT_PROJECT_CREATE_CONFIGURATION}

Project Should Be Created
    [Documentation]
    ...     Export should be correctly completed and file can be downloaded
    Element Should Be Visible      ${CANCEL_IMPORT_PROJECT_BTN}
    Wait Until Keyword Succeeds    20 times    55s    Project Should Be Imported


Project Should Be Imported
    [Documentation]
    ...     Wait until progress status bar is completed and button go to is visible & enabled.
    ${percentage}    Get Element Attribute    ${PROGESS_STATUS_BAR}    aria-valuenow
    Should Be Equal As Strings    ${percentage}    100
    Click Element    ${GO_TO_IMPORT_PROJECT_BTN}