*** Settings ***
Library     RPA.Browser.Selenium    auto_close=${FALSE}
Library     RPA.HTTP
Library     time


*** Variables ***
${URL}                      https://torresburriel.com/
${SCREENSHOT_FILENAME}      captura_de_pantalla.png


*** Tasks ***
Verificar estado de me web
    Abrir pagina y medir velocidad
    Obtener el código de estado HTTP


*** Keywords ***
Abrir pagina y medir velocidad
	${start_time}=    Get Time    epoch_millis
    Open Available Browser    ${URL}    browser=chrome    options=add_argument("--profile-directory=Profile 1")
    Capture Page Screenshot    ${SCREENSHOT_FILENAME}
    Wait Until Page Contains    Sabemos lo que piensan tus clientes    15s
    ${end_time}=    Get Time    	epoch_millis
    ${load_time_milliseconds}=    Evaluate    	${end_time} - ${start_time}
    Log    La página tardó ${load_time_milliseconds} milisegundos en cargar.


Obtener el código de estado HTTP
    Create Session    my_session    ${URL}
    ${response}=    GET On Session    my_session    /
    ${status_code}=    Set Variable    ${response.status_code}
    Log    El código de estado HTTP es ${status_code}.

