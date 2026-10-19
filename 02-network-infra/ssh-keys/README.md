# SSH 

## Objetivo
Configurar o acesso remoto entre maquinas Linux utilizando SSH, com autenticacao por chave publica e privada Ed25519.
Tambem configurar o acesso por alias SSH, a desativacao da autenticacao por senha e o bloqueio do acesso direto do usuario root.

## Ambiente
- Sistema operacional: Ubuntu Server 24.04.5 LTS
- Cliente: Ubuntu Linux
- Servidor SSH: 192.168.1.3
- Usuario remoto: server2
- Autenticacao: chave SSH Ed25519

## Configuracao

### 1. Autenticacao por chave SSH
Foi criada uma chave Ed25519 no cliente para permitir a autenticacao sem utilizar senha da conta remota.
A chave publica foi instalada no servidor para autorizar o acesso do usuario server2.
A chave privada permanece no cliente e nao deve ser compartilhada.

### 2. Configuracao do cliente
Foi criado o arquivo client.ssh_config para documentar a configuração utilizada pelo cliente SSH.
O acesso ao servidor foi configurado com um alias, permitindo utilizar o nome linux-valley em vez de informar o endereço IP e os demais parametros de conexao a cada acesso.

### 3. Configuração do servidor
O arquivo server.ssh_config documenta as configurações de seguranca aplicadas ao servico SSH.
As configuracoes abordadas incluem:

- Autenticacao por chave publica.
- Desativacao da autenticacao por senha.
- Bloqueio do login direto do usuario root.

Essas medidas reduzem a exposicao do serviço SSH a tentativas de acesso nao autorizado.

## Estrutura dos arquivos
ssh-keys/
├── README.md
├── client.ssh_config
└── server.ssh_config

## Testes de validacao

### 1. Acesso utilizando a chave privada
Foi realizado o acesso ao servidor informando a chave privada e o usuario remoto.

- ssh -i ~/.ssh/id_ed25519_linux_valley -o IdentitiesOnly=yes server@192.168.1.3

Resultado esperado: conexao foi estabelecida com o servidor sem solicitar a senha da conta remota.

### 2. Acesso utilizando o alias SSH

Apos configurar o alias no cliente, foi feito o acesso utilizando o alias configurado.

- ssh linux-valley

Resultado esperado: conexao estabelecida com o servidor configurado no alias.
Tambem utilizamos o parametro -v para analisar as tapas da conexao via ssh, otima maneira para identificar possiveis falhas.

### 3. Validacao da autenticacao por chave publica

Foi realizado um teste desativando a autenticacao por chave publica e solicitando a autenticacao por senha.

- ssh -o PubkeyAuthentication=no -o PreferredAuthentications=password linux-valley

Resultado observado: acesso negado com a mensagem: Permission denied (publickey)
O resultado confirmou que a autenticacao por senha nao esta disponivel para essa conexao.

### Validacao do bloqueio do usuario root
Foi testado o acesso SSSH direto utilizando o usuario root e uma chave Ed25519
Resultado observado: acesso negado.

O teste confirma o bloqueio do login direto do root pela configuracao feita ao servidor.

## Conclusao

O laboratorio permitiu praticar a configuracao de acesso remoto seguro entre maquinas Linux, utilizando autenticacao por chave publica e configuracao de alias no cliente.
Tambem forma realizados testes para validar a desativacao da autenticacao por senha e o bloqueio do login direto do usuario root.
Esse tipo de atividade e importante para a administracao de servidores Linux, especialmente em ambientes de infra em que o SSH e utilizado para gerenciamento remoto e a manutencao de servicos.

