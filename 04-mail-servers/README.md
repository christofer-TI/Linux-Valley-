### Mail Servers
Laboratorio pratico de configuracao de um servidor de e-mail utilizando Postfix e Dovecot em ambiente Linux.
O objetivo foi compreender o funcionamento dos servicos responsaveis pelo envio, recebimento, entrega e acesso às mensagens em uma rede local.

## Ambiente
| Maquina  | Servico            | Endereco IP |
| Servidor | Postfix + Dovecot  | 192.168.1.7 |
| Cliente  | Testes SMTP e IMAP | 192.168.1.3 |

## Tecnologias utilizadas
- Postfix: servidor SMTP responsavel pelo envio e recebimento de mensagens.
- Dovecot: servidor IMAP responsavel pelo acesso as caixas postais.
- PAM: autenticacao dos usuarios do sistema.
- OpenSSL: testes de conexao criptografada utilizando TLS.

## Funcionamento
O laboratorio foi desenvolvido utilizando dois servicos complementares:

### Postfix (SMTP)
Responsavel pelo transporte das mensagens. Foram realizadas configuracoes para recebimento de mensagens pela rede, entrega local nas caixas postais e retransmissao de mensagens utilizando um servidor SMTP externo.

### Dovecot (IMAP)
Responsavel pelo acesso as mensagens armazenadas pelo Postfix. Foi configurado para utilizar as caixas postais locais, autenticar usuarios atraves do PAM e disponibilizar conexões IMAP e IMAPS.

## Fluxo de comunicacao

VM Cliente
192.168.1.3
     |
     | SMTP
     v
Postfix (192.168.1.7)
     |
     | Entrega local
     v
/var/mail/vm
     |
     v
Dovecot (IMAP)
     |
     | IMAPS
     v
VM Cliente 

## Testes realizados
- Recebimento de mensagens atraves do SMTP.
- Entrega local das mensagens em /var/mail/vm.
- Testes de retransmissao SMTP utilizando servidor externo.
- Verificacao da autenticacao de usuarios atraves do PAM.
- Teste de conectividade nas portas TCP 143 e 993.
- Estabelecimento de conexao IMAPS utilizando OpenSSL.
- Consulta das caixas postais atraves de comandos IMAP.
- Leitura dos cabeçalhos e do conteudo das mensagens.

## Estrutura do projeto
04-mail-servers/
├── dovecot/
├── postfix/
├── MELHORIAS-FUTURAS.md
└── README.md

As configuracoes utilizadas em cada servico estao documentadas em seus respectivos diretorios.

## Conclusao
Com este laboratorio foi possivel compreender como o Postfix e o Dovecot trabalham em conjunto para fornecer serviços de e-mail.
A atividade permitiu praticar configuracao de servicos de rede, autenticacao de usuarios, entrega local de mensagens e acesso remoto utilizando IMAP com conexao criptografada.
O ambiente ainda possui melhorias planejadas relacionadas à seguranca, certificados TLS e integracao com clientes de e-mail, que serao desenvolvidas em etapas futuras.
