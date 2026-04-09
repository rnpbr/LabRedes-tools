@echo off
setlocal

REM URL do arquivo tar
set "URL=https://git.rnp.br/redes-abertas/docker-composes/-/archive/main/docker-composes-main.tar?path=Telegraf"

REM Nome do arquivo para salvar
set "FILENAME=docker-composes-main.tar"

REM Diretório onde descompactar os arquivos
set "DEST_DIR=."

echo Baixando %FILENAME%...
curl -L -o %FILENAME% %URL%

REM Verificar se o download foi bem-sucedido
if not exist %FILENAME% (
    echo Erro ao baixar o arquivo.
    exit /b 1
)

echo Descompactando %FILENAME%...
tar -xf %FILENAME% -C %DEST_DIR% --strip-components=1

REM Verificar se a descompactação foi bem-sucedida
if %errorlevel% neq 0 (
    echo Erro ao descompactar o arquivo.
    exit /b 1
)

REM Remover o arquivo tar após descompactar
del %FILENAME%

echo Download e descompactação concluídos com sucesso.

endlocal
pause
