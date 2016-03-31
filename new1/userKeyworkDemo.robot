*** Settings ***
Force Tags        req-42
Default Tags      owner-yuyc    smoke
Library           Process
Library           Telnet    prompt=>    default_log_level=DEBUG
Library           SSHLibrary
Library           String

*** Variables ***
&{telnet_login}    name=test    pwd=test    host=193.160.40.17
&{ssh_login}      host=10.167.227.48    name=yuyc    pwd=fnst_1234

*** Test Cases ***
TestProcess
    [Tags]    not_ready
    ${result} =    Run Program    shell=True
    Should Be Equal    ${result.stdout}    Hello, world!

TestTelnet
    ${loginOutput}=    telnetLogin    &{telnet_login}
    ${userOutput}=    Telnet.Execute Command    set USERNAME
    @{words}=    Split String    ${userOutput}    =
    Should Contain    @{words}[1]    &{telnet_login}[name]
    Telnet.Close Connection

TestSSH
    [Documentation]    Execute Command can be used to ran commands on the remote machine.
    ...    The keyword returns the standard output by default.
    ${output}=    sshLogin    &{ssh_login}
    Should Contain    ${output}    Last login
    ${output}=    SSHLibrary.Execute Command    echo Hello SSHLibrary!
    Should Be Equal    ${output}    Hello SSHLibrary!
    SSHLibrary.Close All Connections

*** Keywords ***
List files
    [Arguments]    ${path}=.    ${options}=
    Execute Command    ls    ${options}    ${path}

sshLogin
    [Arguments]    &{_login}
    SSHLibrary.Open Connection    &{_login}[host]
    ${_output}=    SSHLibrary.Login    &{_login}[name]    &{_login}[pwd]
    [Return]    ${_output}

telnetLogin
    [Arguments]    &{_login}
    Telnet.Open connection    &{_login}[host]    timeout=10
    ${_output}=    Telnet.Login    &{_login}[name]    &{_login}[pwd]    password_prompt=password:
    [Return]    ${_output}

Run Program
    [Arguments]    @{args}
    ${result} =    Run Process    python    -c    print 'Hello, world!'    @{args}
    [Return]    ${result}
