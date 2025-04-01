*** Settings ***
Library     RequestsLibrary
Library     Collections


Resource   ../../common.robot
*** Variables ***


*** Keywords ***
Post OAuth2
    [Documentation]
    ...     Post request on OAuth2 endpoint.
    ${headers}      Create Dictionary   Content-Type=application/x-www-form-urlencoded
    ${form_data}=    Create Dictionary
    ...    client_id=${CLIENT_ID}
    ...    grant_type=${GRANT_TYPE}
    ...    username=${USERNAME}
    ...    password=${PASSWORD}
    ...    client_secret=${CLIENT_SECRET}
    ...    scope=${SCOPE}
    ...    auth_chain=${AUTH_CHAIN}

    Create Session    Testing_Api_Exposition    ${ACCESS_TOKEN_URL}   max_retries=1
    ${response}     POST On Session     Testing_Api_Exposition    ${ACCESS_TOKEN_URL}
     ...    headers=${headers}
     ...    data=${form_data}
     ...    expected_status=200
     RETURN    ${response}


Get Access Token Response
    [Documentation]
        ...     Retrieve access token on the response.
    [Arguments]    ${response}
    Status Should Be    200    ${response}
    Dictionary Should Contain Key    ${response.json()}    access_token
    Dictionary Should Contain Key    ${response.json()}    token_type
    Dictionary Should Contain Key    ${response.json()}    expires_in
    ${access_token}=    Get From Dictionary    ${response.json()}    access_token
    Should Not Be Empty    ${access_token}
    RETURN    ${access_token}

