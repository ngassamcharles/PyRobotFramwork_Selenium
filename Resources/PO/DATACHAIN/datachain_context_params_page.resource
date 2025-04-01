*** Settings ***
Documentation  Datachain project context parameter page
...

Library    SeleniumLibrary
Library    Collections
Resource   ../../common.robot

*** Variables ***
${CONTEXT_AVAILABLE}    xpath=//div[@class='ctx-row-item']/strong
${PERSISTANCE_CHECK}    xpath=//div[@id='switch_persistence']//md-switch
${ACTIVITIES_CHECK}     xpath=//div[@id='switch_act']//md-switch


*** Keywords ***
Verify Context Count
    [Documentation]
    ...     get all the available context & count them. All context should be present.
    [Arguments]  ${number_of_context_expected}
     ${contexts}      Get Element Count    ${CONTEXT_AVAILABLE}
     Should Be Equal As Numbers    ${contexts}    ${number_of_context_expected}

Persistance context should be enabled
    [Documentation]
    ...     All persistence of contexts should be enabled
    ${elements}=    Get WebElements    ${PERSISTANCE_CHECK}
    FOR    ${index}    IN RANGE    3
        ${element}=    Get From List    ${elements}    ${index}
        ${aria_checked}    Get Element Attribute    ${element}    aria-checked
        Should Be Equal As Strings    ${aria_checked}    true
    END
    FOR    ${index}    IN RANGE    3    6
        ${element}=    Get From List    ${elements}    ${index}
        ${aria_checked}    Get Element Attribute    ${element}    aria-checked
        Should Be Equal As Strings    ${aria_checked}    false
    END

Activities should be enabled
    [Documentation]
    ...     All activities of contexts should be enabled.
    ${elements}=    Get WebElements    ${ACTIVITIES_CHECK}
    FOR    ${index}    IN RANGE    3
        ${element}=    Get From List    ${elements}    ${index}
        ${aria_checked}    Get Element Attribute    ${element}    aria-checked
        Should Be Equal As Strings    ${aria_checked}    true
    END
    FOR    ${index}    IN RANGE    3    6
        ${element}=    Get From List    ${elements}    ${index}
        ${aria_checked}    Get Element Attribute    ${element}    aria-checked
        Should Be Equal As Strings    ${aria_checked}    false
    END

Verify first three context text contains
    [Documentation]
    ...     Verify text contains for some context
    [Arguments]  ${text}
    ${elements}=    Get WebElements    ${CONTEXT_AVAILABLE}
     FOR    ${index}    IN RANGE    3
        ${element}=    Get From List    ${elements}    ${index}
        Element Should Contain    ${element}    ${text}
     END
     FOR    ${index}    IN RANGE    3    6
         ${element}=    Get From List    ${elements}    ${index}
         Element Should Not Contain    ${element}    ${text}
     END