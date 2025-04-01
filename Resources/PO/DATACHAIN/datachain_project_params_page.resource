*** Settings ***
Documentation  Datachain project parameter page
...

Library    SeleniumLibrary
Library    Collections
Resource   ../../common.robot

*** Variables ***
${BTN_SAVE}                     id:save_btn
${PROJECT_DIV}                  id:projects_div
${CONTEXT_TAB}                  xpath=//md-tab-item[@role='tab']//span[normalize-space()='Contextes']
${USER_TAB}                     xpath=//md-tab-item[@role='tab']//span[normalize-space()='Utilisateurs/Groupes']
${PROJECT_BURGER_BTN}           id:project-burger-menu
${DUPLICATE_PROJECT_BTN}        id:duplicate_project
${EXPORT_PROJECT_MENU_SELECT}   id:export_project


*** Keywords ***
Save Button Should Be Present
    [Documentation]
    ...     return true if button save is present and visible
    Wait Until Element Is Visible    ${BTN_SAVE}
    ${is_present} =  Run Keyword And Return Status    Element Should Be Visible    ${BTN_SAVE}
    Should Be True    ${is_present}
    
Project Div Should Be Present
    [Documentation]
    ...     return true if project div is present and visible
    Wait Until Element Is Visible    ${PROJECT_DIV}
    ${is_present} =  Run Keyword And Return Status    Element Should Be Visible    ${PROJECT_DIV}
    Should Be True    ${is_present}
    
Open Context Tab
    [Documentation]
    ...     Open the context tab of the project params
    Wait Until Element Is Visible    ${CONTEXT_TAB}
    Click Element    ${CONTEXT_TAB}

Open Users Groups Tab
    [Documentation]
    ...     Open the users/groups tab of the project params
    Wait Until Element Is Visible    ${USER_TAB}
    Click Element    ${USER_TAB}

Open Burger Menu
    [Documentation]
    ...     Open burger menu of the project params
    Wait Until Element Is Visible    ${PROJECT_BURGER_BTN}
    Click Element    ${PROJECT_BURGER_BTN}

Select Export Project
    [Documentation]
    ...     Export project
    Wait Until Element Is Visible    ${EXPORT_PROJECT_MENU_SELECT}
    Click Element    ${EXPORT_PROJECT_MENU_SELECT}


