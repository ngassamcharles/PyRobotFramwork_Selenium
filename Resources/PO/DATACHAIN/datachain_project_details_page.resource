*** Settings ***
Documentation  Datachain project detail page
...

Library    SeleniumLibrary
Resource   ../../common.robot

*** Variables ***
${BTN_PROJECT_PARAMS}       id:home-parameter-btn
${MENU_ACCEUIL}             id:menu-accueil





*** Keywords ***
Open Project Parameters
    [Documentation]
    ...     Open project parameters
    Wait Until Element Is Visible    ${BTN_PROJECT_PARAMS}
    Click Element    ${BTN_PROJECT_PARAMS}

Menu Acceuil Should Be Present
    [Documentation]
    ...     return true if element Menu is present and visible
    Wait Until Element Is Visible    ${MENU_ACCEUIL}
    ${is_present} =  Run Keyword And Return Status    Element Should Be Visible    ${MENU_ACCEUIL}
    Should Be True    ${is_present}