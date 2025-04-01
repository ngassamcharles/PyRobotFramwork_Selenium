*** Settings ***
Documentation  Authentification SSO page
...

Library    SeleniumLibrary
Resource   ../../common.robot

*** Variables ***
${USERNAMESSO}      id:idToken1
${PASSWORDSSO}      id:idToken2
${LOGINSSO}         id:loginButton_0


*** Keywords ***
Fill Username
    [Documentation]
        ...   User enter his username
    [Arguments]     ${username}
    Wait Until Element Is Visible    ${USERNAMESSO}
    Input Text    ${USERNAMESSO}    ${username}

Fill Password
    [Documentation]
        ...    User enter his password
    [Arguments]     ${password}
    Wait Until Element Is Visible    ${PASSWORDSSO}
    Input Text    ${PASSWORDSSO}    ${password}

Login sso
    [Documentation]
        ...    Login SSO
    Wait Until Element Is Visible    ${LOGINSSO}
    Click Element    ${LOGINSSO}