*** Settings ***
Documentation  Datachain apis exposition page
...

Library    SeleniumLibrary
Resource   ../../common.robot

*** Variables ***
${EXPOSITION_ACCESS_LABEL_INPUT}                    id:exposition-access-config-label-input
${EXPOSITION_ENDPOINT_METADATA_DETAILS_INPUT}       id:exposition-endpoint-metadata-config-details-input
${ACCESS_POINT_API_PUBLICATION_INPUT}               id:exposition-endpoint-metadata-config-access-point-input
${TITLE_API_PUBLICATION_INPUT}                      id:exposition-endpoint-metadata-config-title-input
${ACTIVE_ALL_COLUMS_TOGGLE}                         expositions-columns-config--activate-all-toggle-input
${ACTIVE_ALL_ACCESS_TOGGLE}                         expositions-access-columns-config--activate-all-toggle-input
${SEARCH_CONSUMERS_EXPOSITION_ACCESS}               id:exposition-access-config-search-consumers-input
${PUBLISH_BUTTON}                                   id:exposition-view-publish-btn
${CONFIRM_PUBLISH_BUTTON}                           id:exposition-confirm-publish-btn
${CREATE_EXPOSITION_BUTTON}                         id:exposition-stepper-create-btn
${NEXT_EXPOSITION_BUTTON}                           id:exposition-stepper-next-btn
${UPDATE_VIEW_EXPOSITION_BUTTON}                    id:exposition-view-update-data-btn
${CLEAR_DATA_EXPOSITION_BUTTON}                     id:exposition-view-clear-data-btn
${STEP_BACK_BUTTON}                                 id:exposition-stepper-back-btn


*** Keywords ***
Enter Details Metadata Publication Api
    [Documentation]
    ...     Enter detail for the publication api
    Wait Until Element Is Visible    ${EXPOSITION_ENDPOINT_METADATA_DETAILS_INPUT}
    Input Text    ${EXPOSITION_ENDPOINT_METADATA_DETAILS_INPUT}    Automated test with robotframework

Enter Publication Api Access Point
    [Documentation]
    ...     Enter access point for the publication api
    [Arguments]     ${access_point}
    Wait Until Element Is Visible    ${ACCESS_POINT_API_PUBLICATION_INPUT}
    Input Text    ${ACCESS_POINT_API_PUBLICATION_INPUT}    ${access_point}

Enter Publication Api Title
    [Documentation]
    ...     Enter title for the publication api
    [Arguments]     ${title}
    Wait Until Element Is Visible    ${TITLE_API_PUBLICATION_INPUT}
    Input Text    ${TITLE_API_PUBLICATION_INPUT}    ${title}

Enter Exposition Access Label
    [Documentation]
    ...     Enter metadata label on access
    [Arguments]     ${label}
    Sleep    2s
    Wait Until Element Is Visible    ${EXPOSITION_ACCESS_LABEL_INPUT}
    Input Text    ${EXPOSITION_ACCESS_LABEL_INPUT}    ${label}

Enter Consumers Users
    [Documentation]
    ...     Enter consumers users
    [Arguments]     ${consumers}
    Click Element    ${SEARCH_CONSUMERS_EXPOSITION_ACCESS}
    ${consumer_user}    Set Variable    xpath=//span[contains(text(),'${consumers}')]
    Click Element    ${consumer_user}

Active All Columns
    # TODO: Optimise the wait and remove the sleep.
    [Documentation]
    ...     Active all toggle columns
    Sleep    2s
    Click On Element Using Javascript By Id    ${ACTIVE_ALL_COLUMS_TOGGLE}

Active All Access
    [Documentation]
    ...     Active all toggle access
    Click On Element Using Javascript By Id    ${ACTIVE_ALL_ACCESS_TOGGLE}

Publish Exposition
    [Documentation]
    ...     Publish exposition
    Wait Until Element Is Visible    ${PUBLISH_BUTTON}
    Click Element    ${PUBLISH_BUTTON}

Confirm Publish Exposition
    [Documentation]
    ...     Publish exposition
    Wait Until Element Is Visible    ${CONFIRM_PUBLISH_BUTTON}
    Click Element    ${CONFIRM_PUBLISH_BUTTON}

Go To The Next Step
    [Documentation]
    ...     Go to the next step
    Wait Until Element Is Enabled    ${NEXT_EXPOSITION_BUTTON}
    Click Element    ${NEXT_EXPOSITION_BUTTON}

Go To The Previous Step
    [Documentation]
    ...     Go to the previous step
    Click Element    ${STEP_BACK_BUTTON}

Create Exposition
    [Documentation]
    ...     Create exposition apis
    Wait Until Element Is Enabled    ${CREATE_EXPOSITION_BUTTON}
    Click Element    ${CREATE_EXPOSITION_BUTTON}

Exposition Should Be Completed
    [Documentation]
    ...     Exposition should be completed.
    Wait Until Keyword Succeeds    5 times    10s    Element Should Be Visible    ${UPDATE_VIEW_EXPOSITION_BUTTON}
    Element Should Be Visible    ${CLEAR_DATA_EXPOSITION_BUTTON}
