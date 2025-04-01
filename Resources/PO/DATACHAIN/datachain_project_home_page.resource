*** Settings ***
Documentation  Datachain home page
...

Library    SeleniumLibrary
Resource   ../../common.robot

*** Variables ***
${ROBOTFRAMEWORKPROJECT_11026}      xpath://div[@id="Robot Framework - 11026"]
${MENU_PROJECT}                     id:menu-project
${DATABLOCKS_MENU}                  id:dataBlocks
${NEW_PROJECT_BTN}                  id:new_btn
${IMPORT_PROJECT_BTN}               id:project-import-btn
${VERSION_DATACHAIN}                xpath=//div[contains(@class, 'version-info')]//span[contains(., 'Version')]
${SPINNER}                          id:spinner
${HANDLE_DATA_VIEW_MENU}            id:handleData-menu
${SHARE_SUB_MENU}                   id:share-menu-label
${EXPOSITION_API_MENU}              xpath=//span[normalize-space()='Expositions API']


*** Keywords ***
Open Project Robot Framework 11026
    [Documentation]
    ...     Open the project robot framework 11026 on datachain
    Wait Until Element Is Visible    ${ROBOTFRAMEWORKPROJECT_11026}
    Click Element    ${ROBOTFRAMEWORKPROJECT_11026}
    Wait Until Element Is Not Visible    ${SPINNER}

Menu Project Should Be Present
    [Documentation]
    ...     return true if element Menu is present and visible
    Wait Until Element Is Visible    ${MENU_PROJECT}
    ${is_present} =  Run Keyword And Return Status    Element Should Be Visible    ${MENU_PROJECT}
    Should Be True    ${is_present}

Project Robot Framework 11026 Should Be Present
    [Documentation]
    ...     return true if element Project 11026 is present and visible
    Wait Until Element Is Visible    ${ROBOTFRAMEWORKPROJECT_11026}
    ${is_present} =  Run Keyword And Return Status    Element Should Be Visible    ${ROBOTFRAMEWORKPROJECT_11026}
    Should Be True    ${is_present}

Open Datablocks Menu
    [Documentation]
    ...     Open datalblocks menu at the left
    Wait Until Element Is Visible    ${DATABLOCKS_MENU}
    Click Element    ${DATABLOCKS_MENU}

Open Handle Data View
    [Documentation]
    ...     Open handle data view
    Wait Until Element Is Visible    ${HANDLE_DATA_VIEW_MENU}
    Click Element    ${HANDLE_DATA_VIEW_MENU}

Open Share Sub Menu
    [Documentation]
    ...     Open share sub menu
    Wait Until Element Is Visible    ${SHARE_SUB_MENU}
    Click Element    ${SHARE_SUB_MENU}

Open Exposition Api Menu
    [Documentation]
    ...     Open exposition api menu
    Wait Until Element Is Visible    ${EXPOSITION_API_MENU}
    Click Element    ${EXPOSITION_API_MENU}

Click On New Project
    [Documentation]
    ...     User click on new project
    Wait Until Element Is Visible    ${NEW_PROJECT_BTN}
    Click Element    ${NEW_PROJECT_BTN}

Click On Import Project
    [Documentation]
    ...     User click on import project
    Wait Until Element Is Visible    ${IMPORT_PROJECT_BTN}
    Click Element    ${IMPORT_PROJECT_BTN}

Check Version
    [Documentation]
    ...     Return & check the version of Datachain
    [Arguments]     ${expected_version}
    Wait Until Element Is Visible    ${VERSION_DATACHAIN}
    ${datachain_version}  Get Text    ${VERSION_DATACHAIN}
    Element Should Contain    ${VERSION_DATACHAIN}    ${expected_version}
