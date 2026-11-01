### Integracao DNS, Nginx e Apache

## Objetivo
Neste laboratorio foi realizado a integracao de tres servicos de infraestrutura: DNS(BIND9), Nginx e Apache.
A ideia central foi montar um ambiente onde o cliente pudesse acessar uma aplicacao utilizando um dominino interno, isso sem precisar conhecer o endereco IP do servidor web.
O DNS ficou responsavel pela resolucao do dominio, o Nginx foi configurado para atuar como um proxy reservo, enquanto o Apache armazenava a aplicacao.

## Topologia
O laboratorio foi desenvolvido utilizando VMs no VirtualBox, com Ubuntu Server.

Maquina     Funcao                               Endereco IP
Cliente     Realizar requisicoes e testes        192.168.1.3
DNS         BIND9                                192.168.1.8
Proxy       Nginx                                192.168.1.6
Web01       Apache                               192.168.1.7

## Funcionalidade da infraestrutura
O acesso a aplicacao acontece na seguinte sequencia:

1. O cliente realiza uma request para http://app.linux-valley.test.
2. O DNS recebe a consulta e retorna o endereco IP do Nginx.
3. O cliente estabelece conexao com o Nginx.
4. O Nginx recebe a requisicao e encaminha para o Apache.
5. O Apache processa a request e retorna o conteudo da aplicaca.
6. O Nginx recebe a resposta e entrega o conteudo ao cliente.

## Servicos utilizados no lab

1. DNS - BIND9
O BIND9 foi configurado para realizar a resolucao de nomes dentro da rede local do lab.
Foi criada a zona linux-valley.test, contendo o registro utilizado para acessar a aplicacao.

Arquivo principal da zona:
/etc/bind/db.linux-valley.test

O dominio app.linux-valley.test foi configurado para apontar para o endereco IP do Nginx.

2. Nginx - Porxy reverso
O Nginx foi configurado para receber as requests HTTP destinadas a aplicacao e encaminhar todas para o server Apache.
O server funciona como um intermediario entre o cliente e o backend.

Servidor de destino:
192.168.1.7:80

Dessa forma o cliente nao precisa realizar uma conexao direta com o Apache.

## Apache - Servidor Web
O apaceh foi utilizado como servidor web backend para hospesar os arquivos da aplicacao.
O Nginx encaminha as requisicoes revebidas para esse server, que processa e retorna o conteudo da solicitacao.

## Teste de conectividade 
Verificacao da comunicacao entre as VMs.
ping 192.168.1.6
ping 192.168.1.7
ping 192.168.1.8

## Teste de resolucao DNS
Consulta ao dominio da aplicacao:
dig app.linux-valley.test

O resultado esperado e a resolucao do dominio para 192.168.1.6, endereco do nosso Nginx.

## Teste de acesso http
Requisicao realizada utilizando o dominio:
curl http://app.linux-valleu.test

O teste retornou o nosso conteudo HTML hospedado no Apache, passando pelo Nginx.

## Resultado
A integracao entre os tres servicos foi validada.
O cliente conseguiu acessar a aplicacao utilizando o dominio interno que criamos e sem precisar informar diretamente o endereco IP do server web.

## Aprendizado com o lab
Nessa a atividade foi possivel praticar:
- Configuracao de zonas DNS utulizando BIND9.
- Resolucao de nomes dentro de uma rede local.
- Configuracao de servidor web com Apache.
- Configuracao do Nginx como um proxy reverso. 
- Comunicacao entre servidores Linux.
- Intefracao de diferentes servicos para a infra.
- Testes de conectividade e requests HTTP.

## Conclusao
Neste laboratorio ajudou a entender e compreender como diferentes servicos de infraestrutura atuam em conjunto para disponibilizar uma aplicacao dentro de uma rede. Foi possivel acompanhar o caminho de uma request desde a resolucao com DNS e ate o responsavel por hospedar o conteudo, utilizando o Nginx como proxy reservo e o Apache como web server.

Apesar da atividade dar uma nocao de uma infra, o ambiente ainda possui limitacoes em relacao a uma infra de producao. A estrutura doi montada em uma rede local, utilizando poucas VMs e sem recursos de alta disponibilidade, redundancia, balanceamento de carga ou monitoramento centralizado.

A ideia para evoluir esse lab seria ampliar a infra, adicionando servidores DNS secundarios, multiplos servidores web, segmentacao de rede com VLANs, firewall dedicado, armazenamento compartilhado e ferramentas de monitoramento. Tambem seria legal implementar macanismos de backup, controle de acesso e testes de falhas entre os servicos.

Essa ativadade foi um primeiro contato para comecar a entender como esses componentes se relacionam em uma infra real e identidicar quais recursos seriam necessarios para construir um ambiente mais robusto, escalavel e proximo de um cenario de producao.

