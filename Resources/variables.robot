*** Variables ***

# Common variables
${BROWSER}              %{BROWSER=chromium}
${HEADLESS}             %{HEADLESS=True}
${DEBUG}                %{DEBUG=False}
${TIMEOUT}              %{TIMEOUT=300}
${SHOW_SCREENS}         %{SHOW_SCREENS=False}

${HTTP_PROXY}           %{HTTP_PROXY=127.0.0.1:3128}
${DEFAULT_LANG}         %{DEFAULT_LANG=fr-CH}


${VERSION}              %{VERSION=8.6.1}

# For Datachain tests
${ENDPOINT}             %{ENDPOINT=url}
${ENDPOINT_MAESTRO}     %{ENDPOINT=url}

#For Apis Testing
${ACCESS_TOKEN_URL}      %{ACCESS_TOKEN_URL=url}
${BASE_REST_URL}         %{BASE_REST_URL=url}
${BASE_ODATA_URL}        %{BASE_ODATA_URL=url}
${KERBEROS_REST_URL}     %{KERBEROS_REST_URL=url}
${KERBEROS_ODATA_URL}    %{KERBEROS_ODATA_URL=url}
${CLIENT_ID}             %{CLIENT_ID=client_id}
${CLIENT_SECRET}         %{CLIENT_SECRET=secret}
${SCOPE}                 %{SCOPE=roles email}
${AUTH_CHAIN}            %{AUTH_CHAIN=batchService}
${GRANT_TYPE}            %{GRANT_TYPE=password}


# For Bastion and JIRA tests
# TODO Config a .env for credentials
${USERNAME}             %{USERNAME=TEST}
${PASSWORD}             %{PASSWORD=TEST}
${SECRET}               %{SECRET=NotDefined}

${download_directory}   ${OUTPUT_DIR}${/}download
${CDA_MIME}             application/x-cda