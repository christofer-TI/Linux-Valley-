# DNS Slave - BIND9

1.Objetivo
Configurar um servidor DNS Slave para receber e manter copias das zonas DNS do Master.
###

2.Ambiente
- Sistema operacional: Ubuntu Server 24.04 LTS
- Servico: BIND9
- Master: 192.168.1.3
- Slave: 192.168.1.2
###

3.Zonas configuradas
- linux-valley.com.br
- 1.168.192.in-addr.arpa
###

4.Configuracao
- named.conf.local: declaracao das zonas secundarias.
- named.conf.options: configuracoes gerais do servidor DNS.
###

5.Testes
A validacao sera realizada por meio de consultas DNS diretas e reversas, verificando as respostas do Slave.
###

6.Conceitos praticados
- DNS autoritativo
- Master e Slave
- Transferencia de zonas
- Resolucao direta e reversa
- BIND9
