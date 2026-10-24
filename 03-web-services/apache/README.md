# Apache2 - Web Services

## Objetivo
Configurar um servidor web Apache2 no Ubuntu Server para hospedar dois sites diferentes utilizando Virtual Hosts, testar o acesso HTTP e analisar os logs do serviço.

## Ambiente
- Sistema operacional: Ubuntu Server 24.04.5 LTS
- Servidor web: Apache2
- Protocolo: HTTP
- Porta: 80/TCP
- IP do servidor: 192.168.1.2

## 1. Instalacao e verificacao
O Apache2 foi instalado e seu funcionamento foi verificado utilizando:

- sudo apt install apache2
- sudo systemctl status apache2

Para verificar a resposta HTTP do servidor:

- curl -I http://localhost/

O servidor retornou HTTP/1.1 200 OK, confirmando que a pagina estava sendo servida corretamente.

## 2. Pagina HTML
Foi criada uma pagina HTML personalizada em `/var/www/html/index.html`.
A pagina apresenta o nome Linux Valley e informacoes sobre o ambiente do laboratorio.

Permissoes utilizadas:

-rw-r--r-- root root index.html

Para verificar o conteudo servido:

- curl http://localhost/

Para verificar apenas os cabecalhos HTTP:

- curl -I http://localhost/

## 3. Logs e permissoes
Os principais arquivos de log utilizados foram:

- /var/log/apache2/access.log
- /var/log/apache2/error.log

O access.log registra as requisicoes recebidas e seus codigos de resposta. O error.log registra erros e outros eventos relevantes do Apache.

### Teste de erro 404
Foi realizada uma requisicao para uma pagina inexistente:

- curl -i http://localhost/pagina

O servidor retornou 404 Not Found, indicando que o recurso solicitado nao foi encontrado.

### Teste de erro 403
As permissoes da pagina foram alteradas temporariamente para impedir a leitura pelo Apache:

- sudo chmod 600 /var/www/html/index.html

A requisicao retornou 403 Forbidden, e o error.log registrou um erro de permissao.

As permissoes foram restauradas:

- sudo chmod 644 /var/www/html/index.html

O acesso voltou a funcionar normalmente.

## 4. Configuracao dos Virtual Hosts

Foram configurados dois sites no mesmo servidor Apache2, utilizando a porta 80/TCP. Cada Virtual Host possui um nome e um diretorio especifico para disponibilizar seu conteudo.

### Linux Valley
Diretorio do site:

- /var/www/linux-valley

Arquivo de configuracao no servidor:

- /etc/apache2/sites-available/linux-valley.conf

Arquivo de configuracao no laboratorio:

- linux-valley.conf

Pagina HTML:

- linux-valley.html

A pagina apresenta o titulo Linux Valley e informa que o site esta sendo servido pelo Virtual Host linux-valley.local.

### Intranet

Diretorio do site:

- /var/www/intranet

Arquivo de configuracao no servidor:

- /etc/apache2/sites-available/intranet.conf

Arquivo de configuracao no laboratorio:

- intranet.conf

Pagina HTML:

- intranet.html

A pagina apresenta o titulo Intranet e informa que o site esta sendo servido pelo Virtual Host intranet.local.

### Habilitacao dos sites

Os Virtual Hosts foram habilitados com:

- sudo a2ensite linux-valley.conf
- sudo a2ensite intranet.conf

A sintaxe das configuracoes foi validada com:

- sudo apache2ctl configtest

Resultado obtido:

- Syntax OK

As configuracoes foram aplicadas com:

- sudo systemctl reload apache2

Tambem foi configurado o ServerName global no arquivo /etc/apache2/apache2.conf para eliminar o aviso sobre o nome completo do servidor.

## 5. Testes locais
Os Virtual Hosts foram testados no proprio servidor utilizando o cabecalho HTTP Host.

### Linux Valley

- curl -i -H "Host: linux-valley.local" http://127.0.0.1/

### Intranet

- curl -i -H "Host: intranet.local" http://127.0.0.1/

Os dois sites retornaram 200 OK.

Tambem foi verificado o titulo de cada pagina:

- curl -s -H "Host: linux-valley.local" http://127.0.0.1/ | grep "<h1>"
- curl -s -H "Host: intranet.local" http://127.0.0.1/ | grep "<h1>"

Os resultados confirmaram que cada nome direcionava para o conteudo correto.

### Logs separados
Foram consultados os logs especificos dos sites:

- /var/log/apache2/linux-valley-access.log
- /var/log/apache2/linux-valley-error.log
- /var/log/apache2/intranet-access.log
- /var/log/apache2/intranet-error.log

Os logs de acesso registraram as requisicoes realizadas durante os testes.

## 6. Testes em outra maquina da mesma rede
Os testes foram realizados a partir de uma segunda maquina conectada a mesma rede local.

### Acesso pelo IP

- curl -I http://192.168.1.2/

Resultado:

- HTTP/1.1 200 OK

Esse teste confirmou que o servidor Apache estava acessivel pela rede local.

### Resolucao de nomes
No arquivo /etc/hosts da maquina cliente, foram adicionadas as seguintes entradas:

- 192.168.1.2 linux-valley.local intranet.local

Essa configuracao permitiu associar os nomes dos sites ao endereco IP do servidor.

### Acesso aos Virtual Hosts
Linux Valley:

- curl -I http://linux-valley.local/

Intranet:

- curl -I http://intranet.local/

Ambas as requisicoes retornaram 200 OK.

Os dois sites tambem foram acessados pelo navegador da maquina cliente, exibindo suas respectivas paginas HTML.

## 7. Resultados e limitacoes
Os testes confirmaram que:

- O Apache2 estava ativo e respondendo por HTTP.
- Os dois Virtual Hosts entregavam conteudos diferentes.
- Os logs registravam as requisicoes recebidas.
- Os erros 403 e 404 foram reproduzidos e diagnosticados.
- O acesso funcionava no proprio servidor e em outra maquina da mesma rede.
- A resolucao dos nomes foi configurada manualmente no arquivo /etc/hosts do cliente.

Nao foram realizados testes de acesso a partir de uma rede externa. Essa etapa ficou fora do escopo devido as limitacoes de infraestrutura e conectividade disponiveis no ambiente de laboratorio.
Portanto, o funcionamento foi validado na rede local, mas o acesso externo pela internet nao foi testado.

## Conclusao
O laboratorio permitiu praticar a configuracao do Apache2, a hospedagem de multiplos sites por Virtual Hosts, o gerenciamento de permissoes, a analise de logs e os testes de conectividade HTTP.
Tambem foi possivel verificar na pratica a diferenca entre a resolucao de nomes e a selecao do site pelo Apache.
Como proxima evolucao, a resolucao de nomes podera ser centralizada em um servidor DNS interno, evitando a necessidade de configurar manualmente o arquivo /etc/hosts de cada cliente.
