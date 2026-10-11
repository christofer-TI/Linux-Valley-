# DNS Autoritativo - Master e Zonas DNS

1.OBJETIVO
Neste laboratorio configurei um servidor DNS autoritativo utilizando o BIND9.
O objetivo foi entender como funciona um servidor DNS Master, configurar zonas DNS e criar registros para resolucao direta e reversa de nomes.
A zona utilizada foi linux-valley.com.br.
###

2.AMBIENTE
- Ubuntu Server 24.04.5 LTS
- BIND9
- VirtualBox
- Servidor DNS Master: 192.168.1.3
- Servidor DNS Cache: 192.168.1.4
- Servidor DNS Slave: 192.168.1.35
- Cliente: 192.168.1.6
- Rede: 192.168.1.0/24
###

3.CONFIGURACAO DAS ZONAS
As zonas DNS foram declaradas no arquivo named.conf.local.

O servidor possui duas zonas:
- Zona direta: linux-valley.com.br
- Zona reversa: 1.168.192.in-addr.arpa

O arquivo named.conf.options contem as configuracoes gerais do BIND9, incluindo regras de acesso, encaminhamento de consultas e funcionamento do servidor.
Tambem configurei logs para acompanhar consultas DNS, eventos de seguranca, avisos e erros. Esses registros ajudam a identificar problemas e analisar o comportamento do servico.

Arquivos de configuracao:
- named.conf.options
- named.conf.local
- linux-valley.com.br.zone
- linux-valley.com.br.rev.zone
###

4.REGISTROS DNS
A zona direta possui registros SOA, NS e A.
O registro SOA contem informacoes administrativas da zona, enquanto os registros NS identificam os servidores DNS autoritativos.
Os registros A associam nomes DNS a enderecos IPv4.

Registros configurados:
- financeiro.linux-valley.com.br - 192.168.1.30
- marketing.linux-valley.com.br - 192.168.1.31
- master.linux-valley.com.br - 192.168.1.3
- slave.linux-valley.com.br - 192.168.1.35

O dominio raiz linux-valley.com.br tambem possui dois registros A, associados aos enderecos 192.168.1.3 e 192.168.1.35.
A zona reversa utiliza registros PTR para associar enderecos IP aos respectivos nomes DNS.

Registros configurados:
- 192.168.1.30 - financeiro.linux-valley.com.br
- 192.168.1.31 - marketing.linux-valley.com.br
- 192.168.1.3 - master.linux-valley.com.br
- 192.168.1.35 - slave.linux-valley.com.br
###

5.VALIDACAO
A configuracao do BIND9 pode ser verificada com:
- sudo named-checkconf

Para validar a zona direta no servidor Master:
- sudo named-checkzone linux-valley.com.br /var/cache/bind/linux-valley.com.br.zone

Para validar a zona reversa:
- sudo named-checkzone 1.168.192.in-addr.arpa /var/cache/bind/linux-valley.com.br.rev.zone

Esses comandos ajudam a identificar erros de sintaxe e problemas nos arquivos de zona.
###

6.TESTES DNS
Para consultar um registro diretamente no servidor Master:
- dig @192.168.1.3 financeiro.linux-valley.com.br

Para testar a resolucao reversa:
- dig @192.168.1.3 -x 192.168.1.30

A flag AA na resposta indica que o servidor forneceu uma resposta autoritativa para a consulta.
###

7.MONITORAMENTO DE LOGS
Configurei logs para acompanhar o funcionamento do BIND9 e facilitar a analise de problemas.
Para acompanhar as consultas DNS em tempo real:
- sudo tail -f /var/log/bind9/queries.log

Esse comando permite observar os registros gerados enquanto as consultas sao realizadas.
###

8.RESULTADO
Ao final deste laboratorio, configurei um servidor DNS autoritativo Master utilizando o BIND9.
Foi possivel trabalhar com zonas direta e reversa, criar registros DNS, compreender a resolucao de nomes e acompanhar os eventos do servico por meio de logs.
O ambiente faz parte de uma infraestrutura DNS composta por um servidor Master, um servidor Cache, um servidor Slave e um cliente.
O servidor Cache recebe consultas dos clientes e encaminha as consultas referentes a zona linux-valley.com.br para o Master. O Cache tambem pode armazenar respostas para reutilizacao, conforme sua configuracao.
A proxima etapa do laboratorio sera concluir a configuracao do DNS Slave e testar a transferencia de zonas entre os servidores.
