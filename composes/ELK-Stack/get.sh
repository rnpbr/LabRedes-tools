#!/bin/bash

# Função para verificar se um comando está instalado
check_command() {
    command -v "$1" >/dev/null 2>&1
}

# Função para instalar pacotes
install_package() {
    if [ -x "$(command -v apt-get)" ]; then
        sudo apt-get update
        sudo apt-get install -y "$1"
    elif [ -x "$(command -v dnf)" ]; then
        sudo dnf install -y "$1"
    elif [ -x "$(command -v yum)" ]; then
        sudo yum install -y "$1"
    elif [ -x "$(command -v pacman)" ]; then
        sudo pacman -Sy --noconfirm "$1"
    else
        echo "Erro: Gerenciador de pacotes não suportado. Instale '$1' manualmente."
        exit 1
    fi
}

if ! check_command tar; then
    echo "O pacote 'tar' não está instalado. Instalando..."
    install_package tar
fi

# URL do arquivo tar
URL="https://git.rnp.br/redes-abertas/docker-composes/-/archive/main/docker-composes-main.tar?path=ELK-Stack"

# Nome do arquivo para salvar
FILENAME="docker-composes-main.tar"

# Diretório onde descompactar os arquivos
DEST_DIR="./"

# Baixar o arquivo
echo "Baixando $FILENAME..."
curl -L -o $FILENAME "$URL"

# Verificar se o download foi bem-sucedido
if [ $? -ne 0 ]; then
    echo "Erro ao baixar o arquivo."
    exit 1
fi

# Descompactar o arquivo
echo "Descompactando $FILENAME..."
tar -xf $FILENAME -C $DEST_DIR --strip-components=1

# Verificar se a descompactação foi bem-sucedida
if [ $? -ne 0 ]; then
    echo "Erro ao descompactar o arquivo."
    exit 1
fi

# Remover o arquivo tar após descompactar
rm $FILENAME

echo "Download e descompactação concluídos com sucesso."
