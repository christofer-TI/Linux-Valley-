# DNS Autoritativo - Atributos DNS e Zonas
###

1.OBJETIVO
Neste laboratorio configurei um servidor DNS autoritativo utilizando o BIND9.
O objetivo foi entender como funciona uma zona DNS, configurar seus principais atributos e criar registros para resolucao de nomes internos.
A zona utilizada foi linux-valley.
###

2.AMBIENTE
- Ubuntu Server 24.04.5 LTS
- BIND9
- VirtualBox
- Hostname: linux-valley-server
- Interface de laboratorio: enp0s8
- Rede: 192.168.10.0/24
- IP do servidor: 192.168.10.1
###

3.CONFIGURACAO DA ZONA
A zona linux-valley foi configurada no arquivo named.conf.local.

// Define a zona DNS que sera administrada por este servidor
zone "linux-valley" {

    // Define este servidor como master da zona
    type master;

    // Indica o arquivo que contem os registros da zona
    file "/etc/bind/db.linux-valley";
};

O arquivo da zona foi criado em:
- /etc/bind/db.linux-valley
###

4.REGISTROS DNS
A zona foi configurada com registros SOA, NS e A.

$TTL 86400

@ IN SOA srv.linux-valley. admin.linux-valley. (
    2026100401 ; Serial
    3600       ; Refresh
    1800       ; Retry
    604800     ; Expire
    86400      ; Negative Cache TTL
)

@ IN NS srv.linux-valley.

srv IN A 192.168.10.1
www IN A 192.168.10.1
intranet IN A 192.168.10.1

Registros criados:
- srv.linux-valley - 192.168.10.1
- www.linux-valley - 192.168.10.1
- intranet.linux-valley - 192.168.10.1
###

5.VALIDACAO
A configuracao do BIND foi validada utilizando:
sudo named-checkconf

O comando nao apresentou erros.
A zona tambem foi validada:
sudo named-checkzone linux-valley /etc/bind/db.linux-valley

Resultado:
zone linux-valley/IN: loaded serial 2026100401
OK
###

6.TESTES
Foi utilizado o dig para consultar diretamente o servidor DNS:

dig @192.168.10.1 srv.linux-valley
dig @192.168.10.1 www.linux-valley
dig @192.168.10.1 intranet.linux-valley

Os registros foram resolvidos corretamente para 192.168.10.1.
Tambem foi configurado o servidor para que o sistema utilizasse o DNS local, permitindo consultar os nomes sem informar diretamente o endereco IP do servidor DNS.
###

7.RESULTADO
Ao final do laboratorio, o BIND9 estava funcionando como servidor DNS autoritativo para a zona linux-valley.
Foi possivel criar a zona, definir o servidor autoritativo, configurar registros DNS e testar a resolucao dos nomes internos.
Este laboratorio representa a primeira etapa dos estudos de DNS no Linux-Valley. As proximas etapas serao voltadas para DNS Cache, integracao entre DNS autoritativo e cache e configuracao de DNS Slave.
###

