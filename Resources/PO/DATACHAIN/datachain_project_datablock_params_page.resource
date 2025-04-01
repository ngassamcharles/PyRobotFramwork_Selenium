*** Settings ***
Documentation  Datachain project datablocks parameters page
...

Library    SeleniumLibrary
Resource   ../../common.robot

*** Variables ***
${LAUNCH_EXECUTION_BUTTON}      id:exec_datablock
${ADD_ELEMENT}                  id:addDbElements
${DELETE_BUTTON}                id:delete_btn
${SAVE_BUTTON}                  id:save_btn
${RETURN_BUTTON}                id:return_btn
${EXPOSITION_TAB}               id:expositionsTab
${EXPOSITION_LIST_NEW_BUTTON}   id:expositions-list-new-btn
${TASK}                         xpath=//i[@title='Tâches']
${DATABLOCK_OPTION_MENU}        id:datablock-option-menu
${DATABLOCK_OPTION_EXPORT}      id:exportDatablock


*** Keywords ***
Launch Datablock
    [Documentation]
    ...     Running a datablock
    Wait Until Element Is Visible    ${ADD_ELEMENT}     5
    Wait Until Element Is Visible    ${LAUNCH_EXECUTION_BUTTON}
    Click Element    ${LAUNCH_EXECUTION_BUTTON}
    Wait Until Keyword Succeeds    3 times    7s    Task Colors Is Green

Datablock Running Should Be Completed
    [Documentation]
    ...     Datablock running should be completed
    Wait Until Keyword Succeeds    10 times    7s    Task Colors Is White

Open Expositions Tab
    [Documentation]
    ...     Open expositions tab
    Wait Until Element Is Visible    ${EXPOSITION_TAB}
    Click Element    ${EXPOSITION_TAB}

Adding New Exposition
    [Documentation]
    ...     Adding new exposition
    Wait Until Element Is Visible    ${EXPOSITION_LIST_NEW_BUTTON}
    Click Button    ${EXPOSITION_LIST_NEW_BUTTON}

Task Colors Is Green
    [Documentation]
    ...     Task color should be green
    ${task_color}    Get Element Attribute    ${TASK}    style
    Should Contain    ${task_color}    rgb(78, 228, 0)

Task Colors Is White
    [Documentation]
    ...     Task color should be white
    ${task_color}    Get Element Attribute    ${TASK}    style
    Should Contain    ${task_color}    rgb(255, 255, 255)

Open Datablock Option Menu
    [Documentation]
    ...     Open datablock option menu to see or select all options for the datablock
    Wait Until Element Is Visible    ${DATABLOCK_OPTION_MENU}
    Click Element    ${DATABLOCK_OPTION_MENU}

Select Option Export Datablock
    [Documentation]
    ...     Export datablock by choose the option on the dropdown menu list
    Wait Until Element Is Visible    ${DATABLOCK_OPTION_EXPORT}
    Click Element    ${DATABLOCK_OPTION_EXPORT}