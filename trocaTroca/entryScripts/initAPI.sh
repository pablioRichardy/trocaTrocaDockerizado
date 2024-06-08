#!/bin/bash

# Caminho para a pasta da API dentro do contêiner
API_DIR=/application/trocaTroca/api

# URL do repositório da API
REPO_URL=https://github.com/pablioRichardy/trocaTrocaAPI.git

# Função para clonar o repositório e instalar dependências
initialize_api() {
  apk update && apk add git
  echo "Clonando o repositório da API..."
  git clone "$REPO_URL" "$API_DIR"
  touch "$API_DIR/.initialized"
  echo "Repositório clonado e arquivo de marcação criado."

  cd "$API_DIR" || exit
  npm install
}

# Verificar se a pasta da API não está vazia
if [ -z "$(ls -A "$API_DIR")" ]; then
  initialize_api
else
  echo "A pasta da API já contém arquivos. O repositório não será clonado novamente."
fi

# Comando principal do contêiner
exec "$@"
