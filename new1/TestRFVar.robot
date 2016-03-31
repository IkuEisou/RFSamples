*** Variables ***
${GREET}          Hello
${NAME}           world
@{LogSet}         Warning, world!    WARN
&{USER}           name:robot    password:secret

*** Test Cases ***
Constants
    Log    Hello
    Log    Hello, world!!

Variables
    Log    ${GREET}
    Log    ${GREET}, ${NAME}!!

ListVar
    log    @{LogSet}
    log    The first item of LogSet \ is "@{LogSet}[0] "

*** Keywords ***
KW1
    log    argname=${var}
