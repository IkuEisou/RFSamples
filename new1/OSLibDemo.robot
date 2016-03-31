*** Settings ***
Library           OperatingSystem
Library           Process

*** Variables ***
${TPD}            D:\\RIDEWorkspaces\\new1\\tmp1

*** Test Cases ***
TestCreateDIR
    [Documentation]    This is a Demo
    [Setup]
    Create Directory    ${TPD}/tmp2

TestJoinPaths
    @{paths}=    Join Paths    ${TPD}    f1.txt    f2.txt

TestCreateFile
    Create File    ${TPD}/empty.txt
    Create File    ${TPD}/utf8.txt    你好
    Create File    ${TPD}/euc.txt    こんにちは    SYSTEM

TestRemoveFiles
    Remove Files    ${TPD}/*
    Remove Files    ${TPD}/empty.txt    ${TPD}/utf8.txt    ${TPD}/euc.txt

TestRemoveDIR
    Remove Directory    ${TPD}    true
