*** Settings ***
Library     RequestsLibrary
Library     Collections
Library     ../../LIB/DatachainKerberosAuth.py


Resource   ../../common.robot
Resource   ../AUTH/datachain_authentification_token.resource

*** Variables ***
${JSON_FORMATTER}   xpath=//div[@class='json-formatter-container']

*** Keywords ***
Get Token
    [Documentation]
    ...     Get the token of the datachain adminusser
     ${response}=    Post OAuth2
     ${token}=    Get Access Token Response    ${response}
     Log    Access token obtenu avec succès: ${token}
     RETURN     ${token}

Calling API V2 REST Should Be Successful
    [Documentation]
    ...     Calling rest api exposition
    [Arguments]     ${endpoint_access}
    ${token}        Get Token
    ${headers}      Create Dictionary   Authorization=Bearer ${token}
    ${response}     GET On Session      Testing_Api_Exposition     ${BASE_REST_URL}/${endpoint_access}
    ...    headers=${headers}
    ...    expected_status=200

Calling API V2 Kerberos REST Should Be Successful
    [Documentation]
    ...     Calling kerberos rest api exposition via browser
    [Arguments]     ${endpoint_access}
    # The %5C is to avoid backslash and parse the username and password is about skipping chrome native popup which isn't handle by selenium library.
    Open Page For Kerberos    https://GE-ADMIN%5C${USERNAME}:${PASSWORD}@${KERBEROS_REST_URL}/${endpoint_access}
    Wait For Condition    return document.readyState == "complete"
    Wait Until Keyword Succeeds   5x    5s    Element Should Be Visible    ${JSON_FORMATTER}
#     ${response}    Authenticate And Get Kerberos Endpoint
#     ...    ${USERNAME}
#     ...    ${PASSWORD}
#     ...    ${KERBEROS_REST_URL}/${endpoint_access}
#
#     ${status_code}=    Get Response Status Code
#     Should Be Equal As Numbers    ${status_code}    200
           


Open Page For Kerberos
    [Documentation]
        ...   User launch new page for kerberos endpoint REST.
    [Arguments]     ${url}
    Log to console    Connexion à l'url ${url}
    Log    Navigating to: ${url}
    Go To    ${url}


