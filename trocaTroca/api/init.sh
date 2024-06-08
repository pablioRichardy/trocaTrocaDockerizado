#!/bin/bash

# Caminho para o diretório do script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Caminho para a pasta da API dentro do contêiner
API_DIR=/application/trocaTroca/api

# URL do repositório da API
REPO_URL=https://github.com/pablioRichardy/trocaTrocaAPI.git

# Função para clonar o repositório e instalar dependências
initialize_api() {
  apk update && apk add git
  echo "Clonando o repositório da API..."
  rm -rf "$API_DIR"/*  # Remove todo o conteúdo da pasta API
  git clone "$REPO_URL" "$API_DIR"
  touch "$API_DIR/.initialized"
  echo "Repositório clonado e arquivo de marcação criado."

  cd "$API_DIR" || exit
  npm install
}

# Verificar se o arquivo de marcação existe
if [ ! -f "$API_DIR/.initialized" ]; then
  initialize_api
fi

# Verificar se o arquivo do script foi excluído e recriá-lo se necessário
if [ ! -f "$SCRIPT_DIR/init.sh" ]; then
  echo "Recriando o script init.sh..."
  cp "$0" "$SCRIPT_DIR/init.sh"
  echo "Script init.sh recriado."
fi

# Comando principal do contêiner
exec "$@"
