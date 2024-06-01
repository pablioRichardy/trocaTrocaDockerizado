# Verificar se o arquivo de marcação existe
if [ ! -f /application/trocaTroca/front-end/.initialized ]; then
    # Comandos a serem executados apenas na primeira inicialização
    npm upgrade

    npm install -g create-vite
    
    # Utilize redirecionamento de entrada para fornecer respostas padrão para npm init vite
    echo -e '\n' | create-vite . --template react-ts

    # Atualizando as linhas criadas por padrão do tsconfig para essa config abaixo, onde explicita a atualização em tempo real da aplicação
    sed -i '/plugins: \[react()/a \\tserver: {\n\t\twatch: {\n\t\t\tusePolling: true,\n\t\t\tinterval: 1000,\n\t\t},\n\t},' /application/trocaTroca/front-end/app/vite.config.ts
    
    # Garantindo que vou estar no diretóriio que contém meu package.json
    cd /application/trocaTroca/front-end/app

    # Instalando as dependencias necessárias
    npm install

    # Criar o arquivo de marcação
    touch /application/trocaTroca/front-end/.initialized
fi

# Comando principal do contêiner
exec "$@"