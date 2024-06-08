#!/bin/bash

# Caminho para a pasta da API dentro do contêiner
API_DIR=/application/trocaTroca/api

# URL do repositório da API
REPO_URL=https://github.com/pablioRichardy/trocaTrocaAPI.git

# Verificar se o arquivo de marcação existe
if [ ! -f $API_DIR/.initialized ]; then
  apk update && apk add git
  echo "Clonando o repositório da API..."
  rm -rf $API_DIR/*  # Remove todo o conteúdo da pasta API
  git clone $REPO_URL $API_DIR
  touch $API_DIR/.initialized
  echo "Repositório clonado e arquivo de marcação criado."
fi

# Verificar se package.json existe e instalar dependências
if [ -f $API_DIR/package.json ]; then
  cd $API_DIR
  npm install
fi

# Comando principal do contêiner
exec "$@"
