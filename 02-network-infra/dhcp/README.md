# DHCP

1.OBJETIVO
Praticar a configuracao de um servidor DHCP no Linux utilizando o `isc-dhcp-server`, realizando desde a preparacao da rede ate os testes do servico.

O cenario foi criado para praticar:
- configurar a interface de rede utilizando o Netplan;
- instalar e configurar um servidor DHCP;
- definir uma faixa de enderecos IP para os clientes;
- configurar mascara, gateway e DNS;
- iniciar e controlar o servico;
- validar a configuracao antes de iniciar o DHCP;
- testar a concessao de IP para um cliente;
- utilizar os logs para investigar problemas;
- entender como o DHCP pode ser utilizado futuramente em uma infraestrutura de homelab.
###

2.AMBIENTE
Sistema: Ubuntu Server 24.04.5 LTS
Hostname: linux-valley-server
Virtualizacao: VirtualBox
Utilizador: server2

Servico utilizado:
- isc-dhcp-server

Arquivos utilizados no laboratorio:
- /etc/dhcp/dhcpd.conf
- arquivo de configuracao do Netplan
###

3.CONFIGURACAO DA REDE
Antes de configurar o DHCP, preparei a interface de rede do servidor utilizando o Netplan.
O objetivo foi deixar a interface configurada corretamente para que o servidor pudesse participar da rede onde o DHCP seria utilizado.
A configuracao foi feita no arquivo de configuracao do Netplan.
Depois de realizar a configuracao, verifiquei as informacoes da interface utilizando:

- ip addr
- ip route

Essa etapa foi importante porque o servidor DHCP depende da configuracao correta da interface para conseguir se comunicar com os clientes.
###

4.INSTALACAO DO DHCP
Depois de preparar a rede, instalei o pacote:
- isc-dhcp-server

O isc-dhcp-server e responsavel por executar o servico DHCP no Ubuntu.
Depois da instalacao, passei para a configuracao do servidor.
###

5.CONFIGURACAO DO DHCP
A configuracao principal foi realizada no arquivo:
-/etc/dhcp/dhcpd.conf

Nesse arquivo foram definidos os parametros que o servidor utilizaria para atender os clientes.
Entre as configuracoes realizadas estavam:
- rede utilizada;
- mascara de rede;
- faixa de enderecos IP;
- gateway;
- servidores DNS;
- tempo de concessao.

Tambem foi necessario definir a interface que seria utilizada pelo servico DHCP.
A configuracao utilizada no laboratorio foi mantida no repositorio no arquivo:
- dhcpd.conf
###

6.VALIDACAO DA CONFIGURACAO
Antes de iniciar o servico, verifiquei se a configuracao do DHCP possuia erros de sintaxe.
Utilizei:
- sudo dhcpd -t -cf /etc/dhcp/dhcpd.conf

O objetivo dessa verificacao foi identificar problemas na configuracao antes de iniciar ou reiniciar o servico.
Essa etapa e importante porque um erro no dhcpd.conf pode impedir que o servidor DHCP seja iniciado corretamente.
###

7.GERENCIAMENTO DO SERVICO
Depois de configurar o DHCP, utilizei o systemd para controlar o servico.
Para verificar o estado do DHCP:
- systemctl status isc-dhcp-server

Tambem utilizei os comandos do systemctl para iniciar, parar e reiniciar o servico durante os testes.
O objetivo foi praticar o gerenciamento de um servico de infraestrutura utilizando o systemd.
###

8.TESTE DE CONCESSAO DE IP
Depois de confirmar que o servico estava funcionando, realizei o teste utilizando um cliente configurado para obter um endereco IP automaticamente.
O objetivo era verificar se o cliente conseguia solicitar uma configuracao de rede e receber as informacoes fornecidas pelo servidor DHCP.
O processo pode ser representado de forma simplificada:

Cliente
   |
   | DHCPDISCOVER
   v
Servidor DHCP
   |
   | DHCPOFFER
   v
Cliente
   |
   | DHCPREQUEST
   v
Servidor DHCP
   |
   | DHCPACK
   v
Cliente configurado

Depois da concessao, verifiquei no cliente se as informacoes de rede haviam sido recebidas corretamente.
Tambem utilizei comandos de rede para verificar o endereco IP e as rotas.
###

9.ANALISE DOS LOGS
Durante os testes, utilizei os logs para acompanhar o funcionamento do servico.
Para consultar os registros do DHCP:
- journalctl -u isc-dhcp-server

Os logs ajudam a identificar se o servico esta recebendo solicitacoes e se existe algum problema durante o processo de concessao do endereco.
Essa etapa tambem foi importante para praticar uma forma de troubleshooting que pode ser utilizada em outros servicos do Linux.
###

10.RESULTADO
- configuramos a interface de rede do servidor;
- instalamos o `isc-dhcp-server`;
- configuramos o `dhcpd.conf`;
- definimos os parametros que seriam entregues aos clientes;
- validamos a configuracao do DHCP;
- iniciamos e gerenciamos o servico utilizando o systemd;
- testamos a concessao de um endereco IP;
- verificamos a configuracao de rede do cliente;
- utilizamos os logs para acompanhar o funcionamento do servico.
###

11.CONCLUSAO
Este laboratorio foi importante para entender melhor como o DHCP funciona e como ele pode ser configurado em um servidor Linux.
Na pratica, consegui passar pelo processo de configuracao da rede, instalacao do servico, configuracao do DHCP, validacao e teste com o cliente.
O principal aprendizado foi entender o DHCP como um servico de infraestrutura e praticar sua configuracao e gerenciamento no Linux.
Esse conhecimento sera utilizado como base para os proximos laboratorios de infraestrutura e, futuramente, para a construcao do homelab.
###

12.CONTEXTO FUTURO DO HOMELAB
Este laboratorio tambem faz parte da ideia de construir futuramente um homelab proprio, utilizando os conhecimentos praticados no Linux Valley.
A ideia e ter um servidor fisico utilizando uma plataforma de virtualizacao como o Proxmox, permitindo criar diferentes ambientes e maquinas virtuais de acordo com cada necessidade.
Uma possibilidade seria utilizar uma solucao como o OPNsense para cuidar de parte da infraestrutura de rede, firewall, roteamento, VLANs e DHCP. Assim o conhecimento praticado neste laboratorio poderia ser aplicado em uma estrutura mais completa.
O homelab teria tanto uma finalidade de estudo quanto de uso pessoal. Uma parte seria para os laboratorios de Linux, redes, Docker, cloud e Kubernetes, permitindo testar configuracoes e servicos em um ambiente controlado.
Outra parte poderia ser utilizada para hospedar servicos pessoais, servidores de jogos e armazenamento de fotos e outros arquivos.
A ideia e que o servidor nao seja apenas um ambiente para guardar arquivos, mas uma infraestrutura propria onde seria possivel aprender, testar e utilizar servicos no dia a dia.
Este laboratorio de DHCP representa uma das etapas dessa preparacao, ajudando a entender como um servico de infraestrutura pode ser configurado e posteriormente integrado a um homelab mais completo.

