### Melhorias Futuras
Este documento contem as melhorias que estao planejadas para a evolucao do laboratorio de servidores de email, utilizando o Postfix e Dovecot.
O ambiente atual permite realizar o envio, recebimento, entrega local e leitura de mensagens. As proximas ideias tem como objetivo amplicar os recursos de seguranca, autenticacao e gerenciamento.
##

### Melhorias Planejadas

1. Certidicados TLS
Implementar uma autoridade certificadora para emitir certificados e estabelecer conexoes criptografadas confiaveis entre cliente e servidor.

2. Cliente de email
Integrar o servidor com o Thunderbird, permitindo gerenciar mensagens por uma interface grafica usando o SMTP e IMAP.

3. Gerenciamento de usuarios 
Criar usuarios adicionais, testar diferentes caixas postais e estudar permissoes e autenticacao.

4. Autenticacao SMTP com Dovecot
Integrar Postfix e Dovecot utilizando SASL, permitindo que o Postfix utilize o servico de autenticacao do Dovecot.

5. Seguranca e monitoramento 
Explorar controles de acesso, prevencao contra relay nao autorizado, analisar os logs e monitorar os servicos,

### Objetivo
Evoluir o laboratorio para uma infraestrutura de email completa, praticando administracao de servicos, autenticacao, seguranca e comunicacao em rede.
