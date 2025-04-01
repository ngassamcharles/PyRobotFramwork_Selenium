*** Settings ***
Documentation  Datachain home page - SSO authentification Gina Dev
...

Library    SeleniumLibrary
Resource   ../../common.robot

*** Variables ***
${LOGINSSOGINA}     id:social-oidc


*** Keywords ***
Open Home Page
    [Documentation]
        ...   User launch Datachain
    [Arguments]     ${url}
    Log to console    Connexion à l'url ${url}
    Log    Navigating to: ${url}
    Go To  ${url}

Login sso gina
    [Documentation]
        ...    Login to datachain with SSO Gina Dev
    Wait Until Element Is Visible    ${LOGINSSOGINA}  ${TIMEOUT}
    Click Element    ${LOGINSSOGINA}