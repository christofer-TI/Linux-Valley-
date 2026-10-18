# NTP com Chrony

## Objetivo
Implementar um servico de sincronizacao de horario em uma rede local utilizando Chrony.
O Chrony e um software que implementa o protocolo NTP (Network Time Protocol), permitindo sincronizar e manter os relogios dos sistemas ajustados por meio de fontes de horario.
Neste laboratorio, foi configurado um servidor NTP para sincronizar com fontes externas e disponibilizar o servico para um cliente da rede local.

## Ambiente
- Sistema operacional: Ubuntu Server 24.04.5 LTS
- Servico: Chrony
- Protocolo: NTP
- Transporte: UDP
- Porta do servidor: 123/UDP
- Rede: 192.168.1.0/24

## Topologia
| Maquina | Endereco IP | Funcao |
|---|---|---|
| server2 | 192.168.1.3 | Servidor NTP |
| cliente | 192.168.1.4 | Cliente NTP |

Fluxo de sincronizacao:
- Fontes NTP externas -> server2 -> cliente

## Arquivos
- server-chrony.conf: configuracao de referencia do servidor.
- client-chrony.conf: configuracao de referencia do cliente.

## Configuracao

# Servidor
O servidor utiliza fontes NTP externas para sincronizar seu relogio e disponibiliza o servico para os clientes da rede local.
A diretiva `allow 192.168.1.0/24` permite que dispositivos dessa sub-rede consultem o servidor Chrony.

# Cliente
O cliente utiliza a diretiva 'server 192.168.1.3 iburst' para definir o servidor NTP responsavel pela sincronizacao.
A opcao 'iburst' acelera as consultas iniciais, auxiliando no estabelecimento da sincronizacao.

## Validacao

### Fontes de sincronizacao
- chronyc sources -v

O comando permite verificar as fontes de horario utilizadas pelo Chrony.
No cliente, o servidor 192.168.1.3 foi identificado pelo sinal ^*.

### Estado da sincronizacao
- chronyc tracking

Apresenta as informacoes sobre a fonte de referencia, o stratum, os desvios do relogio e o estado da sincronizacao.

## Analise do trafego NTP
No servidor foi utilizado o comando nc e o tcpdump para testarmos e ver a conexao entre cliente e servidor.
- nc -zvu 192.168.1.3 123
- sudo tchpdump -ni enp0s3 'udp port 123 and host 192.168.1.4'

A captura mostrou consultas do cliente para o servidor e as respostas obtidas, assim pudemos observar a comunicacao NTP pela rede.

## Troubleshooting 
Para simular uma interrupcao do servico, o Chrony foi parado no cliente:
- sudo systemctl stop chrony

Com o servico parado usei os comandos chronyc sources -v e chronyc tracking e tive de retorno o erro 506 Cannot talk to daemon, indicando que nao conseguiam se comunicar com o processo Chrony local, a partir disso poderiamos iniciar um trouble, mais complexo, se fosse o caso.
O servico foi iniciado novamente e o cliente voltou a consultar o servidor e constou sincronizacao ativa.

## Resultado
O laboratorio permitiu praticar a configuracao de um servidor NTP centralizado, a sincronizacao de um cliente, a verificacao do estado do Chrony, a analise de trafego UDP e o diagnostico de uma interrupcao de servico. 

