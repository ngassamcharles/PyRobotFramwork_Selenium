*** Settings ***
Resource    variables.robot
Library     SeleniumLibrary
Library     Dialogs
Library     OperatingSystem

*** Keywords ***
Get browser options of chrome
    Create Directory    ${download_directory}
    # ${chrome_options}=      Evaluate    selenium.webdriver.ChromeOptions()
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    --incognito
    Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    #Call Method    ${chrome_options}    add_argument    --proxy-server\=proxygeadm.etat-ge.ch:3128
    Call Method    ${chrome_options}    add_argument    --proxy-server\=http\=${HTTP_PROXY}
    Call Method    ${chrome_options}    add_argument    --proxy-type\=http
    Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage
    Call Method    ${chrome_options}    add_argument    --disable-extensions
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    #Call Method    ${chrome_options}    add_argument    --window-size\=1920,1080
    Call Method    ${chrome_options}    add_argument    --start-maximized
    Call Method    ${chrome_options}    add_argument    --lang\=${DEFAULT_LANG}
    # BUG WITH THE VERSION 129 need to add \=old to solve the issue to show a blanck screen on HEADLESS=True
    Run Keyword If  ${HEADLESS}   Call Method    ${chrome_options}    add_argument    --headless\=new
    #${prefs}=      Create Dictionary    intl.accept_languages=${DEFAULT_LANG}
    #${prefs}       Create Dictionary    download.default_directory=${download directory}
    ${prefs} =      Create Dictionary
    ...    intl.accept_languages=${DEFAULT_LANG}
    ...    download.default_directory=${download_directory}
    ...    download.prompt_for_download=${FALSE}
    ...    download.directory_upgrade=${TRUE}
    ...    safebrowsing.enabled=${FALSE}              # Critical for XML/executable files
    ...    profile.default_content_settings.popups=0
    ...    profile.content_settings.exceptions.automatic_downloads.*.setting=1
    ...    download.extensions_to_open=dca  # Critical for .cda files

    # &{prefs}=    Create Dictionary    intl.accept_languages=fr-CH
    Call Method    ${chrome_options}    add_experimental_option    prefs    ${prefs}
    Call Method    ${chrome_options}    add_argument    --disable-infobars
    Call Method    ${chrome_options}    add_argument    --safebrowsing-disable-download-protection
    Call Method    ${chrome_options}    add_argument    --allow-unchecked-dangerous-downloads
    Call Method    ${chrome_options}    add_argument    --disable-popup-blocking

    # Google documentation use headless=new instead of headless
    # version: chrome < 96 use --headless
    # version: 96 <= chrome <= 108 --headless=chrome
    # version: chrome >= 109 --headless=new
    # version: chrome <= 120 --headless
    # version: chrome >= 129 --headless
    RETURN   ${chrome_options}

Begin Session
    ${options}=     Get browser options of chrome
    IF  "${BROWSER}"=="chromium"
        # open browser   browser=headlesschrome   options=${chrome_options}   service_log_path=${WEBRIVERS_LOGS}
        open browser   browser=chrome   options=${options}
        Set Selenium Implicit Wait    10s
    ELSE
        log to console  Not yet implemented
        Fatal Error     Use of browser: ${BROWSER} is not yet implemented
    END
    #Set window position     x=0   y=0
    # set window size         height=1920    width=1080

End Session
    ${RESULT_STATUS}=    get variable value    ${TEST_STATUS}   NONE
    IF    '${RESULT_STATUS}' == 'NONE'
        ${RESULT_STATUS}=    get variable value    ${SUITE_STATUS}
    END
    run keyword if    ${DEBUG} == True and '${RESULT_STATUS}' == 'FAIL'  Pause For Debug
    Close All Browsers

Pause For Debug
    Pause Execution     Paused execution dur to failure, click OK to continue

Show Screen
    [Arguments]     ${time_to_sleep}=1  ${reason_to_sleep}=none
    run keyword if    ${SHOW_SCREENS} == True  sleep   ${time_to_sleep}    reason=${reason_to_sleep}

Click On Element Using Javascript By Id
    [Documentation]
    ...     Click on element by her id. it's a alternative when some element isn't visible but present on the DOM
    [Arguments]     ${id}
    Execute Javascript      document.getElementById('${id}').click();

Fill Text On Element By Id Using Javascript
    [Documentation]
    ...     Fill the on a element by retrieving it by his id. it's a alternative when some element isn't visible but present on the DOM
    [Arguments]     ${id}   ${text}
    Execute Javascript      document.getElementById('${id}').value = '${text}';
