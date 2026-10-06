# DNS Cache - Configuracao e Testes

1.OBJETIVO
Neste laboratorio configurei um servidor DNS Cache utilizando o BIND9.
O objetivo foi entender como funciona o cache DNS e configurar servidores DNS externos para receber consultas que ainda nao possuem resposta armazenada.
###

2.AMBIENTE
- Ubuntu Server 24.04.5 LTS
- BIND9
- VirtualBox
- Hostname: linux-valley-server
- Interface de laboratorio: enp0s8
- Rede: 192.168.10.0/24
- IP do servidor: 192.168.10.
###

3.CONFIGURACAO
A configuracao foi realizada no arquivo /etc/bind/named.conf.options.
Foram definidos dois servidores DNS como forwarders:

forwarders {
    8.8.8.8;
    1.1.1.1;
};

Os forwarders sao utilizados quando o servidor nao possui a resposta solicitada em cache.
###

4.VALIDACAO
A configuracao foi validada utilizando:

- sudo named-checkconf

O comando nao apresentou erros.
O servico BIND9 foi reiniciado apos a alteracao.
###

5.TESTE
Foi realizada uma consulta externa utilizando:

- dig @192.168.10.1 google.com

A primeira consulta apresentou aproximadamente 300 msec.
Nas consultas seguintes, o tempo foi de 0 msec, indicando que a resposta estava sendo obtida do cache.
O TTL tambem diminuiu a cada consulta, demonstrando o tempo restante da resposta armazenada.
###

6.RESULTADO
Ao final do laboratorio, o BIND9 estava funcionando como DNS Cache e utilizando 8.8.8.8 e 1.1.1.1 como forwarders.
O teste demonstrou na pratica a diferenca entre uma consulta que precisa ser encaminhada e uma consulta respondida pelo cache local.
###
