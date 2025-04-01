*** Settings ***
Documentation  Datachain import project page
...

Library    SeleniumLibrary
Library    OperatingSystem
Library    Collections

Resource    ../../common.robot

*** Variables ***
${EXPORT_PROJECT_BTN}                           id:export-project-do
${EXPORT_FILE_NAME_INPUT}                       id:exportFileName
${USE_TEMPLATE_CHECKBOX}                        id:useTemplateExp
${COPY_INFORMATIONS_USER_CHECKBOX}              id:copyInformationsExp
${EXPORT_DATABLOCKS_CHECKBOX}                   id:export-datablock
${EXPORT_ENTITY_CHECKBOX}                       id:export-entity
${EXPORT_REPOSITORY_CHECKBOX}                   id:export-repository
${EXPORT_CONNECTOR_CHECKBOX}                    id:export-connector
${EXPORT_HANDLEDATA_EXPOSITION_CHECKBOX}        id:export-hdElements
${ACCEPT_CONDITIONS_CHECKBOX}                   id:export-accept-checkbox
${CONFIRM_EXPORT_MODAL_BTN}                     id:confirm-modale-btn8
${PROGESS_STATUS_BAR}                           id:progressBarStatus
${CANCEL_EXPORT_BTN}                            id:export-project-cancel
${DOWNLOAD_PROJECT_BTN}                         id:export-project-download
${EXPORT_EXPOSITION_DATABLOCKS}                 id:duplicate
${SELECT_ALL-ELEMENT_DATABLOCKS_EXPOSITION}     id:checkAll


*** Keywords ***
Fill File Name
    [Documentation]
    ...     Fill file name of the export file
    [Arguments]     ${file_name}
    Wait Until Keyword Succeeds    5 times    5s    Wait Until Element Is Visible    ${EXPORT_FILE_NAME_INPUT}
    Input Text    ${EXPORT_FILE_NAME_INPUT}    ${file_name}

Select Copy Project Template
    [Documentation]
    ...     Select if project template should be copied
    Click Element    ${USE_TEMPLATE_CHECKBOX}

Select Copy Users Informations
    [Documentation]
    ...     Select if users informations should be copied
    Click Element    ${COPY_INFORMATIONS_USER_CHECKBOX}

Select Handledata Element
    [Documentation]
    ...     Handledata should be selected according to the api exposition. This select wil automatically check Datablocks & Entity checkbox.
    Click Element    ${EXPORT_HANDLEDATA_EXPOSITION_CHECKBOX}
    Checkbox Should Be Selected    ${EXPORT_HANDLEDATA_EXPOSITION_CHECKBOX}
    Checkbox Should Be Selected    ${EXPORT_DATABLOCKS_CHECKBOX}
    Checkbox Should Be Selected    ${EXPORT_ENTITY_CHECKBOX}
    
Select Export Repository
    [Documentation]
    ...     Select if repository should be exported. By select this checkbox will also check connector checkbox.
    Click Element    ${EXPORT_REPOSITORY_CHECKBOX}
    Checkbox Should Be Selected    ${EXPORT_REPOSITORY_CHECKBOX}
    Checkbox Should Be Selected    ${EXPORT_CONNECTOR_CHECKBOX}

Select Datablocks Exposition
    [Documentation]
    ...     Select if datablocks exposition should be exported.
    Click Element    ${EXPORT_EXPOSITION_DATABLOCKS}

Select All Element Datablocks Exposition
    [Documentation]
    ...     Select all elements of datablocks exposition.
    Wait Until Element Is Visible    ${SELECT_ALL-ELEMENT_DATABLOCKS_EXPOSITION}
    Click Element    ${SELECT_ALL-ELEMENT_DATABLOCKS_EXPOSITION}

Accept Responsability Conditions
    [Documentation]
    ...     Accepts conditions of unique responsability.
    Click Element    ${ACCEPT_CONDITIONS_CHECKBOX}
    Checkbox Should Be Selected    ${ACCEPT_CONDITIONS_CHECKBOX}

Export Project
    [Documentation]
    ...     Export the project
    Element Should Be Enabled    ${EXPORT_PROJECT_BTN}
    Click Element    ${EXPORT_PROJECT_BTN}

Confirm Export
    [Documentation]
    ...     Confirm project export
    Click Element    ${CONFIRM_EXPORT_MODAL_BTN}

Export Should Be Completed
    [Documentation]
    ...     Export should be correctly completed and file can be downloaded
    [Arguments]     ${file_name}
    Element Should Be Visible    ${CANCEL_EXPORT_BTN}
    Empty Directory    ${OUTPUT_DIR}${/}download
    Wait Until Keyword Succeeds    10 times    20s    Progress Status Bar Should Be Completed
    Element Should Be Visible    ${DOWNLOAD_PROJECT_BTN}
    Click Element    ${DOWNLOAD_PROJECT_BTN}
    Wait For DCA File Download Complete    ${OUTPUT_DIR}${/}download    ${file_name}
    Wait Until Keyword Succeeds    2 times    10s    Check Download Files    ${file_name}


Wait For DCA File Download Complete
    [Arguments]     ${download_dir}     ${file_name}
    Wait Until Keyword Succeeds    3 times    10s
    ...     File Should Exist    ${download_dir}${/}${file_name}.dca

    ${temp_file}    Set Variable    ${file_name}.crdownload
    Wait Until Keyword Succeeds    3 times    10s
    ...     File Should Not Exist    ${download_dir}${/}${temp_file}

Check Download Files
    [Documentation]
    ...     Wait until progress status bar to be completed
    [Arguments]     ${label}
    ${files_name}     List Files In Directory    ${OUTPUT_DIR}${/}download
    Length Should Be    ${files_name}    1
    List Should Contain Value    ${files_name}    ${label}.dca

Progress Status Bar Should Be Completed
    [Documentation]
    ...     Wait until progress status bar to be completed
    ${percentage}    Get Element Attribute    ${PROGESS_STATUS_BAR}    aria-valuenow
    Should Be Equal As Strings    ${percentage}    100