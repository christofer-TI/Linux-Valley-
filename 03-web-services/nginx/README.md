# Nginx Web Server

## Objetivo
Configurar o Nginx para hospedar uma pagina HTML e permitir o acesso por um nome de site na rede local.

## Ambiente
- Sistema operacional: Ubuntu Server 24.04.5 LTS
- Servidor web: Nginx 1.24.0
- IP do servidor: 192.168.1.2
- Protocolo: HTTP
- Porta: 80/TCP
- Site: nginx.local

## 1. Instalacao e verificacao
Verificamos a versao instalada e o estado do servico:

- nginx -v
- sudo systemctl status nginx

Antes de aplicar as configuracoes, verificamos se havia erros de sintaxe:

- sudo nginx -t

O teste foi concluido sem erros.

## 2. Pagina HTML
Criamos o diretorio /var/www/nginx para armazenar os arquivos do site e adicionamos o arquivo index.html com informacoes sobre o projeto Linux Valley.
A pagina apresenta o nome do projeto, o ambiente utilizado e o servico web em funcionamento.

## 3. Configuracao do site
Criamos o arquivo de configuracao do site nginx.local em /etc/nginx/sites-available/.
Nele, definimos a porta 80, o nome do site, o diretorio raiz, a pagina inicial e os arquivos de log.
Depois, habilitamos o site com um link simbolico em /etc/nginx/sites-enabled/.
Validamos a configuracao e recarregamos o servico:

- sudo nginx -t
- sudo systemctl reload nginx

O arquivo nginx.conf deste repositorio contem a configuracao utilizada no laboratorio.

## 4. Logs e diagnostico
No primeiro teste, o acesso retornou 403 Forbidden. Ao verificar o diretorio do site, identificamos que o arquivo index.html ainda nao existia.
Como a listagem de diretorios estava desabilitada, o Nginx nao tinha uma pagina inicial para apresentar. Depois de criar o arquivo, o acesso passou a retornar 200 OK.
Tambem testamos o acesso a uma pagina inexistente, que retornou 404 Not Found.
Os logs utilizados foram:

- /var/log/nginx/nginx-access.log
- /var/log/nginx/nginx-error.log

Para consultar os registros:

- sudo tail -f /var/log/nginx/nginx-access.log
- sudo tail -f /var/log/nginx/nginx-error.log

## 5. Testes locais
Testamos a resposta HTTP diretamente no servidor:

- curl -I -H "Host: nginx.local" http://127.0.0.1/

O resultado foi 200 OK.

Para conferir o conteudo da pagina:

- curl -s -H "Host: nginx.local" http://127.0.0.1/ | grep -E '<title>|<h1>|<p>Servidor web'

O comando retornou o titulo e os elementos esperados da pagina.

Tambem verificamos uma rota inexistente:

- curl -I -H "Host: nginx.local" http://127.0.0.1/pagina-inexistente

O resultado foi 404 Not Found.

## 6. Testes pela rede local
No cliente, configuramos o nome nginx.local no arquivo /etc/hosts, apontando para o IP 192.168.1.2.

Verificamos a resolucao do nome:

- getent hosts nginx.local

Depois, testamos o acesso:

- curl -I http://nginx.local/
- curl http://nginx.local/

Os testes retornaram 200 OK, e a pagina tambem abriu no navegador do cliente.
Durante os testes, vimos que acessar diretamente o IP do servidor podia mostrar a pagina padrao, pois a requisicao nao informava o nome nginx.local. Ao utilizar o nome configurado, acessamos o site correto.

## 7. Resultado
O Nginx ficou funcionando como servidor web independente, servindo a pagina do Linux Valley tanto no proprio servidor quanto em outra maquina da rede.
Tambem praticamos a configuracao de um site, a consulta de logs e a identificacao de respostas HTTP 403, 404 e 200.
A configuracao do Nginx como reverse proxy integrado ao Apache ficara para um proximo laboratorio.
