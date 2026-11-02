# Squid Proxy

## Objetivo
Instalar e configurar o Squid para controlar o acesso à internet dos clientes da rede, utilizando regras de permissão e bloqueio por endereço IP e domínio.

## Ambiente
Máquina   Endereço IP     Função 
Cliente   192.168.1.3     Acesso à internet 
DNS       192.168.1.6     Servidor DNS |
Squid     192.168.1.7     Servidor Proxy 

- Sistema: Ubuntu Server 24.04
- Squid: 6.14
- Porta: 3128

## Configuração
O laboratório foi dividido em duas etapas, utilizando regras ACL para controlar os acessos.

### Etapa 1 - Bloqueio de domínios
Na primeira configuração, definimos alguns domínios que deveriam ser bloqueados, mantendo o acesso aos demais destinos para o cliente autorizado.
Domínios bloqueados:
- youtube.com
- youtu.be

## Testes realizados:
- Google: permitido.
- GitHub: permitido.
- YouTube: bloqueado.

Também testamos os acessos utilizando HTTPS.

### Etapa 2 - Lista de permissões (Allowlist)
Na segunda configuração, mudamos a regra. Em vez de bloquear domínios específicos, definimos quais seriam permitidos.

Cliente autorizado:
- 192.168.1.3

Domínios permitidos:
- google.com
- github.com

## Testes realizados:
- Cliente acessando Google: permitido.
- Cliente acessando GitHub: permitido.
- Cliente acessando YouTube: bloqueado.
- Cliente acessando Example: bloqueado.
- Servidor DNS (192.168.1.6) tentando acessar Google: bloqueado por não estar autorizado.

## Monitoramento
Durante os testes, acompanhamos as conexões pelo log do Squid:

sudo tail -f /var/log/squid/access.log

Com isso, conseguimos identificar quem estava realizando as requisições, qual destino estava sendo acessado e se a conexão foi permitida ou bloqueada.

Principais registros encontrados:

Registro               Significado 
TCP_TUNNEL/200         Conexão HTTPS estabelecida 
TCP_DENIED/403         Acesso bloqueado 
TCP_MISS/200           Requisição atendida sem utilizar objeto do cache 
TCP_MISS_ABORTED/000   Requisição interrompida 

## Conclusão
Neste laboratório, pratiquei a instalação e configuração do Squid, criando regras para controlar quais máquinas podem utilizar o proxy e quais domínios podem ser acessados.
Também trabalhei com testes HTTP e HTTPS e acompanhei os resultados diretamente nos logs do serviço.
O laboratório utiliza uma estrutura simples com três máquinas virtuais, mas permitiu entender na prática como funciona o controle de acesso por proxy em uma rede.
