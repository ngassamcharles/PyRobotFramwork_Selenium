*** Settings ***
Documentation
...             RBF Testing for Datachain.
...             Tests on datachain

Resource    ../Resources/common.robot
Resource    ../Resources/variables.robot

Resource    ../Resources/PO/SSO/sso_authentification_page.resource
Resource    ../Resources/PO/DATACHAIN/datachain_home_page.resource
Resource    ../Resources/PO/DATACHAIN/datachain_project_home_page.resource
Resource    ../Resources/PO/DATACHAIN/datachain_project_params_page.resource
Resource    ../Resources/PO/DATACHAIN/datachain_context_params_page.resource
Resource    ../Resources/PO/DATACHAIN/datachain_project_details_page.resource
Resource    ../Resources/PO/DATACHAIN/datachain_users_group_params_page.resource
Resource    ../Resources/PO/DATACHAIN/datachain_project_datablocks_page.resource
Resource    ../Resources/PO/DATACHAIN/datachain_project_datablock_params_page.resource
Resource    ../Resources/PO/DATACHAIN/datachain_project_apis_exposition_page.resource
Resource    ../Resources/PO/DATACHAIN/datachain_exposition_api_home_page.resource
Resource    ../Resources/API/REST/datachain_apis_exposition_rest_endpoint.resource
Resource    ../Resources/API/ODATA/datachain_apis_exposition_odata_endpoint.resource
Resource    ../Resources/PO/DATACHAIN/datachain_project_import_page.resource
Resource    ../Resources/PO/DATACHAIN/datachain_project_export_page.resource
Resource    ../Resources/PO/MAESTRO/maestro_home_page.resource
Resource    ../Resources/PO/MAESTRO/maestro_planification_popup_home_page.resource
Resource    ../Resources/PO/MAESTRO/maestro_planification_pipeline_home_page.resource
Resource    ../Resources/PO/MAESTRO/maestro_pipeline_contributors_page.resource
Resource    ../Resources/PO/DATACHAIN/datachain_datablock_export_page.resource



Test Setup        Begin Session
Test Teardown     End Session

*** Test Cases ***

Test Datachain Checking Context
    [Documentation]
    ...                 Open datachain, correctly authenticate & Access on project & manage context.
    ...                 To run the test: robot -d Results -i TestDatachainContextParams Tests
    [Tags]      TestDatachainContextParams
    Open Home Page                                      ${ENDPOINT}
    Fill Username                                       ${USERNAME}
    Fill Password                                       ${PASSWORD}
    Login sso
    Login sso gina
    Menu Project Should Be Present
    Project Robot Framework 11026 Should Be Present
    Check Version                                        ${VERSION}
    Open Project Robot Framework 11026
    Menu Acceuil Should Be Present
    Open Project Parameters
    Save Button Should Be Present
    Project Div Should Be Present
    Open Context Tab
    Verify Context Count                                  6
    Verify first three context text contains              context1
    Persistance context should be enabled
    Activities should be enabled


Test Datachain Checking Users Group
    [Documentation]
    ...                 Open datachain, correctly authenticate & Access on project & manage user group.
    ...                 To run the test: robot -d Results -i TestDatachainUsersGroupsParams Tests
    [Tags]      TestDatachainUsersGroupsParams
    Open Home Page                                      ${ENDPOINT}
    Fill Username                                       ${USERNAME}
    Fill Password                                       ${PASSWORD}
    Login sso
    Login sso gina
    Menu Project Should Be Present
    Project Robot Framework 11026 Should Be Present
    Check Version                                       ${VERSION}
    Open Project Robot Framework 11026
    Menu Acceuil Should Be Present
    Open Project Parameters
    Save Button Should Be Present
    Project Div Should Be Present
    Open Users Groups Tab
    User Admin Should Be Activated
    Other User Should Be Present                        11026-RBF-H-DEVFLUX
    Other User Should Be Present                        11026-RBF-H-VIEWER


Test Datachain Apis Exposition
    [Documentation]
    ...                 Testing APIs exposition both UI by running a datablock.
    ...                 To run the test: robot -d Results -i TestDatachainApisExposition Tests
    [Tags]      TestDatachainApisExposition
    Open Home Page                                      ${ENDPOINT}
    Fill Username                                       ${USERNAME}
    Fill Password                                       ${PASSWORD}
    Login sso
    Login sso gina
    Menu Project Should Be Present
    Project Robot Framework 11026 Should Be Present
    Check Version                                       ${VERSION}
    Open Project Robot Framework 11026
    Menu Acceuil Should Be Present
    Open Datablocks Menu
    Search Datablocks                                   SAD - Preavis
    Edit datablock
    Launch Datablock
    Datablock Running Should Be Completed
    Open Expositions Tab
    Adding New Exposition
    Enter Publication Api Access Point                  rbf_test
    Enter Publication Api Title                         rbf_test
    Enter Details Metadata Publication Api
    Go To The Next Step
    Active All Columns
    Go To The Next Step
    Enter Exposition Access Label                       rbf_test
    Enter Consumers Users                               ADMIN-V2
    Active All Access
    Create Exposition
    Publish Exposition
    Confirm Publish Exposition
    Exposition Should Be Completed
    Open Handle Data View
    Open Share Sub Menu
    Open Exposition Api Menu
    Access Point Should Be Present                      rbf_test
    Datablock Source Should Be Present                  SAD - Preavis


Test Datachain Apis Exposition Endpoint
    [Documentation]
    ...                 Testing APIs exposition endpoint by running them.
    ...                 To run the test: robot -d Results -i TestDatachainApisExpositionEndpoint Tests
    [Tags]      TestDatachainApisExpositionEndpoint
    Calling API V2 REST Should Be Successful        rbf_test
    Calling API V2 Odata Should Be Successful       rbf_test

# These tests are currently failing on GitLab due to Kerberos authentication.
# Since Chrome’s authentication pop-up is not handled by Selenium,
# the only short-term workaround would have been to pass credentials through the URL —
# which is not feasible and strongly discouraged in a CI/CD pipeline.

#    Calling API V2 Kerberos REST Should Be Successful   rbf_test
#    Calling API V2 Kerberos Odata Should Be Successful  rbf_test


Test Datachain Export Project
    [Documentation]
    ...                 Export project on Datachain.
    ...                 To run the test: robot -d Results -i TestDatachainExportProject Tests
    [Tags]      TestDatachainExportProject
    Open Home Page                                          ${ENDPOINT}
    Fill Username                                           ${USERNAME}
    Fill Password                                           ${PASSWORD}
    Login sso
    Login sso gina
    Menu Project Should Be Present
    Project Robot Framework 11026 Should Be Present
    Check Version                                           ${VERSION}
    Open Project Robot Framework 11026
    Menu Acceuil Should Be Present
    Open Project Parameters
    Save Button Should Be Present
    Project Div Should Be Present
    Open Burger Menu
    Select Export Project
    Fill File Name                                          robot_framework_export_file
    Select Copy Project Template
    Select Copy Users Informations
    Select Handledata Element
    Select Export Repository
    Accept Responsability Conditions
    Export Project
    Confirm Export
    Export Should Be Completed                              robot_framework_export_file


Test Datachain Import Project
    [Documentation]
    ...                 Import project on Datachain.
    ...                 To run the test: robot -d Results -i TestDatachainImportProject Tests
    [Tags]      TestDatachainImportProject
    Open Home Page                                          ${ENDPOINT}
    Fill Username                                           ${USERNAME}
    Fill Password                                           ${PASSWORD}
    Login sso
    Login sso gina
    Menu Project Should Be Present
    Project Robot Framework 11026 Should Be Present
    Check Version                                           ${VERSION}
    Click On New Project
    Click On Import Project
    Choose Project File                                     robot_framework_export_file
    Enter Import Project Label                              robot framework
    Enable Context Persist  1
    Enable Context Persist  2
    Enable Context Persist  3
    Enable Context Other    1
    Enable Context Other    2
    Enable Context Other    3
    Copy Template On Import
    Select Element Handle Data Import
    Select Repository Import
    Select Users Admin Group Import                         ADMIN
    Select User Devflux Group Import                        11026-RBF-H-DEVFLUX
    Select User Viewer Group Import                         11026-RBF-H-VIEWER
    Enter Root Code For Exposition                          robotframework
    Go To Next Import Page
    Select User Group Source                                ADMIN-V2
    Create Import Project
    Project Should Be Created

# This test fails in a Linux environment (Docker, GitLab) due to an infinite loading of the scheduling list.
# This issue only occurs on Linux machines (Docker, GitLab, etc.).
#
#Test Maestro Planification
#    [Documentation]
#    ...                 Running planification through Maestro.
#    ...                 To run the test: robot -d Results -i TestMaestroPlanification Tests
#    [Tags]      TestMaestroPlanification
#    Open Home Page                              ${ENDPOINT_MAESTRO}
#    Fill Username                               ${USERNAME}
#    Fill Password                               ${PASSWORD}
#    Login sso
#    Login sso gina
#    Item Should Be Present
#    Select Item
#    Create Planification
#    Entrer Password On PopUp Security Check     ${PASSWORD}
#    Submit Password Security Check
#    Choose Project Robot Framework
#    Fill Label For Pipeline                     rbf_test
#    Save Pipeline
#    Open Pipeline Details Settings Tab
#    Open Contributors Settings
#    Select Contributor                          MAESTRO-ADMIN
#    Save Contributors
#    Open Workflow Tab
#    Optimize Pipeline Details
#    Initiation Of Computations
#    See The New Workflow
#    Save Pipeline Details Workflow
#    Redirection To Main Pipeline Layout
#    Execute Pipeline                            rbf_test
#    Pipeline Should Be Launched                 rbf_test


Test Datachain Delete Apis Exposition
    [Documentation]
    ...                 Delete Apis Exposition for better clearing.
    ...                 To run the test: robot -d Results -i TestDatachainDeleteApisExposition Tests
    [Tags]      TestDatachainDeleteApisExposition
    Open Home Page                                      ${ENDPOINT}
    Fill Username                                       ${USERNAME}
    Fill Password                                       ${PASSWORD}
    Login sso
    Login sso gina
    Menu Project Should Be Present
    Project Robot Framework 11026 Should Be Present
    Check Version                                       ${VERSION}
    Open Project Robot Framework 11026
    Menu Acceuil Should Be Present
    Open Handle Data View
    Open Share Sub Menu
    Open Exposition Api Menu
    Open Exposition Actions                              rbf_test
    Delete Exposition
    Confirm Checkbox Delete Exposition
    Confirm Delete Exposition
    Exposition Should Be Deleted


Test Datachain Export Datablock Sftp
    [Documentation]
    ...                 Export Datablock on a SFTP (This test only check the notification on Datachain at the moment).
    ...                 To run the test: robot -d Results -i TestDatachainExportDatablockSftp Tests
    [Tags]      TestDatachainExportDatablockSftp
    Open Home Page                                      ${ENDPOINT}
    Fill Username                                       ${USERNAME}
    Fill Password                                       ${PASSWORD}
    Login sso
    Login sso gina
    Menu Project Should Be Present
    Project Robot Framework 11026 Should Be Present
    Check Version                                       ${VERSION}
    Open Project Robot Framework 11026
    Menu Acceuil Should Be Present
    Open Datablocks Menu
    Search Datablocks                                   SAD - Preavis
    Edit datablock
    Open Datablock Option Menu
    Select Option Export Datablock
    Select Local Connector
    Select New Connector                                SFTP_DEV
    Fill Path For Export                                /data/datsftp/11026_RobotFramework
    Export Datablock
    Datablock Export Should Be Completed