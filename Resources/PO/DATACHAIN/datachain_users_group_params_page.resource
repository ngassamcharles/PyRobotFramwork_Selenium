*** Settings ***
Documentation  Datachain user group parameters page
...

Library    SeleniumLibrary
Library    Collections
Resource   ../../common.robot

*** Variables ***
${ACTIVATED_ADMIN_CHECKS}       xpath=//tr//md-switch
${SPINNER}                      id:spinner


*** Keywords ***
User Admin Should Be Activated
       [Documentation]
       ...      User should be administrator and active
       Wait Until Element Is Not Visible    ${SPINNER}  10000
       Wait Until Element Is Visible    ${ACTIVATED_ADMIN_CHECKS}
        ${elements}=    Get WebElements    ${ACTIVATED_ADMIN_CHECKS}
        FOR    ${index}    IN RANGE    2
           ${element}=    Get From List    ${elements}    ${index}
           ${aria_checked}    Get Element Attribute    ${element}    aria-checked
           Should Be Equal As Strings    ${aria_checked}    true
        END

Other User Should Be Present
        [Documentation]
        ...     Other user should be present on user/groups
        [Arguments]     ${label}
         Wait Until Element Is Not Visible    ${SPINNER}  10000
         ${user_label}  Set Variable    xpath=//span[normalize-space()='${label}']
         Wait Until Keyword Succeeds    3 times    5s    Element Should Be Visible    ${user_label}
